DROP VIEW IF EXISTS sales;

CREATE VIEW sales AS
SELECT
  product.ean,
  category.name,
  year,
  quarter,
  day_month,
  day_week,
  retail_point.district,
  retail_point.county,
  replenishment_event.units
FROM
  replenishment_event
  INNER JOIN product
    ON replenishment_event.ean = product.ean
  INNER JOIN category
    ON product.category = category.name
  INNER JOIN installed_on
    ON replenishment_event.serial_num = installed_on.serial_num
      AND replenishment_event.manuf = installed_on.manuf
  INNER JOIN retail_point
    ON installed_on.local = retail_point.name,
EXTRACT(YEAR FROM instant) AS year,
EXTRACT(QUARTER FROM instant) AS quarter,
EXTRACT(DAY FROM instant) AS day_month,
EXTRACT(DOW FROM instant) AS day_week;