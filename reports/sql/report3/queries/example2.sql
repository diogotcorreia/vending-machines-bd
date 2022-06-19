SELECT T.name, count(T.ean)
FROM product P, has_category T
WHERE p.category = T.name and P.description like 'A%'
GROUP BY T.name;