SELECT ean, descr FROM product
  NATURAL JOIN replenishment_event
  GROUP BY ean, descr
  HAVING SUM(units) >= ALL (
    SELECT SUM(units) FROM replenishment_event
    GROUP BY ean
  );
