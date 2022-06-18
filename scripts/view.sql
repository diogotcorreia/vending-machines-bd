-- Each replenishment event, replenishing a given amount of units, is associated
-- with an equal amount of units sold. We need to create a view, such that it summarizes
-- the sales' most important information (picking up columns from our model's relations).
-- The schema should be like so:

-- Sales(ean, cat, year, quarter, day_month, day_week, district, county, units)

-- We should gather the attributes such that:

-- `units` comes from `replenishment_event`: that is, we replenished the amount of units that were sold)
-- `ean` and `cat` come from `product` and `category`: we sold a certain product, which belongs to a certain category
-- `district` and `county` come from `retail_point`: the sale was done in a specific address, the one in which retail_point is located
-- `year`, `quarter`, `day_month` and `day_week`, all derived from `instant` (which is an attribute from `replenishment_event`. Note: the teachers recommend utilizing the extract() function to gather the attributes from timestamps (which, in this case, are instants)

DROP VIEW IF EXISTS sales;

CREATE VIEW sales AS
SELECT
  product.ean,
  category.name AS category_name,
  year,
  quarter,
  month,
  day_month,
  day_week,
  retail_point.district,
  retail_point.county,
  replenishment_event.units
FROM
  replenishment_event
  INNER JOIN product ON replenishment_event.ean = product.ean
  INNER JOIN category ON product.category = category.name
  INNER JOIN installed_on ON replenishment_event.serial_num = installed_on.serial_num
    AND replenishment_event.manuf = installed_on.manuf
  INNER JOIN retail_point ON installed_on.local = retail_point.name,
EXTRACT(YEAR FROM instant) AS year,
EXTRACT(QUARTER FROM instant) AS quarter,
EXTRACT(MONTH FROM instant) AS month,
EXTRACT(DAY FROM instant) AS day_month,
EXTRACT(DOW FROM instant) AS day_week;
  