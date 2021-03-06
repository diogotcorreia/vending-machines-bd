---------------------
-- Category
---------------------
INSERT INTO category
VALUES ('Bolachas'),
    ('Bolachas de Chocolate'),
    ('Fruta'),
    ('Bebidas'),
    ('Refrigerantes'),
    ('Sumos Naturais'),
    ('Sumo de Laranja Natural'),
    ('Vinho'),
    ('Cerveja Artesanal'),
    ('Sagres'),
    ('Agua'),
    ('Sumo de Manga'),
    ('Sumo que existe'),
    ('Cerveja'),
    ('Snacks'),
    ('Skittles'),
    ('Cachorros Quentes'),
    ('Salgados'),
    ('Batatas Fritas'),
    ('Batatas Pala-Pala'),
    ('Lays'),
    ('Ruffles'),
    ('Sun Chips'),
    ('Batatas Palha'),
    ('Doritos'),
    ('Cheetos'),
    ('Chips Ahoy'),
    ('Coca-Cola'),
    ('Pepsi'),
    ('Fanta'),
    ('Sprite'),
    ('Coca-Cola Zero'),
    ('Pepsi Zero'),
    ('Gatorade'),
    ('Powerade'),
    ('Guarana'),
    ('Guarana Antarctica'),
    ('Mascaras'),
    ('Mascaras N95'),
    ('Mascaras N99'),
    ('Mascaras KN95'),
    ('Mascaras default'),
    ('Mascaras de pano'),
    ('Tabaco'),
    ('Marlboro'),
    ('Lucky Strike'),
    ('Newport'),
    ('Camel'),
    ('Kentucky'),
    ('Chesterfield'),
    ('Chesterfield II'),
    ('Chocolates'),
    ('Chocolates Barra'),
    ('Chocolates Tablete'),
    ('Snickers'),
    ('Milka'),
    ('Milka Light'),
    ('KitKat'),
    ('Twix'),
    ('Mars'),
    ('M&Ms'),
    ('Lion');
---------------------
-- Super Category
---------------------
INSERT INTO super_category
VALUES ('Bolachas'),
    ('Bolachas de Chocolate'),
    ('Bebidas'),
    ('Refrigerantes'),
    ('Sumos Naturais'),
    ('Cerveja'),
    ('Snacks'),
    ('Salgados'),
    ('Batatas Fritas'),
    ('Batatas Pala-Pala'),
    ('Coca-Cola'),
    ('Pepsi'),
    ('Guarana'),
    ('Mascaras'),
    ('Mascaras default'),
    ('Tabaco'),
    ('Chocolates'),
    ('Chocolates Barra'),
    ('Chocolates Tablete'),
    ('Milka');
