---------------------
-- First index
---------------------
DROP INDEX IF EXISTS idx_responsible_for_tin;
CREATE INDEX idx_responsible_for_tin ON responsible_for USING BTREE(tin);
DROP INDEX IF EXISTS idx_responsible_for_cat_name;
CREATE INDEX idx_responsible_for_cat_name ON responsible_for USING HASH(cat_name);
-- the retailer's tin is already indexed, since it is a primary key of that relation
----------------------
EXPLAIN ANALYZE
SELECT DISTINCT R.name
FROM retailer R,
    responsible_for P
WHERE R.tin = P.tin
    AND P.cat_name = 'Bolachas de Chocolate';
----------------------
-- SECOND index
----------------------
DROP INDEX IF EXISTS idx_product_category;
CREATE INDEX idx_product_category ON product USING BTREE(category);
DROP INDEX IF EXISTS idx_product_desc;
-- i'd say it's BTREE here, since we'd want a "range" from where we could choose all the descriptions that fit
CREATE INDEX idx_product_desc ON product USING BTREE(description);
DROP INDEX IF EXISTS idx_has_category_name;
CREATE INDEX idx_has_category_name ON has_category USING BTREE(name);
----------------------
EXPLAIN ANALYZE
SELECT T.name,
    COUNT(T.ean)
FROM product P,
    has_category T
WHERE P.category = T.name
    AND P.description LIKE 'A%'
GROUP BY T.name;
