-- The total amount of sold products in a given period of time, by day of the week,
-- county or total

SELECT county,
  day_week,
  SUM(units) AS total_units
FROM sales
WHERE district = 'Lisbon'
GROUP BY GROUPING SETS (county, day_week, ())
ORDER BY county,
  day_week;

-- The total amount of sold products in a given district, by day of the week,
-- county, category or total