---------------------
-- Simple Category
---------------------
-- Inserting into category is, with the aid of category_must_be_specialized_trigger,
-- inserted by default into simple_category whenever it's inserted as a category.
-- Therefore, populating the relation here is irrelevant.
---------------------
-- Has Other
---------------------
INSERT INTO has_other
VALUES ('Bolachas', 'Bolachas de Chocolate'),
    ('Bolachas de Chocolate', 'Chips Ahoy'),
    ('Bebidas', 'Sumos Naturais'),
    ('Bebidas', 'Cerveja'),
    ('Bebidas', 'Agua'),
    ('Bebidas', 'Vinho'),
    ('Cerveja', 'Cerveja Artesanal'),
    ('Cerveja', 'Sagres'),
    ('Sumos Naturais', 'Sumo de Laranja Natural'),
    ('Sumos Naturais', 'Sumo de Manga'),
    ('Sumos Naturais', 'Sumo que existe'),
    ('Snacks', 'Skittles'),
    ('Snacks', 'Cachorros Quentes'),
    ('Snacks', 'Salgados'),
    ('Salgados', 'Batatas Fritas'),
    ('Salgados', 'Batatas Pala-Pala'),
    ('Salgados', 'Batatas Palha'),
    ('Batatas Pala-Pala', 'Lays'),
    ('Batatas Pala-Pala', 'Ruffles'),
    ('Batatas Pala-Pala', 'Sun Chips'),
    ('Batatas Pala-Pala', 'Doritos'),
    ('Batatas Pala-Pala', 'Cheetos'),
    ('Bebidas', 'Refrigerantes'),
    ('Refrigerantes', 'Coca-Cola'),
    ('Refrigerantes', 'Pepsi'),
    ('Refrigerantes', 'Fanta'),
    ('Refrigerantes', 'Sprite'),
    ('Coca-Cola', 'Coca-Cola Zero'),
    ('Coca-Cola', 'Pepsi Zero'),
    ('Refrigerantes', 'Gatorade'),
    ('Refrigerantes', 'Powerade'),
    ('Refrigerantes', 'Guarana'),
    ('Guarana', 'Guarana Antarctica'),
    ('Mascaras', 'Mascaras default'),
    ('Mascaras', 'Mascaras de pano'),
    ('Mascaras default', 'Mascaras N95'),
    ('Mascaras default', 'Mascaras N99'),
    ('Mascaras default', 'Mascaras KN95'),
    ('Tabaco', 'Marlboro'),
    ('Tabaco', 'Lucky Strike'),
    ('Tabaco', 'Newport'),
    ('Tabaco', 'Camel'),
    ('Tabaco', 'Kentucky'),
    ('Tabaco', 'Chesterfield'),
    ('Tabaco', 'Chesterfield II'),
    ('Chocolates', 'Chocolates Barra'),
    ('Chocolates', 'Chocolates Tablete'),
    ('Chocolates Barra', 'Snickers'),
    ('Chocolates Tablete', 'Milka'),
    ('Milka', 'Milka Light'),
    ('Chocolates Barra', 'KitKat'),
    ('Chocolates Barra', 'Twix'),
    ('Chocolates Barra', 'Mars'),
    ('Chocolates Barra', 'M&Ms'),
    ('Chocolates Barra', 'Lion');
