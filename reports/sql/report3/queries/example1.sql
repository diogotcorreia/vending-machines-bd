SELECT DISTINCT R.name
FROM retailer R, responsible_for P
WHERE R.tin = P.tin AND P. cat_name = 'Frutos';