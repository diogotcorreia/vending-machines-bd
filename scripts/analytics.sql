-- The total amount of sold products in a given period of time, by day of the week,
-- county or total
SELECT county,
  day_week,
  SUM(units) AS total_units
FROM sales
WHERE MAKE_DATE(
    CAST(year AS INT),
    CAST(month AS INT),
    CAST(day_month AS INT)
  ) BETWEEN 'mock-timestamp-1' AND 'mock-timestamp-2'
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