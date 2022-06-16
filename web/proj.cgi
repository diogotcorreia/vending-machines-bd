#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect

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
    return render_template("index.html")


@app.route("/insert_query", methods=["POST"])
def insert_query():
    return exec_query(
        request.form["query"],
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": request.form["query"]}
        ),
    )


@app.route("/ask_simple")
def ask_simple():
    try:
        return render_template("ask_simple.html")
    except Exception as e:
        return str(e)


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


@app.route("/ask_super")
def ask_super():
    try:
        return render_template("ask_super.html")
    except Exception as e:
        return str(e)


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


@app.route("/ask_list")
def ask_list():
    return render_template("ask_list.html", params=request.args)


@app.route("/list_sub_categories", methods=["POST"])
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
            "query.html", cursor=cursor, params={"title": "List Sub-Categories"}
        ),
        data_from_request(("super_category",)),
    )


@app.route("/ask_retailer")
def ask_retailer():
    try:
        return render_template("ask_retailer.html")
    except Exception as e:
        return str(e)


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
            "category.html", cursor=cursor, params={"title": "category"}
        ),
    )


@app.route("/simple_category")
def list_simple_category():
    return exec_query(
        """
        SELECT name FROM simple_category;
        """,
        lambda cursor: render_template(
            "simple_category.html", cursor=cursor, params={"title": "Simple Category"}
        ),
    )


@app.route("/super_category")
def list_super_category():
    return exec_query(
        """
        SELECT name FROM super_category;
        """,
        lambda cursor: render_template(
            "super_category.html", cursor=cursor, params={"title": "Super Category"}
        ),
    )


@app.route("/has_other")
def list_has_other():
    return exec_query(
        """
        SELECT super_category, category FROM has_other;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Has Other"}
        ),
    )


@app.route("/product")
def list_product():
    return exec_query(
        """
        SELECT ean, category, description FROM product;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Product"}
        ),
    )


@app.route("/has_category")
def list_has_category():
    return exec_query(
        """
        SELECT ean, name FROM has_category;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Has Category"}
        ),
    )


@app.route("/ivm")
def list_ivm():
    return exec_query(
        """
        SELECT serial_num, manuf FROM ivm;
        """,
        lambda cursor: render_template(
            "ivm.html", cursor=cursor, params={"title": "IVM"}
        ),
    )


@app.route("/retail_point")
def list_retail_point():
    return exec_query(
        """
        SELECT name, district, county FROM retail_point;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Retail Point"}
        ),
    )


@app.route("/installed_on")
def list_installed_on():
    return exec_query(
        """
        SELECT serial_num, manuf, local FROM installed_on;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Installed On"}
        ),
    )


@app.route("/shelf")
def list_shelf():
    return exec_query(
        """
        SELECT number, serial_num, manuf, height, name FROM shelf;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Shelf"}
        ),
    )


@app.route("/planogram")
def list_planogram():
    return exec_query(
        """
        SELECT ean, number, serial_num, manuf, face, units, loc
        FROM planogram;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Planogram"}
        ),
    )


@app.route("/retailer")
def list_retailer():
    return exec_query(
        """
        SELECT tin, name FROM retailer;
        """,
        lambda cursor: render_template(
            "retailer.html", cursor=cursor, params={"title": "Retailer"}
        ),
    )


@app.route("/responsible_for")
def list_responsible_for():
    return exec_query(
        """
        SELECT cat_name, tin, serial_num, manuf FROM responsible_for;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Responsible For"}
        ),
    )


@app.route("/replenishment_event")
def list_replenishment_event():

    return exec_query(
        """
        SELECT ean, number, serial_num, manuf, instant, units, tin FROM replenishment_event;
        """,
        lambda cursor: render_template(
            "query.html", cursor=cursor, params={"title": "Replenishment Event"}
        ),
    )


@app.route("/ivm_values")
def ivm_values():

    return render_template("ivm_values.html", params=request.args)


@app.route("/list_replenishment_event_ivm", methods=["POST"])
def list_replenishment_event_ivm():
    return exec_query(
        """
        SELECT ean, number, serial_num, manuf, instant, units, tin
        FROM replenishment_event
        WHERE serial_num = %s AND manuf = %s;
        """,
        lambda cursor: render_template(
            "query.html",
            cursor=cursor,
            params={"title": "List Replenishment Events of IVM"},
        ),
        data_from_request(("serial_num", "manuf")),
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
        return render_template("error.html", error=e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


def data_from_request(fields):
    return tuple(map(lambda field: request.form[field], fields))


CGIHandler().run(app)
