#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect, url_for
from urllib.parse import urlencode

## Libs postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST = "db"
DB_USER = "postgres"
DB_DATABASE = "postgres"
DB_PASSWORD = "postgres"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (
    DB_HOST,
    DB_DATABASE,
    DB_USER,
    DB_PASSWORD,
)


## Runs the function once the root page is requested.
## The request comes with the folder structure setting ~/web as the root
@app.route("/")
def homepage():
    try:
        return render_template("index.html")
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/user-query", methods=["POST"])
def insert_query():
    query = request.form["query"]
    return exec_query(
        query,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="User Query", query=query
        ),
    )


@app.route("/category/insert", methods=["GET"])
def ask_category():
    return exec_query(
        """
        SELECT name FROM category
        ORDER BY name;
        """,
        lambda cursor: render_template(
            "ask_input.html",
            action_url=url_for("insert_category"),
            title="Insert Category",
            fields=(
                {
                    "label": "New Category Name:",
                    "name": "name",
                },
                {
                    "label": "Parent Category:",
                    "name": "parent_category",
                    "type": "select",
                    "required": False,
                    "options": ((record[0], record[0]) for record in cursor),
                },
            ),
        ),
    )


@app.route("/category/insert", methods=["POST"])
def insert_category():
    query = """
        INSERT INTO category (name) VALUES (%s);
        """
    fields = ("name", "name")
    if request.form["parent_category"]:
        query += """
        INSERT INTO has_other (super_category, category) VALUES (%s, %s);
        """
        fields += ("parent_category", "name")
    return exec_query(
        query,
        lambda cursor: redirect(url_for("list_category")),
        data_from_request(fields),
    )


@app.route("/category/<string:category>/change-parent", methods=["GET"])
def ask_change_parent_category(category):
    def first_or_none(result):
        return result[0] if result else None

    return exec_queries(
        (
            """
            SELECT name FROM category
            WHERE name != %s
            ORDER BY name;
            """,
            """
            SELECT super_category FROM has_other
            WHERE category = %s;
            """,
        ),
        lambda cursors: render_template(
            "ask_input.html",
            action_url=url_for("change_parent_category"),
            title="Change Parent of Category",
            fields=(
                {
                    "label": "",
                    "name": "name",
                    "type": "hidden",
                    "value": category,
                },
                {
                    "label": "Parent Category:",
                    "name": "parent_category",
                    "type": "select",
                    "required": False,
                    "options": ((record[0], record[0]) for record in cursors[0]),
                    "selected": first_or_none(cursors[1].fetchone()),
                },
            ),
        ),
        (
            (category,),
            (category,),
        ),
    )


@app.route("/category/change-parent", methods=["POST"])
def change_parent_category():
    query = """
        DELETE FROM has_other WHERE category = %s;
        """
    fields = ("name",)
    if request.form["parent_category"]:
        query = """
        INSERT INTO has_other (super_category, category) VALUES (%s, %s)
        ON CONFLICT (category) DO UPDATE SET super_category = %s;
        """
        fields = ("parent_category", "name", "parent_category")
    return exec_query(
        query,
        lambda cursor: redirect(url_for("list_category")),
        data_from_request(fields),
    )


