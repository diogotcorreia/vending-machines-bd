drop table category cascade;
drop table simple_category cascade;
drop table super_category cascade;
drop table has_other cascade;
drop table product cascade;
drop table has_category cascade;
drop table ivm cascade;
drop table retail_point cascade;
drop table installed_on cascade;
drop table shelf cascade;
drop table planogram cascade;
drop table retailer cascade;
drop table responsible_for cascade;
drop table replenishment_event cascade;
----------------------------------------
-- Table Creation
----------------------------------------
-- Primary keys need NOT NULL ?
CREATE TABLE category (
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (name) -- RI_RE1
);
CREATE TABLE simple_category (
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_simple_category PRIMARY KEY (name),
    CONSTRAINT fk_simple_category_category FOREIGN KEY(name) REFERENCES category(name) -- RI_RE1
    -- RI_RE2
);
CREATE TABLE super_category (
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_super_category PRIMARY KEY (name),
    CONSTRAINT fk_super_category_category FOREIGN KEY(name) REFERENCES category(name) -- RI_RE1
    -- RI_RE2
    -- RI_RE3
);
CREATE TABLE has_other (
    super_category VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    CONSTRAINT fk_has_other_super_category FOREIGN KEY(super_category) REFERENCES super_category(name),
    CONSTRAINT pk_has_other PRIMARY KEY (category),
    CONSTRAINT fk_has_other_category FOREIGN KEY(category) REFERENCES category(name) -- RI_RE1
    -- RI_RE2
    -- RI_RE3
    -- RI_RE4
    -- RI_RE5
);
CREATE TABLE product (
    ean VARCHAR(13) NOT NULL,
    category VARCHAR(255) NOT NULL,
    description text NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (ean),
    CONSTRAINT fk_product_category FOREIGN KEY(category) REFERENCES category(name) -- RI_RE6
);
CREATE TABLE has_category (
    ean VARCHAR(13) NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_has_category PRIMARY KEY (ean, name),
    CONSTRAINT fk_has_category_ean FOREIGN KEY(ean) REFERENCES product(ean),
    CONSTRAINT fk_has_category_name FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE ivm (
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    CONSTRAINT pk_ivm PRIMARY KEY (serial_num, manuf)
);
CREATE TABLE retail_point (
    name VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    county VARCHAR(255) NOT NULL,
    -- concelho (?)
    CONSTRAINT pk_retail_point PRIMARY KEY (name)
);
CREATE TABLE installed_on (
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    local VARCHAR(255) NOT NULL,
    CONSTRAINT pk_installed_on PRIMARY KEY (serial_num, manuf),
    CONSTRAINT fk_installed_on_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_installed_on_retail_point FOREIGN KEY(local) REFERENCES retail_point(name)
);
CREATE TABLE shelf (
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    height VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_shelf PRIMARY KEY (number, serial_num, manuf),
    CONSTRAINT fk_shelf_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_shelf_category FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE planogram(
    ean VARCHAR(13) NOT NULL,
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    face VARCHAR(255) NOT NULL,
    units VARCHAR(255) NOT NULL,
    loc VARCHAR(255) NOT NULL,
    CONSTRAINT pk_planogram PRIMARY KEY (ean, number, serial_num, manuf),
    CONSTRAINT fk_planogram_product FOREIGN KEY(ean) REFERENCES product(ean),
    CONSTRAINT fk_planogram_shelf FOREIGN KEY(number, serial_num, manuf) REFERENCES shelf(number, serial_num, manuf)
);
CREATE TABLE retailer(
    tin VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT pk_retailer PRIMARY KEY (tin) -- RI-RE7 (DONE)
);
CREATE TABLE responsible_for(
    cat_name VARCHAR(255) NOT NULL,
    tin VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    CONSTRAINT pk_responsible_for PRIMARY KEY (serial_num, manuf),
    CONSTRAINT fk_responsible_for_ivm FOREIGN KEY(serial_num, manuf) REFERENCES ivm(serial_num, manuf),
    CONSTRAINT fk_responsible_for_retailer FOREIGN KEY(tin) REFERENCES retailer(tin),
    CONSTRAINT fk_responsible_for_category FOREIGN KEY(cat_name) REFERENCES category(name)
);
CREATE TABLE replenishment_event(
    ean VARCHAR(13) NOT NULL,
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    instant timestamp NOT NULL,
    units VARCHAR(255) NOT NULL,
    tin VARCHAR(255) NOT NULL,
    CONSTRAINT pk_replenishment_event PRIMARY KEY (ean, number, serial_num, manuf, instant),
    CONSTRAINT fk_replenishment_event_planogram FOREIGN KEY (ean, number, serial_num, manuf) REFERENCES planogram(ean, number, serial_num, manuf),
    CONSTRAINT fk_replenishment_event_retailer FOREIGN KEY(tin) REFERENCES retailer(tin) -- RI-RE8 
);