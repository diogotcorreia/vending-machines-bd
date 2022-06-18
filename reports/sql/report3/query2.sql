SELECT retailer.name
FROM responsible_for
    NATURAL JOIN retailer
    INNER JOIN simple_category ON responsible_for.cat_name = simple_category.name
GROUP BY retailer.name
HAVING COUNT(DISTINCT cat_name) = (
    SELECT COUNT(*)
    FROM simple_category
);