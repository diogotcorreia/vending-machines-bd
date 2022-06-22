import random
import string

## Libs postgres
import psycopg2
import psycopg2.extras

## DBMS configs
DB_HOST = "localhost"
DB_USER = "postgres"
DB_DATABASE = "postgres"
DB_PASSWORD = "postgres"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (
    DB_HOST,
    DB_DATABASE,
    DB_USER,
    DB_PASSWORD,
)


###############
#    Utils    #
###############


def random_string(size):
    return "".join(random.choice(string.ascii_letters) for i in range(size))


def query1():
    SIZE = 100000

    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        ivm_query = f"""
        INSERT INTO ivm (serial_num, manuf) VALUES
        {','.join("(%s, %s)" for i in range(SIZE))};
        """
        ivm_data = tuple(
            sum(
                (
                    (random_string(15), f"manuf-{random_string(10)}")
                    for i in range(SIZE)
                ),
                (),
            )
        )

        retailer_query = f"""
        INSERT INTO retailer (tin, name) VALUES
        {','.join("(%s, %s)" for i in range(SIZE))};
        """
        retailer_data = tuple(
            sum(((random_string(10), random_string(10)) for i in range(SIZE)), ())
        )

        responsible_for_query = f"""
        INSERT INTO responsible_for (cat_name, tin, serial_num, manuf) VALUES
        {','.join("('Bolachas de Chocolate', %s, %s, %s)" for i in range(SIZE))};
        """
        responsible_for_data = tuple(
            sum(
                (
                    (retailer_data[2 * i], ivm_data[2 * i], ivm_data[2 * i + 1])
                    for i in range(SIZE)
                ),
                (),
            )
        )

        cursor.execute(ivm_query, ivm_data)
        cursor.execute(retailer_query, retailer_data)
        cursor.execute(responsible_for_query, responsible_for_data)
    except Exception as e:
        raise e
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


def query2():
    SIZE = 100000
    SIZE_CAT = 25000
    SIZE_PROD = 25000

    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        cat_query = f"""
        INSERT INTO category (name) VALUES
        {','.join("(%s)" for i in range(SIZE_CAT))};
        """
        cat_data = tuple(random_string(12) for i in range(SIZE_CAT))

        print("Generated categories")

        product_query = f"""
        INSERT INTO product (ean, category, description) VALUES
        {','.join("(%s, %s, %s)" for i in range(SIZE_PROD))};
        """
        product_data = tuple(
            sum(
                (
                    (
                        random_string(13),
                        random.choice(cat_data),
                        f"A{random_string(13)}"
                        if random.random() <= 0.5
                        else random_string(14),
                    )
                    for i in range(SIZE_PROD)
                ),
                (),
            )
        )

        print("Generated products")

        has_cat_query = f"""
        INSERT INTO has_category (ean, name) VALUES
        {','.join("(%s, %s)" for i in range(SIZE))}
        ON CONFLICT DO NOTHING;
        """
        has_cat_data = tuple(
            sum(
                (
                    (
                        product_data[3 * random.randint(0, SIZE_PROD - 1)],
                        random.choice(cat_data),
                    )
                    for i in range(SIZE)
                ),
                (),
            )
        )

        print("Generated has_category")

        cursor.execute(cat_query, cat_data)
        cursor.execute(product_query, product_data)
        cursor.execute(has_cat_query, has_cat_data)
    except Exception as e:
        raise e
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


# query1()
query2()
