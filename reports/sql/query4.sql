SELECT product.ean, product.descr FROM product
  INNER JOIN replenishment_event ON replenishment_event.ean = product.ean
  WHERE replenishment_event.units >= ALL (
    SELECT replenishment_event.units FROM replenishment_event
  );
