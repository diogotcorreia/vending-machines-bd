-- (RI-4) O número de unidades repostas num Evento de Reposição não pode exceder o número de
-- unidades especificado no Planograma
DROP TRIGGER IF EXISTS replenishment_event_units_lower_than_planogram_trigger ON replenishment_event;

CREATE OR REPLACE FUNCTION replenishment_event_units_lower_than_planogram() RETURNS TRIGGER AS $$
DECLARE max_units INTEGER;
BEGIN
  SELECT units INTO max_units
    FROM planogram
    WHERE ean = new.ean AND
          number = new.number AND
          serial_num = new.serial_num AND
          manuf = new.manuf;

  IF new.units > max_units
  THEN
    RAISE EXCEPTION 'Replenished units (%) cannot exceed the number of units specified in the planogram (%).',
      new.units, max_units;
  END IF;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER replenishment_event_units_lower_than_planogram_trigger BEFORE INSERT ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE replenishment_event_units_lower_than_planogram();

-- (RI-5) Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos)
-- uma das Categorias desse produto
DROP TRIGGER IF EXISTS product_placed_incorrect_shelf_trigger ON product;

CREATE OR REPLACE FUNCTION product_placed_incorrect_shelf() RETURNS TRIGGER AS $$
DECLARE shelf_category_name VARCHAR(255);
DECLARE possible_category_names VARCHAR(255) ARRAY;
BEGIN
  SELECT name INTO shelf_category_name
    FROM shelf
    WHERE number = new.number AND
          serial_num = new.serial_num AND
          manuf = new.manuf;

  SELECT ARRAY_AGG(name) INTO possible_category_names
    FROM has_category
    WHERE ean = new.ean;
  
  IF NOT EXISTS(
    SELECT *
    FROM unnest(possible_category_names) AS possible_category_name
      WHERE possible_category_name = shelf_category_name
  )
  THEN
    RAISE EXCEPTION 'At least one of the Product''s (%) categories must match the shelf''s categories',
      new.ean;
  END IF;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_placed_incorrect_shelf_trigger BEFORE INSERT ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE product_placed_incorrect_shelf();

  