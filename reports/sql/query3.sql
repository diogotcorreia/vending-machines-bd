SELECT count(*) as count FROM has_other
  GROUP BY super_category_name
  WHERE super_category_name = 'Sopas Take-Away';
