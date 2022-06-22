DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS simple_category CASCADE;
DROP TABLE IF EXISTS super_category CASCADE;
DROP TABLE IF EXISTS has_other CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS has_category CASCADE;
DROP TABLE IF EXISTS ivm CASCADE;
DROP TABLE IF EXISTS retail_point CASCADE;
DROP TABLE IF EXISTS installed_on CASCADE;
DROP TABLE IF EXISTS shelf CASCADE;
DROP TABLE IF EXISTS planogram CASCADE;
DROP TABLE IF EXISTS retailer CASCADE;
DROP TABLE IF EXISTS responsible_for CASCADE;
DROP TABLE IF EXISTS replenishment_event CASCADE;
----------------------------------------
-- Table Creation
----------------------------------------
-- NOTE: some of the integrity constraints mentioned in the schema are created,
-- as triggers, in ICs.sql

CREATE TABLE category (
    name VARCHAR(255),
    CONSTRAINT pk_category PRIMARY KEY (name)
);
CREATE TABLE simple_category (
    name VARCHAR(255),
    CONSTRAINT pk_simple_category PRIMARY KEY (name),
    CONSTRAINT fk_simple_category_category FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE super_category (
    name VARCHAR(255),
    CONSTRAINT pk_super_category PRIMARY KEY (name),
    CONSTRAINT fk_super_category_category FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE has_other (
    super_category VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    CONSTRAINT fk_has_other_super_category FOREIGN KEY(super_category) REFERENCES super_category(name),
    CONSTRAINT pk_has_other PRIMARY KEY (category),
    CONSTRAINT fk_has_other_category FOREIGN KEY(category) REFERENCES category(name),
    CHECK (super_category != category)
);
CREATE TABLE product (
    ean VARCHAR(13),
    category VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (ean),
    CONSTRAINT fk_product_category FOREIGN KEY(category) REFERENCES category(name)
);
CREATE TABLE has_category (
    ean VARCHAR(13),
    name VARCHAR(255),
    CONSTRAINT pk_has_category PRIMARY KEY (ean, name),
    CONSTRAINT fk_has_category_ean FOREIGN KEY(ean) REFERENCES product(ean),
    CONSTRAINT fk_has_category_name FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE ivm (
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    CONSTRAINT pk_ivm PRIMARY KEY (serial_num, manuf)
);
CREATE TABLE retail_point (
    name VARCHAR(255),
    district VARCHAR(255) NOT NULL,
    county VARCHAR(255) NOT NULL,
    -- concelho (?)
    CONSTRAINT pk_retail_point PRIMARY KEY (name)
);
CREATE TABLE installed_on (
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    local VARCHAR(255) NOT NULL,
    CONSTRAINT pk_installed_on PRIMARY KEY (serial_num, manuf),
    CONSTRAINT fk_installed_on_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_installed_on_retail_point FOREIGN KEY(local) REFERENCES retail_point(name)
);
CREATE TABLE shelf (
    number VARCHAR(255),
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    height INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_shelf PRIMARY KEY (number, serial_num, manuf),
    CONSTRAINT fk_shelf_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_shelf_category FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE planogram(
    ean VARCHAR(13),
    number VARCHAR(255),
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    face VARCHAR(255) NOT NULL,
    units INT NOT NULL,
    loc VARCHAR(255) NOT NULL,
    CONSTRAINT pk_planogram PRIMARY KEY (ean, number, serial_num, manuf),
    CONSTRAINT fk_planogram_product FOREIGN KEY(ean) REFERENCES product(ean),
    CONSTRAINT fk_planogram_shelf FOREIGN KEY(number, serial_num, manuf) REFERENCES shelf(number, serial_num, manuf)
);
CREATE TABLE retailer(
    tin VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT pk_retailer PRIMARY KEY (tin)
);
CREATE TABLE responsible_for(
    cat_name VARCHAR(255) NOT NULL,
    tin VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    CONSTRAINT pk_responsible_for PRIMARY KEY (serial_num, manuf),
    CONSTRAINT fk_responsible_for_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_responsible_for_retailer FOREIGN KEY(tin) REFERENCES retailer(tin),
    CONSTRAINT fk_responsible_for_category FOREIGN KEY(cat_name) REFERENCES category(name)
);
CREATE TABLE replenishment_event(
    ean VARCHAR(13),
    number VARCHAR(255),
    serial_num VARCHAR(255),
    manuf VARCHAR(255),
    instant TIMESTAMP,
    units INT NOT NULL,
    tin VARCHAR(255) NOT NULL,
    CONSTRAINT pk_replenishment_event PRIMARY KEY (ean, number, serial_num, manuf, instant),
    CONSTRAINT fk_replenishment_event_planogram FOREIGN KEY (ean, number, serial_num, manuf) REFERENCES planogram(ean, number, serial_num, manuf),
    CONSTRAINT fk_replenishment_event_retailer FOREIGN KEY(tin) REFERENCES retailer(tin) -- RI-RE8 
);
