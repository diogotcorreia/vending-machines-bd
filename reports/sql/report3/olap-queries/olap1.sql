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