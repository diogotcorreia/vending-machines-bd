--1
Select tin,
    COUNT(*)
FROM responsible_for
GROUP BY tin
HAVING COUNT(*) >= ALL (
        SELECT COUNT(*)
        FROM responsible_for
        GROUP BY tin
    );
--2 (INCOMPLETE)
SELECT tin
FROM responsible_for
    INNER JOIN simple_category ON responsible_for.cat_name = simple_category.name
GROUP By tin
HAVING COUNT(
        DISTINCT cat_name
        WHERE cat_name IN simple_category
    ) = COUNT(simple_category);
--3
SELECT product.ean
FROM product
    LEFT OUTER JOIN replenishment_event ON product.ean = replenishment_event.ean
WHERE replenishment_event.ean IS NULL;
--4
Select ean
FROM replenishment_event
GROUP BY ean
Having COUNT(DISTINCT tin) = 1