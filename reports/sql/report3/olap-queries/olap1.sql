SELECT county,
  day_week,
  SUM(units) AS total_units
FROM sales
-- TODO: fix this
WHERE day_month BETWEEN 1 AND 20
  AND month BETWEEN 2 AND 12
  AND year BETWEEN 2022 AND 2024
GROUP BY GROUPING SETS (county, day_week, ())
ORDER BY county,
  day_week;