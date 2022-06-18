DROP TRIGGER IF EXISTS replenishment_event_units_lower_than_planogram_trigger
  ON replenishment_event;

CREATE OR REPLACE FUNCTION replenishment_event_units_lower_than_planogram()
  RETURNS TRIGGER AS $$
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

CREATE TRIGGER replenishment_event_units_lower_than_planogram_trigger
  BEFORE INSERT ON replenishment_event
FOR EACH ROW
  EXECUTE PROCEDURE replenishment_event_units_lower_than_planogram();