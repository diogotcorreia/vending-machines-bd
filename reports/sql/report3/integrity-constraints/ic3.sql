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