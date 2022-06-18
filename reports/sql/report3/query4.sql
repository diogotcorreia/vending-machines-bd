SELECT ean
FROM replenishment_event
GROUP BY ean
HAVING COUNT(DISTINCT tin) = 1;
---list
WITH RECURSIVE list_recurs(super_category, category) AS (
    SELECT super_category,
        category
    FROM has_other
    WHERE super_category = 'Armas'
    UNION ALL
    SELECT child.super_category,
        child.category
    FROM has_other AS child
        INNER JOIN list_recurs AS parent ON child.super_category = parent.category
)
SELECT category
FROM list_recurs AS sub_categories;