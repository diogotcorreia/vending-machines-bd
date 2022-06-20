#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect
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


@app.route("/insert_query", methods=["POST"])
def insert_query():
    query = request.form["query"]
    return exec_query(
        query,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="User Query", query=query
        ),
    )


@app.route("/insert_simple", methods=["GET"])
def ask_simple():
    try:
        return render_template(
            "ask_input.html",
            title="Insert Simple Category",
            fields=(
                {
                    "label": "New Simple Category Name:",
                    "name": "name",
                },
            ),
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/insert_simple", methods=["POST"])
def insert_simple():
    return exec_query(
        """
        INSERT INTO category (name) VALUES (%s);
        INSERT INTO simple_category (name) VALUES (%s);
        """,
        lambda cursor: redirect("./simple_category"),
        data_from_request(("name", "name")),
    )


@app.route("/insert_super", methods=["GET"])
def ask_super():
    try:
        return render_template(
            "ask_input.html",
            title="Insert Super Category",
            fields=(
                {
                    "label": "New Super Category Name:",
                    "name": "name",
                },
            ),
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/insert_super", methods=["POST"])
def insert_super():
    return exec_query(
        """
        INSERT INTO category (name) VALUES (%s);
        INSERT INTO super_category (name) VALUES (%s);
        """,
        lambda cursor: redirect("./super_category"),
        data_from_request(("name", "name")),
    )


@app.route("/list_sub_categories", methods=["GET"])
def list_sub_categories():
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
            title="List Sub-Categories",
            page_actions=({"title": "Back", "link": "./super_category"},),
        ),
        data_from_http_query(("super_category",)),
    )


@app.route("/insert_retailer", methods=["GET"])
def ask_retailer():
    try:
        return render_template(
            "ask_input.html",
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


@app.route("/insert_retailer", methods=["POST"])
def insert_retailer():
    return exec_query(
        """
        INSERT INTO retailer (tin, name) VALUES (%s, %s);
        """,
        lambda cursor: redirect("./retailer"),
        data_from_request(("tin", "name")),
    )


@app.route("/category")
def list_category():
    return exec_query(
        """
        SELECT name FROM category;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Category",
            row_actions=(
                {
                    "className": "remove",
                    "link": lambda record: f"./delete_category?{urlencode({'category': record[0]})}",
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Simple Category", "link": "./insert_simple"},
                {"title": "Insert Super Category", "link": "./insert_super"},
            ),
        ),
    )


@app.route("/simple_category")
def list_simple_category():
    return exec_query(
        """
        SELECT name FROM simple_category;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Simple Category",
            row_actions=(
                {
                    "className": "remove",
                    "link": lambda record: f"./delete_category?{urlencode({'category': record[0]})}",
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Simple Category", "link": "./insert_simple"},
            ),
        ),
    )


@app.route("/super_category")
def list_super_category():
    return exec_query(
        """
        SELECT name FROM super_category;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="Super Category",
            row_actions=(
                {
                    "className": "list",
                    "link": lambda record: f"./list_sub_categories?{urlencode({'super_category': record[0]})}",
                    "name": "List Sub-Categories",
                },
                {
                    "className": "remove",
                    "link": lambda record: f"./delete_category?{urlencode({'category': record[0]})}",
                    "name": "Remove",
                },
            ),
            page_actions=(
                {"title": "Insert Super Category", "link": "./insert_super"},
            ),
        ),
    )


@app.route("/has_other")
def list_has_other():
    return exec_query(
        """
        SELECT super_category, category FROM has_other;
        """,
        lambda cursor: render_template("query.html", cursor=cursor, title="Has Other"),
    )


@app.route("/product")
def list_product():
    return exec_query(
        """
        SELECT ean AS "EAN", category, description FROM product;
        """,
        lambda cursor: render_template("query.html", cursor=cursor, title="Product"),
    )


@app.route("/has_category")
def list_has_category():
    return exec_query(
        """
        SELECT ean AS "EAN", name AS category_name FROM has_category;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Has Category"
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
                    "link": lambda record: f"./list_replenishment_event_ivm?{urlencode({'serial_num': record[0], 'manuf': record[1]})}",
                    "name": "List Replenishment Events",
                },
            ),
        ),
    )


