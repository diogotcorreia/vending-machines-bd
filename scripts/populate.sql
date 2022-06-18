---------------------
-- Category
---------------------
INSERT INTO category
VALUES ('Bolachas'),
    ('Bolachas de Chocolate'),
    ('Fruta'),
    ('Armas'),
    ('Semi-Auto'),
    ('Snipers'),
    ('Rockets'),
    ('SMG'),
    ('AR'),
    ('Lasers'),
    ('Pistols'),
    ('Shotguns'),
    ('Full-Auto');
---------------------
-- Super Category
---------------------
INSERT INTO super_category
VALUES ('Bolachas'),
    ('Armas'),
    ('Semi-Auto'),
    ('Full-Auto');
---------------------
-- Simple Category
---------------------
INSERT INTO simple_category
VALUES ('Bolachas de Chocolate'),
    ('Snipers'),
    ('Fruta'),
    ('Rockets'),
    ('SMG'),
    ('AR'),
    ('Lasers'),
    ('Pistols'),
    ('Shotguns');
;
---------------------
-- Has Other 
---------------------
INSERT INTO has_other
VALUES ('Bolachas', 'Bolachas de Chocolate'),
    ('Armas', 'Semi-Auto'),
    ('Armas', 'Full-Auto'),
    ('Armas', 'Lasers'),
    ('Armas', 'Rockets'),
    ('Full-Auto', 'SMG'),
    ('Full-Auto', 'AR'),
    ('Semi-Auto', 'Snipers'),
    ('Semi-Auto', 'Pistols'),
    ('Semi-Auto', 'Shotguns');
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
    ('3', 'ivm-1', 'fizz', '2', 'Fruta'),
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
        '1111111111113',
        '3',
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
---------------------
-- Responsible For
---------------------
INSERT INTO responsible_for
VALUES ('Bolachas', '3', 'ivm-1', 'fizz'),
    ('Bolachas de Chocolate', '3', 'ivm-1', 'fizz'),
    ('Fruta', '3', 'ivm-1', 'fizz'),
    ('Semi-Auto', '3', 'ivm-3', 'fizz'),
    ('Snipers', '3', 'ivm-1', 'fizz'),
    ('Bolachas', '5', 'ivm-2', 'fizz'),
    ('Bolachas de Chocolate', '5', 'ivm-2', 'fizz'),
    ('Fruta', '5', 'ivm-3', 'fizz'),
    ('Snipers', '5', 'ivm-2', 'fizz'),
    ('Fruta', '1', 'ivm-1', 'fizz');
----------------------
-- Replenishment Event
----------------------
INSERT INTO replenishment_event
VALUES (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-06-09 18:34:21',
        '6',
        '3'
    ),
    (
        '1111111111113',
        '3',
        'ivm-1',
        'fizz',
        '2022-08-09 19:54:21',
        '7',
        '2'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '2022-11-09 14:54:21',
        '7',
        '3'
    );
