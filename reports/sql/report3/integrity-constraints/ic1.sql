DROP TRIGGER IF EXISTS self_contained_category_trigger ON has_other;

CREATE OR REPLACE FUNCTION self_contained_category_trigger() RETURNS trigger AS $$
BEGIN
  IF EXISTS(
    WITH RECURSIVE list_recurs(super_category, category) AS (
      SELECT super_category,
        category
      FROM has_other
      WHERE super_category = NEW.category
      UNION ALL
      SELECT child.super_category,
        child.category
      FROM has_other AS child
        INNER JOIN list_recurs AS parent ON child.super_category = parent.category
    )
    SELECT category AS sub_categories
    FROM list_recurs
    WHERE category = NEW.super_category
  )
  THEN
    RAISE EXCEPTION 'Category "%" cannot be contained within itself', NEW.category;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER self_contained_category_trigger BEFORE INSERT ON has_other
FOR EACH ROW EXECUTE PROCEDURE self_contained_category_trigger();