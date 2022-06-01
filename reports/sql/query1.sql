SELECT product.ean, product.descr FROM category
  INNER JOIN has ON has.category_name = category.name
  INNER JOIN product ON product.ean = has.ean
  INNER JOIN planogram ON planogram.ean = product.ean
  INNER JOIN replenishment_event ON
    replenishment_event.serial_number = planogram.serial_number AND
    replenishment_event.manuf = planogram.manuf AND
    replenishment_event.nr = planogram.nr AND
    replenishment_event.ean = planogram.ean
  WHERE replenishment_event.units > 10 AND
    replenishment_event.instant > '2021-12-31' AND
    category.name = 'Barras Energéticas';
