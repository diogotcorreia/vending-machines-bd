SELECT product.ean, product.descr FROM product
  NATURAL JOIN replenishment_event
  WHERE replenishment_event.units >= ALL (
    SELECT replenishment_event.units FROM replenishment_event
  );
