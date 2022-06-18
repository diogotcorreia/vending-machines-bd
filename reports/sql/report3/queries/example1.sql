SELECT DISTINCT R.nome
FROM retalhista R, responsavel_por P
WHERE R.tin = P.tin and P. nome_cat = 'Frutos';