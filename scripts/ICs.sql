-- (RI-1) Uma Categoria não pode estar contida em si própria
DROP TRIGGER IF EXISTS self_contained_category_trigger ON has_other;

CREATE OR REPLACE FUNCTION self_contained_category_trigger() RETURNS trigger AS $$
BEGIN
  -- Tries to find NEW.super_category in the sub-categories of NEW.category.
  -- If it does, throws exception
  IF NEW.category = NEW.super_category OR
  EXISTS (
    SELECT *
    FROM all_subcategories(NEW.category)
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
-- NOTE: this also solves RI-RE8 from the schema
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
  
  IF NOT EXISTS (
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

---------------------
--      UTILS      --
---------------------

-- Automatically change type of product from simple to super when a child category is added
DROP TRIGGER IF EXISTS change_category_type_to_super_trigger ON has_other;

CREATE OR REPLACE FUNCTION change_category_type_to_super() RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM simple_category WHERE name = NEW.super_category;

  INSERT INTO super_category (name)
  VALUES (NEW.super_category)
  ON CONFLICT DO NOTHING;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER change_category_type_to_super_trigger BEFORE INSERT OR UPDATE ON has_other
FOR EACH ROW EXECUTE PROCEDURE change_category_type_to_super();


-- Automatically change type of product from super to simple when all child categories are removed
DROP TRIGGER IF EXISTS change_category_type_to_simple_trigger ON has_other;

CREATE OR REPLACE FUNCTION change_category_type_to_simple() RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (
    SELECT * FROM has_other
    WHERE super_category = OLD.super_category
  )
  THEN
    DELETE FROM super_category WHERE name = OLD.super_category;

    INSERT INTO simple_category (name)
      VALUES (OLD.super_category)
      ON CONFLICT DO NOTHING;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER change_category_type_to_simple_trigger AFTER UPDATE OR DELETE ON has_other
FOR EACH ROW EXECUTE PROCEDURE change_category_type_to_simple();


-- RI-RE1: A category must necessarily be a simple_category or a super_category
DROP TRIGGER IF EXISTS category_must_be_specialized_trigger ON category;

CREATE OR REPLACE FUNCTION category_must_be_specialized() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO simple_category VALUES ((NEW.name));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER category_must_be_specialized_trigger AFTER INSERT ON category
FOR EACH ROW EXECUTE PROCEDURE category_must_be_specialized();


-- RI-RE2: A simple category's name cannot also exist in the super_category relation
DROP TRIGGER IF EXISTS simple_category_name_already_in_super_category_trigger ON simple_category;

CREATE OR REPLACE FUNCTION simple_category_name_already_in_super_category() RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (
    SELECT *
    FROM super_category
    WHERE name = NEW.name
  )
  THEN
    RAISE EXCEPTION 'A Simple Category (%) cannot also be a Super Category', NEW.name;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER simple_category_name_already_in_super_category_trigger AFTER INSERT OR UPDATE ON simple_category
FOR EACH ROW EXECUTE PROCEDURE simple_category_name_already_in_super_category();