@app.route("/category/<string:super_category>/list-children", methods=["GET"])
def list_sub_categories(super_category):
    return exec_query(
        """
        WITH RECURSIVE list_recurs(super_category, category) AS (
            SELECT super_category, category
            FROM has_other
            WHERE super_category = %s
            UNION ALL
            SELECT child.super_category, child.category
            FROM has_other AS child
                INNER JOIN list_recurs AS parent ON child.super_category = parent.category
        ) SELECT category AS sub_categories FROM list_recurs;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title=f"List Sub-Categories of '{super_category}'",
            page_actions=({"title": "Back", "link": url_for("list_super_category")},),
        ),
        (super_category,),
    )


@app.route("/retailer/insert", methods=["GET"])
def ask_retailer():
    try:
        return render_template(
            "ask_input.html",
            action_url=url_for("insert_retailer"),
            title="Insert Retailer",
            fields=(
                {
                    "label": "New Retailer TIN:",
                    "name": "tin",
                },
                {
                    "label": "New Retailer Name:",
                    "name": "name",
                },
            ),
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/retailer/insert", methods=["POST"])
def insert_retailer():
    return exec_query(
        """
        INSERT INTO retailer (tin, name) VALUES (%s, %s);
        """,
        lambda cursor: redirect(url_for("list_retailer")),
        data_from_request(("tin", "name")),
    )


@app.route("/category")
def list_category():
    return exec_query(
        """
        (
            SELECT 'Simple' AS type, name, super_category AS parent_category
            FROM simple_category
                LEFT OUTER JOIN has_other ON has_other.category = simple_category.name
            UNION
            SELECT 'Super' AS type, name, super_category AS parent_category
            FROM super_category
                LEFT OUTER JOIN has_other ON has_other.category = super_category.name
        ) ORDER BY name;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Category",
            chips={0: {"Simple": "#219ebc", "Super": "#fb8500"}},
            row_actions=(
                {
                    "className": "list",
                    "link": lambda record: url_for(
                        "ask_change_parent_category", category=record[1]
                    ),
                    "name": "Set Parent Category",
                },
                {
                    "className": "remove",
                    "link": lambda record: url_for(
                        "confirm_delete_category", category=record[1]
                    ),
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Category", "link": url_for("ask_category")},
            ),
            page_top_actions=(
                {
                    "title": "Show All Categories",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Only Simple Categories",
                    "link": url_for("list_simple_category"),
                },
                {
                    "title": "Only Super Categories",
                    "link": url_for("list_super_category"),
                },
                {
                    "title": "Has Other",
                    "link": url_for("list_has_other"),
                },
            ),
        ),
    )


@app.route("/category/simple")
def list_simple_category():
    return exec_query(
        """
        SELECT name FROM simple_category
        ORDER BY name;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Simple Category",
            row_actions=(
                {
                    "className": "remove",
                    "link": lambda record: url_for(
                        "confirm_delete_category", category=record[0]
                    ),
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Category", "link": url_for("ask_category")},
            ),
            page_top_actions=(
                {
                    "title": "Show All Categories",
                    "link": url_for("list_category"),
                },
                {
                    "title": "Only Simple Categories",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Only Super Categories",
                    "link": url_for("list_super_category"),
                },
                {
                    "title": "Has Other",
                    "link": url_for("list_has_other"),
                },
            ),
        ),
    )


@app.route("/category/super")
def list_super_category():
    return exec_query(
        """
        SELECT name FROM super_category
        ORDER BY name;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Super Category",
            row_actions=(
                {
                    "className": "list",
                    "link": lambda record: url_for(
                        "list_sub_categories", super_category=record[0]
                    ),
                    "name": "List Sub-Categories",
                },
                {
                    "className": "remove",
                    "link": lambda record: url_for(
                        "confirm_delete_category", category=record[0]
                    ),
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Category", "link": url_for("ask_category")},
            ),
            page_top_actions=(
                {
                    "title": "Show All Categories",
                    "link": url_for("list_category"),
                },
                {
                    "title": "Only Simple Categories",
                    "link": url_for("list_simple_category"),
                },
                {
                    "title": "Only Super Categories",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Has Other",
                    "link": url_for("list_has_other"),
                },
            ),
        ),
    )


@app.route("/category/has-other")
def list_has_other():
    return exec_query(
        """
        SELECT super_category, category FROM has_other
        ORDER BY super_category, category;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Has Other",
            page_top_actions=(
                {
                    "title": "Show All Categories",
                    "link": url_for("list_category"),
                },
                {
                    "title": "Only Simple Categories",
                    "link": url_for("list_simple_category"),
                },
                {
                    "title": "Only Super Categories",
                    "link": url_for("list_super_category"),
                },
                {
                    "title": "Has Other",
                    "link": "#",
                    "active": True,
                },
            ),
        ),
    )


@app.route("/product")
def list_product():
    return exec_query(
        """
        SELECT ean AS "EAN", category, description FROM product;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Product",
            page_top_actions=(
                {
                    "title": "Product",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Has Category",
                    "link": url_for("list_has_category"),
                },
            ),
        ),
    )


