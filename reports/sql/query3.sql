SELECT count(*) as subcategories_count FROM has_other
  % check group by
  GROUP BY super_category_name
  WHERE super_category_name = 'Sopas Take-Away';
