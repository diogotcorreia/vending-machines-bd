-- Primary keys need NOT NULL ?
CREATE TABLE category (
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (name) -- RI_RE1
);
CREATE TABLE simple_category (
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY(name) REFERENCES category(name) -- RI_RE1
    -- RI_RE2
);
CREATE TABLE super_category (
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY(name) REFERENCES category(name) -- RI_RE1
    -- RI_RE2
    -- RI_RE3
);
CREATE TABLE has_other (
    category VARCHAR(255) NOT NULL,
    super_category VARCHAR(255) NOT NULL,
    PRIMARY KEY (category),
    FOREIGN KEY(category) REFERENCES category(name),
    FOREIGN KEY(super_category) REFERENCES super_category(name) -- RI_RE1
    -- RI_RE2
    -- RI_RE3
    -- RI_RE4
    -- RI_RE5
);
CREATE TABLE product (
    ean VARCHAR(13) NOT NULL,
    category VARCHAR(255) NOT NULL,
    description text NOT NULL,
    PRIMARY KEY (ean),
    FOREIGN KEY(category) REFERENCES category(name) -- RI_RE6
);
CREATE TABLE has_category (
    ean VARCHAR(13) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (ean, name),
    FOREIGN KEY(ean) REFERENCES product(ean),
    FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE IVM (
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    PRIMARY KEY (serial_num, manuf)
);
CREATE TABLE retail_point (
    name VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    county VARCHAR(255) NOT NULL,
    -- concelho (?)
    PRIMARY KEY (name)
);
CREATE TABLE installed_on (
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    local VARCHAR(255) NOT NULL,
    PRIMARY KEY (serial_num, manuf),
    FOREIGN KEY(serial_num, manuf) REFERENCES IVM(serial_num, manuf),
    FOREIGN KEY(local) REFERENCES retail_point(name)
);
CREATE TABLE shelf (
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    height VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (number, serial_num, manuf),
    FOREIGN KEY(serial_num, manuf) REFERENCES IVM(serial_num, manuf),
    FOREIGN KEY(name) REFERENCES category(name)
);
CREATE TABLE planogram(
    ean VARCHAR(13) NOT NULL,
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    face VARCHAR(255) NOT NULL,
    units VARCHAR(255) NOT NULL,
    loc VARCHAR(255) NOT NULL,
    PRIMARY KEY (ean, number, serial_num, manuf),
    FOREIGN KEY(ean) REFERENCES product(ean),
    FOREIGN KEY(number, serial_num, manuf) REFERENCES shelf(number, serial_num, manuf)
);
CREATE TABLE retailer(
    tin VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (tin) -- RI-RE7 (DONE)
);
CREATE TABLE responsible_for(
    cat_name VARCHAR(255) NOT NULL,
    tin VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    PRIMARY KEY (serial_num, manuf),
    FOREIGN KEY(serial_num, manuf) REFERENCES IVM(serial_num, manuf),
    FOREIGN KEY(tin) REFERENCES retailer(tin),
    FOREIGN KEY(cat_name) REFERENCES category(name)
);
CREATE TABLE replenshiment_event(
    ean VARCHAR(13) NOT NULL,
    number VARCHAR(255) NOT NULL,
    serial_num VARCHAR(255) NOT NULL,
    manuf VARCHAR(255) NOT NULL,
    instant timestamp NOT NULL,
    units VARCHAR(255) NOT NULL,
    tin VARCHAR(255) NOT NULL,
    PRIMARY KEY (ean, number, serial_num, manuf, instant),
    FOREIGN KEY (ean, number, serial_num, manuf) REFERENCES planogram(ean, number, serial_num, manuf),
    FOREIGN KEY(tin) REFERENCES retailer(tin) -- RI-RE8 
);