-- The total amount of sold products in a given period of time, by day of the week,
-- county or total

SELECT county,
  day_week,
  SUM(units) AS total_units
FROM sales
WHERE day_month BETWEEN 1 AND 20
  AND month BETWEEN 2 AND 12
  AND year BETWEEN 2022 AND 2024
GROUP BY GROUPING SETS (county, day_week, ())
ORDER BY county,
  day_week;

-- The total amount of sold products in a given district, by day of the week,
-- county, category or total

SELECT county,
  day_week,
  category_name,
  SUM(units) AS total_units
FROM sales
WHERE district = 'Lisbon'
GROUP BY GROUPING SETS (county, day_week, category_name, ())
ORDER BY county,
  day_week,
  category_name;