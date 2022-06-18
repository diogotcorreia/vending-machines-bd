SELECT T.nome, count(T.ean)
FROM produto P, tem_categoria T
WHERE p.cat = T.nome and P.desc like 'A%'
GROUP BY T.nome;