@app.route("/retail_point")
def list_retail_point():
    return exec_query(
        """
        SELECT name, district, county FROM retail_point;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Retail Point"
        ),
    )


@app.route("/installed_on")
def list_installed_on():
    return exec_query(
        """
        SELECT serial_num AS serial_number, manuf AS manufacturer, local FROM installed_on;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Installed On"
        ),
    )


@app.route("/shelf")
def list_shelf():
    return exec_query(
        """
        SELECT number, serial_num AS serial_number, manuf AS manufacturer, height, name FROM shelf;
        """,
        lambda cursor: render_template("query.html", cursor=cursor, title="Shelf"),
    )


@app.route("/planogram")
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
                    "link": lambda record: f"./delete_retailer?{urlencode({'tin': record[0]})}",
                    "name": "Remove",
                },
            ),
            page_actions=({"title": "Insert Retailer", "link": "./insert_retailer"},),
        ),
    )


@app.route("/responsible_for")
def list_responsible_for():
    return exec_query(
        """
        SELECT cat_name AS category_name, tin AS "TIN", serial_num AS serial_number, manuf AS manufacturer
        FROM responsible_for;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Responsible For"
        ),
    )


@app.route("/replenishment_event")
def list_replenishment_event():
    return exec_query(
        """
        SELECT ean AS "EAN", number, serial_num AS serial_number, manuf AS manufacturer, instant, units, tin AS "TIN"
        FROM replenishment_event;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, title="Replenishment Event"
        ),
    )


@app.route("/list_replenishment_event_ivm", methods=["GET"])
def list_replenishment_event_ivm():
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
        ),
        data_from_http_query(("serial_num", "manuf")),
    )


@app.route("/sales", methods=["GET"])
def list_sales():
    return exec_query(
        """
        SELECT ean AS "EAN", name, year, quarter, day_month, day_week, district, county, units
        FROM sales;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            title="View Past Sales",
        ),
    )


@app.route("/delete_category", methods=["GET"])
def confirm_delete_category():
    category = request.args["category"]
    try:
        return render_template(
            "confirm_delete.html",
            title=f"Delete Category '{category}'?",
            data={"category": category},
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/delete_category", methods=["POST"])
def delete_category():
    return exec_query(
        """
        DELETE FROM has_other WHERE category = %s;
        DELETE FROM super_category WHERE name = %s;
        DELETE FROM simple_category WHERE name = %s;
        DELETE FROM category WHERE name = %s;
        """,
        lambda cursor: redirect("./category"),
        data_from_request(("category", "category", "category", "category")),
    )


@app.route("/delete_retailer", methods=["GET"])
def confirm_delete_retailer():
    tin = request.args["tin"]
    try:
        return render_template(
            "confirm_delete.html",
            title=f"Delete Retailer with TIN '{tin}'?",
            data={"tin": tin},
        )
    except Exception as e:
        return render_template("error_page.html", error=e)


@app.route("/delete_retailer", methods=["POST"])
def delete_retailer():
    return exec_query(
        """
        DELETE FROM retailer WHERE tin = %s;
        """,
        lambda cursor: redirect("./retailer"),
        data_from_request(("tin",)),
    )


###############
#    Utils    #
###############


def exec_query(query, outcome, data=()):
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cursor.execute(query, data)
        return outcome(cursor)
    except Exception as e:
        return render_template("error_page.html", error=e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


def data_from_request(fields):
    return tuple(map(lambda field: request.form[field], fields))


def data_from_http_query(fields):
    return tuple(map(lambda field: request.args[field], fields))


CGIHandler().run(app)
