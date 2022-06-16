#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request

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
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = request.form["query"]
        cursor.execute(query)
        return render_template("query.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


@app.route("/ask_simple")
def ask_simple():
    try:
        return render_template("ask_simple.html")
    except Exception as e:
        return str(e)


@app.route("/insert_simple", methods=["POST"])
def insert_simple():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        name = request.form["name"]
        query = """
            INSERT INTO category (name) VALUES (%s);
            INSERT INTO simple_category (name) VALUES (%s);
            """
        data = (name, name)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


@app.route("/ask_super")
def ask_super():
    try:
        return render_template("ask_super.html")
    except Exception as e:
        return str(e)


@app.route("/insert_super", methods=["POST"])
def insert_super():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        name = request.form["name"]
        query = """
            INSERT INTO category (name) VALUES (%s);
            INSERT INTO super_category (name) VALUES (%s);
            """
        data = (name, name)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


@app.route("/ask_list")
def ask_list():
    return render_template("ask_list.html", params=request.args)


@app.route("/list_sub_categories", methods=["POST"])
def list_sub_categories():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        super_category = request.form["super_category"]
        query = """
            WITH RECURSIVE list_recurs(super_category, category) AS (
                SELECT super_category, category
                FROM has_other
                WHERE super_category = %s
                UNION ALL
                SELECT child.super_category, child.category
                FROM has_other AS child
                    INNER JOIN list_recurs AS parent ON child.super_category = parent.category
            ) SELECT category AS sub_categories FROM list_recurs;
            """
        data = (super_category,)
        cursor.execute(query, data)
        return render_template(
            "list_sub_categories.html",
            cursor=cursor,
            params=request.args,
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/ask_retailer")
def ask_retailer():
    try:
        return render_template("ask_retailer.html")
    except Exception as e:
        return str(e)


@app.route("/insert_retailer", methods=["POST"])
def insert_retailer():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        tin = request.form["tin"]
        name = request.form["name"]
        query = "INSERT INTO retailer (tin, name) VALUES (%s, %s);"
        data = (tin, name)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


@app.route("/category")
def list_category():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT name FROM category;"
        cursor.execute(query)
        return render_template("category.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/simple_category")
def list_simple_category():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT name FROM simple_category;"
        cursor.execute(query)
        return render_template(
            "simple_category.html", cursor=cursor, params=request.args
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/super_category")
def list_super_category():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT name FROM super_category;"
        cursor.execute(query)
        return render_template(
            "super_category.html", cursor=cursor, params=request.args
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/has_other")
def list_has_other():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT super_category, category FROM has_other;"
        cursor.execute(query)
        return render_template(
            "query.html", cursor=cursor, params={"title": "has_other"}
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/product")
def list_product():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT ean, category, description FROM product;"
        cursor.execute(query)
        return render_template("product.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/has_category")
def list_has_category():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT ean, name FROM has_category;"
        cursor.execute(query)
        return render_template("has_category.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/ivm")
def list_ivm():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT serial_num, manuf FROM ivm;"
        cursor.execute(query)
        return render_template("ivm.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/retail_point")
def list_retail_point():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT name, district, county FROM retail_point;"
        cursor.execute(query)
        return render_template("retail_point.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/installed_on")
def list_installed_on():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT serial_num, manuf, local FROM installed_on;"
        cursor.execute(query)
        return render_template("installed_on.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/shelf")
def list_shelf():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT number, serial_num, manuf, height, name FROM shelf;"
        cursor.execute(query)
        return render_template("shelf.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/planogram")
def list_planogram():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = """
            SELECT ean, number, serial_num, manuf, face, units, loc
            FROM planogram;
            """
        cursor.execute(query)
        return render_template("planogram.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/retailer")
def list_retailer():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT tin, name FROM retailer;"
        cursor.execute(query)
        return render_template("retailer.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/responsible_for")
def list_responsible_for():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT cat_name, tin, serial_num, manuf FROM responsible_for;"
        cursor.execute(query)
        return render_template(
            "responsible_for.html", cursor=cursor, params=request.args
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/replenishment_event")
def list_replenishment_event():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT ean, number, serial_num, manuf, instant, units, tin FROM replenishment_event;"
        cursor.execute(query)
        return render_template(
            "replenishment_event.html",
            cursor=cursor,
            params=request.args,
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route("/ivm_values")
def ivm_values():

    return render_template("ivm_values.html", params=request.args)


@app.route("/list_replenishment_event_ivm", methods=["POST"])
def list_replenishment_event_ivm():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        serial_num = request.form["serial_num"]
        manuf = request.form["manuf"]
        query = """
            SELECT ean, number, serial_num, manuf, instant, units, tin
            FROM replenishment_event
            WHERE serial_num = %s AND manuf = %s;
            """
        data = (serial_num, manuf)
        cursor.execute(query, data)
        return render_template(
            "list_replenishment_event_ivm.html",
            cursor=cursor,
            params=request.args,
        )
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


CGIHandler().run(app)
