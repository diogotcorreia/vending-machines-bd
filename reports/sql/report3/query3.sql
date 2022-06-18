SELECT product.ean
FROM product
WHERE product.ean NOT IN (
    SELECT ean
    FROM replenishment_event
);