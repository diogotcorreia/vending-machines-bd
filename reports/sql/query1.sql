SELECT product.ean, product.descr FROM product
  NATURAL JOIN has
  NATURAL JOIN replenishment_event
  GROUP BY product.ean, product.descr
  HAVING SUM(replenishment_event.units) > 10
  WHERE replenishment_event.instant > '2021-12-31' AND
    has.name = 'Barras Energéticas';
