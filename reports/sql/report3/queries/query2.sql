SELECT DISTINCT retailer.name FROM responsible_for RF
    NATURAL JOIN retailer
WHERE NOT EXISTS (
    SELECT name
    FROM simple_category
    EXCEPT
    SELECT name
    FROM simple_category
    INNER JOIN responsible_for
        ON responsible_for.cat_name = simple_category.name
    WHERE responsible_for.tin = RF.tin
);