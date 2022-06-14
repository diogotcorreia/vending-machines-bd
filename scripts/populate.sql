---------------------
-- Category
---------------------
INSERT INTO category
VALUES ('Bolachas'),
    ('Bolachas de Chocolate'),
    ('Fruta'),
    ('Armas'),
    ('Semi-Auto'),
    ('Snipers');
---------------------
-- Super Category
---------------------
INSERT INTO super_category
VALUES ('Bolachas'),
    ('Armas'),
    ('Semi-Auto');
---------------------
-- Simple Category
---------------------
INSERT INTO simple_category
VALUES ('Bolachas de Chocolate'),
    ('Snipers'),
    ('Fruta');
---------------------
-- Has Other 
---------------------
INSERT INTO has_other
VALUES ('Bolachas', 'Bolachas de Chocolate'),
    ('Armas', 'Semi-Auto'),
    ('Semi-Auto', 'Snipers');
---------------------
-- Product
---------------------
INSERT INTO product
VALUES ('1111111111111', 'Bolachas de Chocolate', 'Oreo'),
    ('1111111111112', 'Snipers', 'AWP'),
    ('1111111111113', 'Fruta', 'Maçã'),
    ('1111111111114', 'Bolachas', 'Bolacha Maria');
---------------------
-- Has Category
---------------------
INSERT INTO has_category
VALUES ('1111111111111', 'Bolachas de Chocolate'),
    ('1111111111112', 'Snipers'),
    ('1111111111113', 'Fruta'),
    ('1111111111114', 'Bolachas');
---------------------
-- IVM
---------------------
INSERT INTO ivm
VALUES ('ivm-1', 'fizz'),
    ('ivm-2', 'fizz'),
    ('ivm-3', 'fizz'),
    ('ivm-1', 'buzz'),
    ('ivm-2', 'buzz'),
    ('ivm-3', 'buzz');
----------------------
-- Retail Point
----------------------
INSERT INTO retail_point
VALUES ('Frigu', 'Lisbon', 'RNL'),
    ('Galp', 'Oporto', 'Matosinhos'),
    ('ALDI', 'Algarve', 'Altura');
----------------------
-- Installed On
----------------------
INSERT INTO installed_on
VALUES ('ivm-1', 'fizz', 'Frigu'),
    ('ivm-2', 'buzz', 'Frigu'),
    ('ivm-2', 'fizz', 'Galp'),
    ('ivm-3', 'buzz', 'Galp'),
    ('ivm-3', 'fizz', 'ALDI'),
    ('ivm-1', 'buzz', 'ALDI');
----------------------
-- Shelf
----------------------
INSERT INTO shelf
VALUES ('1', 'ivm-1', 'fizz', '2', 'Bolachas'),
    ('2', 'ivm-1', 'fizz', '2', 'Fruta'),
    ('2', 'ivm-2', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-2', 'fizz', '3', 'Snipers');
----------------------
-- Planogram
----------------------
INSERT INTO planogram
VALUES (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2',
        '2',
        'Cima'
    ),
    (
        '1111111111112',
        '2',
        'ivm-1',
        'fizz',
        '2',
        '1',
        'Baixo'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '3',
        '1',
        'Meio'
    ),
    (
        '1111111111114',
        '3',
        'ivm-2',
        'fizz',
        '3',
        '1',
        'Meio'
    );
----------------------
-- Retailer
----------------------
INSERT INTO retailer
VALUES ('1', 'Diogo'),
    ('2', 'John'),
    ('3', 'Tom'),
    ('4', 'Rafael'),
    ('5', 'Tiago'),
    ('6', 'Jesus');