@app.route("/product/has-category")
def list_has_category():
    return exec_query(
        """
        SELECT ean AS "EAN", name AS category_name FROM has_category;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Has Category",
            page_top_actions=(
                {
                    "title": "Product",
                    "link": url_for("list_product"),
                },
                {
                    "title": "Has Category",
                    "link": "#",
                    "active": True,
                },
            ),
        ),
    )


@app.route("/ivm")
def list_ivm():
    return exec_query(
        """
        SELECT serial_num AS serial_number, manuf AS manufacturer FROM ivm;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="IVM",
            row_actions=(
                {
                    "className": "list",
                    "link": lambda record: url_for(
                        "list_replenishment_event_ivm",
                        serial_num=record[0],
                        manuf=record[1],
                    ),
                    "name": "List Replenishment Events",
                },
            ),
            page_top_actions=(
                {
                    "title": "IVM",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Installed On",
                    "link": url_for("list_installed_on"),
                },
                {
                    "title": "Shelf",
                    "link": url_for("list_shelf"),
                },
            ),
        ),
    )


@app.route("/retail-point")
def list_retail_point():
    return exec_query(
        """
        SELECT name, district, county FROM retail_point;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Retail Point"
        ),
    )


@app.route("/ivm/installed-on")
def list_installed_on():
    return exec_query(
        """
        SELECT serial_num AS serial_number, manuf AS manufacturer, local FROM installed_on;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Installed On",
            page_top_actions=(
                {
                    "title": "IVM",
                    "link": url_for("list_ivm"),
                },
                {
                    "title": "Installed On",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Shelf",
                    "link": url_for("list_shelf"),
                },
            ),
        ),
    )


@app.route("/ivm/shelf")
def list_shelf():
    return exec_query(
        """
        SELECT number, serial_num AS serial_number, manuf AS manufacturer, height, name FROM shelf;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Shelf",
            page_top_actions=(
                {
                    "title": "IVM",
                    "link": url_for("list_ivm"),
                },
                {
                    "title": "Installed On",
                    "link": url_for("list_installed_on"),
                },
                {
                    "title": "Shelf",
                    "link": "#",
                    "active": True,
                },
            ),
        ),
    )


@app.route("/product/planogram")
def list_planogram():
    return exec_query(
        """
        SELECT ean AS "EAN", number, serial_num AS serial_number, manuf AS manufacturer, face, units, loc
        FROM planogram;
        """,
        lambda cursor: render_template("query.html", cursor=cursor, title="Planogram"),
    )


@app.route("/retailer")
def list_retailer():
    return exec_query(
        """
        SELECT tin AS "TIN", name FROM retailer;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Retailer",
            row_actions=(
                {
                    "className": "remove",
                    "link": lambda record: url_for(
                        "confirm_delete_retailer", tin=record[0]
                    ),
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Retailer", "link": url_for("ask_retailer")},
            ),
            page_top_actions=(
                {
                    "title": "Retailer",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Responsible For",
                    "link": url_for("list_responsible_for"),
                },
                {
                    "title": "Replenishment Event",
                    "link": url_for("list_replenishment_event"),
                },
            ),
        ),
    )