---------------------
-- Product
---------------------
INSERT INTO product
VALUES ('1111111111111', 'Bolachas de Chocolate', 'Oreo'),
    (
        '1111111111112',
        'Sumo de Laranja Natural',
        'Capri-Sun'
    ),
    ('1111111111113', 'Fruta', 'Maca'),
    ('1111111111114', 'Bolachas', 'Bolacha Maria'),
    (
        '1111111111115',
        'Bebidas',
        'Chris''s Secret Stuff'
    ),
    ('1111111111116', 'Bebidas', 'Lobos'),
    ('1111111111117', 'Bebidas', '818 Tequila'),
    ('1111111111118', 'Cerveja', 'Corona'),
    ('1111111111119', 'Cerveja', 'Budweiser'),
    ('1111111111120', 'Cerveja', 'Duff'),
    (
        '1111111120000',
        'Cerveja Artesanal',
        'Fantastica'
    ),
    ('1111111111121', 'Vinho', 'Tinto'),
    ('1111111111122', 'Vinho', 'Branco'),
    ('1111111111123', 'Vinho', 'Rose'),
    ('1111111111124', 'Vinho', 'Horrivel'),
    ('1111111111125', 'Vinho', 'Tracadinho'),
    ('1111111111126', 'Agua', 'Fiji'),
    ('1111111111127', 'Agua', 'Dasani'),
    ('1111111111128', 'Agua', 'Evian'),
    ('1111111111129', 'Agua', 'Natural'),
    ('1111111111130', 'Agua', 'Voss'),
    ('1111111111131', 'Agua', 'Aquarius'),
    ('1111111111132', 'Agua', 'Aquafina'),
    ('1111111111133', 'Agua', 'da Torneira'),
    ('1111111111134', 'Sumo de Manga', 'Capri-Sunga'),
    ('1111111111135', 'Sumo que existe', 'Odwalla'),
    ('1111111111136', 'Sumo que existe', 'Squeezit'),
    ('1111111111137', 'Sumo que existe', 'Roth IRA'),
    ('1111111111138', 'Sumo que existe', 'Old Sock'),
    (
        '1111111111139',
        'Skittles',
        'Skittles com 2 cores'
    ),
    (
        '1111111111140',
        'Skittles',
        'Skittles com 3 cores'
    ),
    (
        '1111111111141',
        'Skittles',
        'Skittles com 4 cores'
    ),
    ('1111111111142', 'Refrigerantes', 'Buzz Cola'),
    (
        '1111111111143',
        'Refrigerantes',
        'Sumo do Pingo Doce'
    ),
    ('1111111111144', 'Refrigerantes', 'Sumo do Lidl'),
    ('1111111111145', 'Cerveja', 'Sprunk Beer'),
    ('1111111111146', 'Refrigerantes', 'Pisswasser'),
    ('1111111111147', 'Refrigerantes', 'Slusho!'),
    ('1111111111148', 'Refrigerantes', 'Slurm'),
    ('1111111111149', 'Refrigerantes', 'Nuka-Cola'),
    ('1111111111150', 'Refrigerantes', 'Nestea'),
    ('1111111111151', 'Refrigerantes', 'Nescafe'),
    ('1111111111152', 'Refrigerantes', 'Slurp Juice'),
    (
        '1111111111153',
        'Refrigerantes',
        'Caldeirao do Obelix'
    ),
    (
        '1111111111154',
        'Marlboro',
        'Marlboro que nao mata'
    ),
    ('1111111111155', 'Marlboro', 'Marlboro que mata'),
    (
        '1111111111156',
        'Chesterfield',
        'Chesterfield que mata pouco'
    ),
    ('1111111111157', 'Mascaras N95', 'KENDRICK'),
    ('1111111111158', 'Mascaras N99', 'KENDRICK'),
    ('1111111111159', 'Mascaras KN95', 'KENDRICK'),
    ('1111111111160', 'Mascaras default', 'KENDRICK'),
    ('1111111111161', 'Mascaras de pano', 'KENDRICK'),
    ('1111111111162', 'Powerade', 'Powerade Azul'),
    ('1111111111163', 'Powerade', 'Powerade Verde'),
    ('1111111111164', 'Powerade', 'Powerade Laranja'),
    (
        '1111111111165',
        'Powerade',
        'Powerade cor de lama'
    ),
    ('1111111111166', 'Gatorade', 'Gatorade Azul'),
    ('1111111111167', 'Gatorade', 'Gatorade Verde'),
    ('1111111111168', 'Gatorade', 'Gatorade Laranja'),
    (
        '1111111111169',
        'Gatorade',
        'Gatorade cor de lama'
    ),
    ('1111111111170', 'Fanta', 'Fanta sem gas'),
    ('1111111111171', 'Fanta', 'Fanta com gas'),
    ('1111111111172', 'Fanta', 'Fanta de cereja'),
    ('1111111111173', 'Fanta', 'Fanta de laranja'),
    ('1111111111174', 'Fanta', 'Fanta de limao'),
    ('1111111111175', 'Fanta', 'Fanta de uva'),
    ('1111111111176', 'Milka', 'Milka hard'),
    (
        '1111111111177',
        'Batatas Pala-Pala',
        'Pingo Doce Lisas'
    ),
    (
        '1111111111179',
        'Batatas Pala-Pala',
        'Pingo Doce Onduladas'
    ),
    (
        '1111111111180',
        'Batatas Pala-Pala',
        'Continente Lisas'
    ),
    (
        '1111111111181',
        'Batatas Pala-Pala',
        'Continente Onduladas'
    ),
    (
        '1111111111182',
        'Batatas Pala-Pala',
        'Lidl Lisas'
    ),
    (
        '1111111111183',
        'Batatas Pala-Pala',
        'Lidl Onduladas'
    ),
    ('1111111111184', 'Sumo de Manga', 'Compal'),
    ('1111111111185', 'Sumo de Manga', 'Not-Compal'),
    ('1111111111186', 'Sumo de Manga', 'Continente'),
    ('1111111111187', 'Fruta', 'Kiwi'),
    (
        '1111111111188',
        'Fruta',
        'Kiwi de um pais mesmo longe'
    ),
    ('1111111111189', 'Fruta', 'Manga'),
    ('1111111111190', 'Fruta', 'Pessego'),
    ('1111111111191', 'Snacks', 'Peixinhos da Horta');
