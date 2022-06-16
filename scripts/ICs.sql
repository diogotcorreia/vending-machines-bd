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
    RAISE EXCEPTION 'Replenished units (%) cannot exist the number of units specified in the planogram (%).',
      new.units, max_units;
  END IF;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER replenishment_event_units_lower_than_planogram_trigger BEFORE INSERT ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE replenishment_event_units_lower_than_planogram();
