------------------------------------
-- 1 Categorias distintas ou podem repetir?
-----------------
--1
SELECT name,
    COUNT(*)
FROM responsible_for
    NATURAL JOIN retailer
GROUP BY name
HAVING COUNT(*) >= ALL (
    SELECT COUNT(DISTINCT cat_name)
    FROM responsible_for
    GROUP BY tin
);

--2
SELECT retailer.name
FROM responsible_for
    NATURAL JOIN retailer
    INNER JOIN simple_category ON responsible_for.cat_name = simple_category.name
GROUP BY retailer.name
HAVING COUNT(DISTINCT cat_name) = (
    Select COUNT(*)
    FROM simple_category
);

--3
SELECT product.ean
FROM product
WHERE product.ean NOT IN (
    SELECT ean
    FROM replenishment_event
);

--4
SELECT ean
FROM replenishment_event
GROUP BY ean
HAVING COUNT(DISTINCT tin) = 1;
---list
WITH RECURSIVE list_recurs(super_category, category) AS (
    SELECT super_category,
        category
    FROM has_other
    WHERE super_category = 'Armas'
    UNION ALL
    SELECT child.super_category,
        child.category
    FROM has_other AS child
        INNER JOIN list_recurs AS parent ON child.super_category = parent.category
)
SELECT category
FROM list_recurs AS sub_categories;
