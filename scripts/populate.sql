---------------------
-- Category
---------------------
INSERT INTO category
VALUES ('Bolachas'),
    ('Bolachas de Chocolate'),
    ('Fruta'),
    ('Bebidas'),
    ('Sumos Naturais'),
    ('Sumo de Laranja Natural'),
    ('Vinho'),
    ('Cerveja Artesanal'),
    ('Sagres'),
    ('Água'),
    ('Sumo de Manga'),
    ('Sumo que existe'),
    ('Cerveja');
---------------------
-- Super Category
---------------------
INSERT INTO super_category
VALUES ('Bolachas'),
    ('Bebidas'),
    ('Sumos Naturais'),
    ('Cerveja');
---------------------
-- Simple Category
---------------------
INSERT INTO simple_category
VALUES ('Bolachas de Chocolate'),
    ('Sumo de Laranja Natural'),
    ('Fruta'),
    ('Vinho'),
    ('Cerveja Artesanal'),
    ('Sagres'),
    ('Água'),
    ('Sumo de Manga'),
    ('Sumo que existe');
---------------------
-- Has Other
---------------------
INSERT INTO has_other
VALUES ('Bolachas', 'Bolachas de Chocolate'),
    ('Bebidas', 'Sumos Naturais'),
    ('Bebidas', 'Cerveja'),
    ('Bebidas', 'Água'),
    ('Bebidas', 'Vinho'),
    ('Cerveja', 'Cerveja Artesanal'),
    ('Cerveja', 'Sagres'),
    ('Sumos Naturais', 'Sumo de Laranja Natural'),
    ('Sumos Naturais', 'Sumo de Manga'),
    ('Sumos Naturais', 'Sumo que existe');
---------------------
-- Product
---------------------
INSERT INTO product
VALUES ('1111111111111', 'Bolachas de Chocolate', 'Oreo'),
    ('1111111111112', 'Sumo de Laranja Natural', 'Capri-Sun'),
    ('1111111111113', 'Fruta', 'Maçã'),
    ('1111111111114', 'Bolachas', 'Bolacha Maria');
---------------------
-- Has Category
---------------------
INSERT INTO has_category
VALUES ('1111111111111', 'Bolachas de Chocolate'),
    ('1111111111112', 'Sumo de Laranja Natural'),
    ('1111111111113', 'Fruta'),
    ('1111111111114', 'Bolachas');
---------------------
-- IVM
---------------------
INSERT INTO ivm
VALUES ('ivm-1', 'fizz'),
    ('ivm-2', 'fizz'),
    ('ivm-3', 'fizz'),
    ('ivm-4', 'fizz'),
    ('ivm-5', 'fizz'),
    ('ivm-6', 'fizz'),
    ('ivm-7', 'fizz'),
    ('ivm-8', 'fizz'),
    ('ivm-9', 'fizz'),
    ('ivm-10', 'fizz'),
    ('ivm-11', 'fizz'),
    ('ivm-12', 'fizz'),
    ('ivm-13', 'fizz'),
    ('ivm-1', 'buzz'),
    ('ivm-2', 'buzz'),
    ('ivm-3', 'buzz'),
    ('ivm-4', 'buzz'),
    ('ivm-5', 'buzz'),
    ('ivm-6', 'buzz'),
    ('ivm-7', 'buzz'),
    ('ivm-8', 'buzz'),
    ('ivm-9', 'buzz'),
    ('ivm-10', 'buzz'),
    ('ivm-11', 'buzz'),
    ('ivm-12', 'buzz');
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
VALUES (
        '1',
        'ivm-1',
        'fizz',
        '2',
        'Bolachas de Chocolate'
    ),
    ('3', 'ivm-1', 'fizz', '2', 'Fruta'),
    ('2', 'ivm-2', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-2', 'fizz', '3', 'Bolachas');
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
        69,
        'Cima'
    ),
    (
        '1111111111113',
        '3',
        'ivm-1',
        'fizz',
        '2',
        9,
        'Baixo'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '3',
        10,
        'Meio'
    ),
    (
        '1111111111114',
        '3',
        'ivm-2',
        'fizz',
        '3',
        15,
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
    ('6', 'Jesus'),
    ('7', 'One Man Army');
---------------------
-- Responsible For
---------------------
INSERT INTO responsible_for
VALUES ('Bolachas', '3', 'ivm-1', 'fizz'),
    ('Bolachas de Chocolate', '3', 'ivm-1', 'buzz'),
    ('Fruta', '3', 'ivm-2', 'fizz'),
    ('Sumos Naturais', '3', 'ivm-3', 'fizz'),
    ('Sumos Naturais', '3', 'ivm-6', 'fizz'),
    ('Sumo de Laranja Natural', '3', 'ivm-2', 'buzz'),
    ('Bolachas', '5', 'ivm-3', 'buzz'),
    ('Bolachas de Chocolate', '5', 'ivm-4', 'fizz'),
    ('Fruta', '5', 'ivm-4', 'buzz'),
    ('Sumo de Laranja Natural', '5', 'ivm-5', 'fizz'),
    ('Sumo de Laranja Natural', '5', 'ivm-6', 'buzz'),
    ('Fruta', '1', 'ivm-5', 'buzz'),
    ('Bolachas de Chocolate', '7', 'ivm-7', 'fizz'),
    ('Sumo de Laranja Natural', '7', 'ivm-7', 'buzz'),
    ('Fruta', '7', 'ivm-8', 'fizz'),
    ('Vinho', '7', 'ivm-8', 'buzz'),
    ('Cerveja Artesanal', '7', 'ivm-9', 'fizz'),
    ('Sagres', '7', 'ivm-9', 'buzz'),
    ('Água', '7', 'ivm-10', 'fizz'),
    ('Sumo de Manga', '7', 'ivm-10', 'buzz'),
    ('Sumo que existe', '7', 'ivm-11', 'fizz');
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
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-06-17 22:19:16',
        '4',
        '3'
    ),
    (
        '1111111111113',
        '3',
        'ivm-1',
        'fizz',
        '2022-08-09 19:54:21',
        '7',
        '3'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '2022-11-09 14:54:21',
        '7',
        '1'
    ),
    (
        '1111111111114',
        '3',
        'ivm-2',
        'fizz',
        '2022-06-09 15:54:21',
        '8',
        '2'
    ),
    (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-06-16 18:37:21',
        '35',
        '3'
    );
