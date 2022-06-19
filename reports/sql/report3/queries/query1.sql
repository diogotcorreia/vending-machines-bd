SELECT retailer.name,
    COUNT(*)
FROM responsible_for
    NATURAL JOIN retailer
GROUP BY retailer.name
HAVING COUNT(*) >= ALL (
    SELECT COUNT(DISTINCT cat_name)
    FROM responsible_for
    GROUP BY tin
);