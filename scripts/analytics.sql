-- The total amount of sold products in a given period of time, by day of the week,
-- county or total

SELECT *
FROM (
  SELECT
    day_week
    count(units) AS sold_units
  FROM sales
  GROUP BY day_week
) AS day_week_sold_units
UNION (
  SELECT
    county
    count(units) AS sold_units
  FROM sales
  GROUP BY county
) AS county_sold_units
UNION (
  SELECT count(units) AS sold_units
  FROM sales
) AS total_sold_units
WHERE sold_units > 0; -- placeholder: we can't do this one rn

-- The total amount of sold products in a given district, by county, category,
-- day of the week or total

SELECT *
FROM (
  SELECT
    county,
    count(units) AS sold_units
  FROM sales
  GROUP BY county
) AS sales_by_county
UNION (
  SELECT
    name,
    count(units) AS sold_units
  FROM sales
  GROUP BY name
) AS sales_by_category
UNION (
  SELECT
    day_week,
    count(units) AS sold_units
  FROM sales
  GROUP BY day_week
) AS sales_by_day_of_week
UNION (
  SELECT count(units) AS sold_units
  FROM sales
) AS total_sold_units
WHERE district = 'Berlin'; -- placeholder