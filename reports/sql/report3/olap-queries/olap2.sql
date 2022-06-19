SELECT county,
  day_week,
  category_name,
  SUM(units) AS total_units
FROM sales
WHERE district = 'mock-district'
GROUP BY GROUPING SETS (county, day_week, category_name, ())
ORDER BY county,
  day_week,
  category_name;