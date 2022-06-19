SELECT T.name, count(T.ean)
FROM product P, has_category T
WHERE p.category = T.name AND P.description LIKE 'A%'
GROUP BY T.name;