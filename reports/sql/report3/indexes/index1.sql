DROP INDEX IF EXISTS idx_responsible_for_tin;
CREATE INDEX idx_responsible_for_tin
  ON responsible_for USING HASH(tin);
DROP INDEX IF EXISTS idx_responsible_for_cat_name;
CREATE INDEX idx_responsible_for_cat_name
  ON responsible_for USING HASH(cat_name);