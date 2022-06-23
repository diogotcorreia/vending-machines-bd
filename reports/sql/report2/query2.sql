SELECT DISTINCT serial_number, manuf FROM shelf
  NATURAL JOIN product
  NATURAL JOIN has
  WHERE ean = '9002490100070';