---------------------
-- Has Category
---------------------
INSERT INTO has_category
VALUES ('1111111111111', 'Bolachas de Chocolate'),
    ('1111111111112', 'Sumo de Laranja Natural'),
    ('1111111111113', 'Fruta'),
    ('1111111111114', 'Bolachas'),
    ('1111111111115', 'Bebidas'),
    ('1111111111116', 'Bebidas'),
    ('1111111111117', 'Bebidas'),
    ('1111111111118', 'Cerveja'),
    ('1111111111119', 'Cerveja'),
    ('1111111111120', 'Cerveja'),
    ('1111111120000', 'Cerveja Artesanal'),
    ('1111111111121', 'Vinho'),
    ('1111111111122', 'Vinho'),
    ('1111111111123', 'Vinho'),
    ('1111111111124', 'Vinho'),
    ('1111111111125', 'Vinho'),
    ('1111111111126', 'Agua'),
    ('1111111111127', 'Agua'),
    ('1111111111128', 'Agua'),
    ('1111111111129', 'Agua'),
    ('1111111111130', 'Agua'),
    ('1111111111131', 'Agua'),
    ('1111111111132', 'Agua'),
    ('1111111111133', 'Agua'),
    ('1111111111134', 'Sumo de Manga'),
    ('1111111111135', 'Sumo que existe'),
    ('1111111111136', 'Sumo que existe'),
    ('1111111111137', 'Sumo que existe'),
    ('1111111111138', 'Sumo que existe'),
    ('1111111111139', 'Skittles'),
    ('1111111111140', 'Skittles'),
    ('1111111111141', 'Skittles'),
    ('1111111111142', 'Refrigerantes'),
    ('1111111111143', 'Refrigerantes'),
    ('1111111111144', 'Refrigerantes'),
    ('1111111111145', 'Cerveja'),
    ('1111111111146', 'Refrigerantes'),
    ('1111111111147', 'Refrigerantes'),
    ('1111111111148', 'Refrigerantes'),
    ('1111111111149', 'Refrigerantes'),
    ('1111111111150', 'Refrigerantes'),
    ('1111111111151', 'Refrigerantes'),
    ('1111111111152', 'Refrigerantes'),
    ('1111111111153', 'Refrigerantes'),
    ('1111111111154', 'Marlboro'),
    ('1111111111155', 'Marlboro'),
    ('1111111111156', 'Chesterfield'),
    ('1111111111157', 'Mascaras N95'),
    ('1111111111158', 'Mascaras N99'),
    ('1111111111159', 'Mascaras KN95'),
    ('1111111111160', 'Mascaras default'),
    ('1111111111161', 'Mascaras de pano'),
    ('1111111111162', 'Powerade'),
    ('1111111111163', 'Powerade'),
    ('1111111111164', 'Powerade'),
    ('1111111111165', 'Powerade'),
    ('1111111111166', 'Gatorade'),
    ('1111111111167', 'Gatorade'),
    ('1111111111168', 'Gatorade'),
    ('1111111111169', 'Gatorade'),
    ('1111111111170', 'Fanta'),
    ('1111111111171', 'Fanta'),
    ('1111111111172', 'Fanta'),
    ('1111111111173', 'Fanta'),
    ('1111111111174', 'Fanta'),
    ('1111111111175', 'Fanta'),
    ('1111111111176', 'Milka'),
    ('1111111111177', 'Batatas Pala-Pala'),
    ('1111111111179', 'Batatas Pala-Pala'),
    ('1111111111180', 'Batatas Pala-Pala'),
    ('1111111111181', 'Batatas Pala-Pala'),
    ('1111111111182', 'Batatas Pala-Pala'),
    ('1111111111183', 'Batatas Pala-Pala'),
    ('1111111111184', 'Sumo de Manga'),
    ('1111111111185', 'Sumo de Manga'),
    ('1111111111186', 'Sumo de Manga'),
    ('1111111111187', 'Fruta'),
    ('1111111111188', 'Fruta'),
    ('1111111111189', 'Fruta'),
    ('1111111111190', 'Fruta'),
    ('1111111111191', 'Snacks');
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
    ('ivm-12', 'buzz'),
    ('ivm-1', 'lightyear'),
    ('ivm-2', 'lightyear'),
    ('ivm-3', 'lightyear'),
    ('ivm-4', 'lightyear'),
    ('ivm-5', 'lightyear'),
    ('ivm-6', 'lightyear'),
    ('ivm-7', 'lightyear'),
    ('ivm-8', 'lightyear'),
    ('ivm-9', 'lightyear'),
    ('ivm-10', 'lightyear'),
    ('ivm-11', 'lightyear'),
    ('ivm-12', 'lightyear'),
    ('ivm-13', 'lightyear'),
    ('ivm-1', 'frigu'),
    ('ivm-2', 'frigu'),
    ('ivm-3', 'frigu'),
    ('ivm-4', 'frigu'),
    ('ivm-5', 'frigu'),
    ('ivm-6', 'frigu'),
    ('ivm-7', 'frigu'),
    ('ivm-8', 'frigu'),
    ('ivm-9', 'frigu'),
    ('ivm-10', 'frigu'),
    ('ivm-11', 'frigu'),
    ('ivm-12', 'frigu'),
    ('ivm-1', 'streak'),
    ('ivm-2', 'streak'),
    ('ivm-3', 'streak'),
    ('ivm-4', 'streak'),
    ('ivm-5', 'streak'),
    ('ivm-6', 'streak'),
    ('ivm-7', 'streak'),
    ('ivm-8', 'streak'),
    ('ivm-9', 'streak'),
    ('ivm-10', 'streak'),
    ('ivm-11', 'streak'),
    ('ivm-12', 'streak'),
    ('ivm-1', 'pop'),
    ('ivm-2', 'pop'),
    ('ivm-3', 'pop'),
    ('ivm-4', 'pop'),
    ('ivm-5', 'pop'),
    ('ivm-6', 'pop'),
    ('ivm-7', 'pop'),
    ('ivm-8', 'pop'),
    ('ivm-9', 'pop'),
    ('ivm-10', 'pop'),
    ('ivm-11', 'pop'),
    ('ivm-12', 'pop');