@app.route("/retailer/responsible-for")
def list_responsible_for():
    return exec_query(
        """
        SELECT cat_name AS category_name, tin AS "TIN", serial_num AS serial_number, manuf AS manufacturer
        FROM responsible_for;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Responsible For",
            page_top_actions=(
                {
                    "title": "Retailer",
                    "link": url_for("list_retailer"),
                },
                {
                    "title": "Responsible For",
                    "link": "#",
                    "active": True,
                },
                {
                    "title": "Replenishment Event",
                    "link": url_for("list_replenishment_event"),
                },
            ),
        ),
    )


@app.route("/ivm/replenishment-event")
def list_replenishment_event():
    return exec_query(
        """
        SELECT ean AS "EAN", number, serial_num AS serial_number, manuf AS manufacturer, instant, units, tin AS "TIN"
        FROM replenishment_event;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Replenishment Event",
            page_top_actions=(
                {
                    "title": "Retailer",
                    "link": url_for("list_retailer"),
                },
                {
                    "title": "Responsible For",
                    "link": url_for("list_responsible_for"),
                },
                {
                    "title": "Replenishment Event",
                    "link": "#",
                    "active": True,
                },
            ),
        ),
    )


@app.route(
    "/ivm/<string:serial_num>/<string:manuf>/replenishment-event", methods=["GET"]
)
def list_replenishment_event_ivm(serial_num, manuf):
    return exec_query(
        """
        SELECT ean AS "EAN", name AS category_name, number, serial_num AS serial_number,
            manuf as manufacturer, instant, SUM(units) AS total_units, tin AS "TIN"
        FROM replenishment_event
        NATURAL JOIN has_category
        WHERE serial_num = %s AND manuf = %s
        GROUP BY GROUPING SETS((ean, name, number, serial_num, manuf, instant, tin), name)
        ORDER BY (name)
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="List Replenishment Events of IVM",
            page_actions=({"title": "Back", "link": url_for("list_ivm")},),
        ),
        (serial_num, manuf),
    )


@app.route("/sales", methods=["GET"])
def list_sales():
    return exec_query(
        """
        SELECT ean AS "EAN", category_name, year, quarter, month, day_month, day_week, district, county, units
        FROM sales;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="View Past Sales",
        ),
    )


@app.route("/category/<string:category>/delete", methods=["GET"])
def confirm_delete_category(category):
    try:
        return render_template(
            "confirm_delete.html",
            action_url=url_for("delete_category"),
            title=f"Delete Category '{category}'?",
            data={"category": category},
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/category/delete", methods=["POST"])
def delete_category():
    return exec_query(
        """
        DELETE FROM has_other WHERE category = %s OR super_category = %s;
        DELETE FROM super_category WHERE name = %s;
        DELETE FROM simple_category WHERE name = %s;
        DELETE FROM category WHERE name = %s;
        """,
        lambda cursor: redirect(url_for("list_category")),
        data_from_request(("category", "category", "category", "category", "category")),
    )


@app.route("/retailer/<string:tin>/delete", methods=["GET"])
def confirm_delete_retailer(tin):
    try:
        return render_template(
            "confirm_delete.html",
            action_url=url_for("delete_retailer"),
            title=f"Delete Retailer with TIN '{tin}'?",
            data={"tin": tin},
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/retailer/delete", methods=["POST"])
def delete_retailer():
    return exec_query(
        """
        DELETE FROM replenishment_event WHERE tin = %s;
        DELETE FROM responsible_for WHERE tin = %s;
        DELETE FROM retailer WHERE tin = %s;
        """,
        lambda cursor: redirect(url_for("list_retailer")),
        data_from_request(("tin", "tin", "tin")),
    )


###############
#    Utils    #
###############


def exec_query(query, outcome, data=None):
    return exec_queries((query,), lambda cursors: outcome(cursors[0]), (data,))


def exec_queries(queries, outcome, data):
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursors = []
        for query, query_data in zip(queries, data):
            cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
            cursor.execute(query, query_data)
            cursors.append(cursor)
        return outcome(cursors)
    except Exception as e:
        return render_template("error_page.html", error=e)
    finally:
        dbConn.commit()
        for cursor in cursors:
            cursor.close()
        dbConn.close()


def data_from_request(fields):
    return tuple(map(lambda field: request.form[field], fields))


CGIHandler().run(app)
