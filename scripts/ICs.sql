-- (RI-1) Uma Categoria não pode estar contida em si própria
DROP TRIGGER IF EXISTS self_contained_category_trigger ON has_other;

CREATE OR REPLACE FUNCTION self_contained_category_trigger() RETURNS trigger AS $$
BEGIN
  -- Tries to find NEW.super_category in the sub-categories of NEW.category.
  -- If it does, throws exception
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


-- (RI-4) O número de unidades repostas num Evento de Reposição não pode exceder o número de
-- unidades especificado no Planograma
DROP TRIGGER IF EXISTS replenishment_event_units_lower_than_planogram_trigger ON replenishment_event;

CREATE OR REPLACE FUNCTION replenishment_event_units_lower_than_planogram() RETURNS TRIGGER AS $$
DECLARE max_units INTEGER;
BEGIN
  SELECT units INTO max_units
    FROM planogram
    WHERE ean = NEW.ean AND
          number = NEW.number AND
          serial_num = NEW.serial_num AND
          manuf = NEW.manuf;

  IF NEW.units > max_units
  THEN
    RAISE EXCEPTION 'Replenished units (%) for "%" at shelf (%, %, %) cannot exceed the number of units specified in the planogram (%).',
      NEW.units, NEW.ean, NEW.number, NEW.serial_num, NEW.manuf, max_units;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER replenishment_event_units_lower_than_planogram_trigger BEFORE INSERT ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE replenishment_event_units_lower_than_planogram();


-- (RI-5) Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos)
-- uma das Categorias desse produto
DROP TRIGGER IF EXISTS product_placed_incorrect_shelf_trigger ON replenishment_event;

CREATE OR REPLACE FUNCTION product_placed_incorrect_shelf() RETURNS TRIGGER AS $$
DECLARE shelf_category_name VARCHAR(255);
DECLARE possible_category_names VARCHAR(255) ARRAY;
BEGIN
  SELECT name INTO shelf_category_name
    FROM shelf
    WHERE number = NEW.number AND
          serial_num = NEW.serial_num AND
          manuf = NEW.manuf;
  
  IF NOT EXISTS(
    SELECT * from has_category
    WHERE name = shelf_category_name AND ean = NEW.ean
  )
  THEN
    RAISE EXCEPTION 'At least one of the Product''s (%) categories must match the shelf''s (%, %, %) category (%)',
      NEW.ean, NEW.number, NEW.serial_num, NEW.manuf, shelf_category_name;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_placed_incorrect_shelf_trigger BEFORE INSERT ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE product_placed_incorrect_shelf();