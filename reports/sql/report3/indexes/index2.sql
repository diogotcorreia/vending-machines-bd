DROP INDEX IF EXISTS idx_product_category;
CREATE INDEX idx_product_category
  ON product USING HASH(category);
DROP INDEX IF EXISTS idx_product_desc;
CREATE INDEX idx_product_desc
  ON product USING BTREE(description);
DROP INDEX IF EXISTS idx_has_category_name;
CREATE INDEX idx_has_category_name
  ON has_category USING HASH(name);