----------------------
-- Retail Point
----------------------
INSERT INTO retail_point
VALUES ('Frigu', 'Lisbon', 'RNL'),
    ('Galp', 'Oporto', 'Matosinhos'),
    ('ALDI', 'Algarve', 'Altura'),
    (
        'Escola Secundaria de Mem Martins',
        'Lisbon',
        'Sintra'
    ),
    (
        'Escola Secundaria Padre Alberto Neto',
        'Lisbon',
        'Sintra'
    ),
    (
        'Escola Secundaria Leal da Camara',
        'Lisbon',
        'Sintra'
    ),
    ('ISEL', 'Lisbon', 'Chelas'),
    (
        'Sociedade Recreativa de Bilhar',
        'Alentejo',
        'Algures'
    );
----------------------
-- Installed On
----------------------
INSERT INTO installed_on
VALUES ('ivm-1', 'fizz', 'Frigu'),
    ('ivm-2', 'buzz', 'Frigu'),
    ('ivm-3', 'lightyear', 'Frigu'),
    ('ivm-4', 'fizz', 'Galp'),
    ('ivm-5', 'buzz', 'Galp'),
    ('ivm-6', 'lightyear', 'Galp'),
    ('ivm-7', 'fizz', 'ALDI'),
    ('ivm-8', 'buzz', 'ALDI'),
    ('ivm-9', 'lightyear', 'ALDI'),
    (
        'ivm-10',
        'fizz',
        'Escola Secundaria de Mem Martins'
    ),
    (
        'ivm-2',
        'lightyear',
        'Escola Secundaria de Mem Martins'
    ),
    (
        'ivm-4',
        'buzz',
        'Escola Secundaria Padre Alberto Neto'
    ),
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
    ('3', 'ivm-2', 'fizz', '3', 'Bolachas'),
    ('2', 'ivm-3', 'buzz', '2', 'Fruta'),
    ('3', 'ivm-3', 'fizz', '2', 'Bolachas'),
    ('2', 'ivm-4', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-4', 'fizz', '3', 'Bolachas'),
    ('2', 'ivm-5', 'buzz', '2', 'Fruta'),
    ('3', 'ivm-5', 'fizz', '2', 'Bolachas'),
    ('2', 'ivm-6', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-6', 'fizz', '3', 'Bolachas'),
    ('2', 'ivm-7', 'buzz', '2', 'Fruta'),
    ('3', 'ivm-7', 'fizz', '2', 'Bolachas'),
    ('2', 'ivm-8', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-8', 'fizz', '3', 'Bolachas'),
    ('2', 'ivm-9', 'buzz', '2', 'Fruta'),
    ('3', 'ivm-9', 'fizz', '2', 'Bolachas'),
    ('2', 'ivm-10', 'buzz', '3', 'Fruta'),
    ('3', 'ivm-10', 'fizz', '3', 'Bolachas');
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
    ),
    (
        '1111111111115',
        '2',
        'ivm-3',
        'buzz',
        '2',
        20,
        'Meio'
    ),
    (
        '1111111111116',
        '3',
        'ivm-3',
        'fizz',
        '2',
        25,
        'Meio'
    ),
    (
        '1111111111117',
        '2',
        'ivm-4',
        'buzz',
        '3',
        30,
        'Meio'
    ),
    (
        '1111111111118',
        '3',
        'ivm-4',
        'fizz',
        '3',
        35,
        'Meio'
    ),
    (
        '1111111111119',
        '2',
        'ivm-5',
        'buzz',
        '2',
        40,
        'Meio'
    ),
    (
        '1111111111120',
        '3',
        'ivm-5',
        'fizz',
        '2',
        45,
        'Meio'
    ),
    (
        '1111111111121',
        '2',
        'ivm-6',
        'buzz',
        '3',
        50,
        'Meio'
    ),
    (
        '1111111111122',
        '3',
        'ivm-6',
        'fizz',
        '3',
        55,
        'Meio'
    ),
    (
        '1111111111123',
        '2',
        'ivm-7',
        'buzz',
        '2',
        60,
        'Meio'
    ),
    (
        '1111111111124',
        '3',
        'ivm-7',
        'fizz',
        '2',
        65,
        'Meio'
    ),
    (
        '1111111111125',
        '2',
        'ivm-8',
        'buzz',
        '3',
        70,
        'Meio'
    ),
    (
        '1111111111126',
        '3',
        'ivm-8',
        'fizz',
        '3',
        75,
        'Meio'
    );
----------------------
-- Retailer
----------------------
INSERT INTO retailer
VALUES ('1', 'Diogo'),
    ('2', 'Diogo II'),
    ('3', 'Tom'),
    ('4', 'Rafaelfael'),
    ('5', 'Tiago'),
    ('6', 'Jesus'),
    ('7', 'One Man Army'),
    ('8', 'Mario Cotrim'),
    ('9', 'Bernardo Almeida'),
    ('10', 'Miguel Campos'),
    ('11', 'Guilherme Duarte'),
    ('12', 'Jermaine Cole'),
    ('13', 'Jacques Webster'),
    ('14', 'Belcalis Almanzar'),
    ('15', 'Shawn Carter'),
    ('16', 'Aubrey Graham'),
    ('17', 'Kiari Cephus'),
    ('18', 'Qavious Marshall'),
    ('19', 'Marco Almeida');
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
    ('Agua', '7', 'ivm-10', 'fizz'),
    ('Sumo de Manga', '7', 'ivm-10', 'buzz'),
    ('Sumo que existe', '7', 'ivm-11', 'fizz'),
    ('Cachorros Quentes', '7', 'ivm-1', 'lightyear'),
    ('Lays', '7', 'ivm-2', 'lightyear'),
    ('Ruffles', '7', 'ivm-3', 'lightyear'),
    ('Sun Chips', '7', 'ivm-4', 'lightyear'),
    ('Doritos', '7', 'ivm-5', 'lightyear'),
    ('Cheetos', '7', 'ivm-6', 'lightyear'),
    ('Chips Ahoy', '7', 'ivm-1', 'frigu'),
    ('Coca-Cola Zero', '7', 'ivm-2', 'frigu'),
    ('Pepsi Zero', '7', 'ivm-3', 'frigu'),
    ('Gatorade', '7', 'ivm-4', 'frigu'),
    ('Powerade', '7', 'ivm-5', 'frigu'),
    ('Guarana Antarctica', '7', 'ivm-6', 'frigu'),
    ('Mascaras N95', '7', 'ivm-7', 'frigu'),
    ('Mascaras N99', '7', 'ivm-8', 'frigu'),
    ('Mascaras KN95', '7', 'ivm-9', 'frigu'),
    ('Marlboro', '7', 'ivm-10', 'frigu'),
    ('Lucky Strike', '7', 'ivm-11', 'frigu'),
    ('Newport', '7', 'ivm-12', 'frigu'),
    ('Camel', '7', 'ivm-1', 'streak'),
    ('Kentucky', '7', 'ivm-2', 'streak'),
    ('Chesterfield', '7', 'ivm-3', 'streak'),
    ('Chesterfield II', '7', 'ivm-4', 'streak'),
    ('Snickers', '7', 'ivm-5', 'streak'),
    ('Milka Light', '7', 'ivm-6', 'streak'),
    ('KitKat', '7', 'ivm-7', 'streak'),
    ('Twix', '7', 'ivm-8', 'streak'),
    ('Mars', '7', 'ivm-9', 'streak'),
    ('M&Ms', '7', 'ivm-10', 'streak'),
    ('Lion', '7', 'ivm-11', 'streak'),
    ('Skittles', '7', 'ivm-12', 'streak'),
    ('Batatas Palha', '7', 'ivm-1', 'pop'),
    ('Fanta', '7', 'ivm-2', 'pop'),
    ('Sprite', '7', 'ivm-3', 'pop'),
    ('Pepsi', '7', 'ivm-4', 'pop'),
    ('Mascaras de pano', '7', 'ivm-5', 'pop'),
    ('Bolachas de Chocolate', '1', 'ivm-7', 'lightyear'),
    ('Fruta', '1', 'ivm-8', 'lightyear'),
    ('Sumo de Laranja Natural', '1', 'ivm-9', 'lightyear'),
    ('Bolachas', '2', 'ivm-10', 'lightyear'),
    ('Bolachas de Chocolate', '2', 'ivm-11', 'lightyear'),
    ('Fruta', '2', 'ivm-12', 'lightyear'),
    ('Sumo de Laranja Natural', '2', 'ivm-13', 'lightyear');
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
        '8',
        '3'
    ),
    (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-06-27 22:19:16',
        '4',
        '3'
    ),
    (
        '1111111111113',
        '3',
        'ivm-1',
        'fizz',
        '2022-04-09 19:54:21',
        '7',
        '3'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '2022-03-09 14:54:21',
        '7',
        '1'
    ),
    (
        '1111111111114',
        '3',
        'ivm-2',
        'fizz',
        '2022-08-09 15:54:21',
        '8',
        '2'
    ),
    (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-06-03 18:37:21',
        '2',
        '3'
    ),
    (
        '1111111111111',
        '1',
        'ivm-1',
        'fizz',
        '2022-01-10 22:19:16',
        '4',
        '3'
    ),
    (
        '1111111111113',
        '3',
        'ivm-1',
        'fizz',
        '2022-11-24 19:54:21',
        '7',
        '3'
    ),
    (
        '1111111111113',
        '2',
        'ivm-2',
        'buzz',
        '2022-12-09 14:54:21',
        '7',
        '1'
    ),
    (
        '1111111111114',
        '3',
        'ivm-2',
        'fizz',
        '2022-04-02 15:54:21',
        '8',
        '2'
    );
    
