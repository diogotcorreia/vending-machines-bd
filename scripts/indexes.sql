---------------------
-- First index
---------------------
DROP INDEX IF EXISTS idx_responsible_for_cat_name;
CREATE INDEX idx_responsible_for_cat_name ON responsible_for USING HASH(cat_name);
DROP INDEX IF EXISTS idx_responsible_for_cat_tin;
CREATE INDEX idx_responsible_for_cat_tin ON responsible_for USING HASH(tin);
DROP INDEX IF EXISTS idx_retailer_tin;
CREATE INDEX idx_retailer_tin ON retailer USING HASH(tin);
----------------------
EXPLAIN ANALYSE
SELECT DISTINCT R.name
FROM retailer R,
    responsible_for P
WHERE R.tin = P.tin
    and P.cat_name = 'Bolachas de Chocolate';
----------------------
-- SECOND index
----------------------
DROP INDEX IF EXISTS idx_product_desc;
CREATE INDEX idx_product_desc ON product USING HASH (description);
DROP INDEX IF EXISTS idx_has_category_name_ean;
CREATE INDEX idx_has_category_name_ean ON has_category USING BTREE (name, ean);
DROP INDEX IF EXISTS idx_product_category;
CREATE INDEX idx_product_category ON product USING HASH(category);
DROP INDEX IF EXISTS idx_has_category_name;
CREATE INDEX idx_has_category_name ON has_category USING HASH(name);
----------------------
EXPLAIN ANALYSE
SELECT T.name,
    count(T.ean) USING
FROM product P,
    has_category T
WHERE P.category = T.name
    and P.description like 'A%'
GROUP BY T.name;