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
--3
SELECT product.ean
FROM product
    LEFT OUTER JOIN replenishment_event ON product.ean = replenishment_event.ean
WHERE replenishment_event.ean IS NULL;