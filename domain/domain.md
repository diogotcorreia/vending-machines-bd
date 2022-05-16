### Vending Machine

- serial_number (primary key)

- retail_place

### Retail Place

- name

- address

### Address

- street
- postal_code
- city
- country

primary key (street, postal_code, city, country)

### Retailer

- tin (primary key)
- name (unique)

### Shelf

- shelf_id (primary key)
- height (in cm)
- width (in cm)

#### Specialization

- ambient temperature
- hot
- cold
  - positive cold
  - negative cold

### Planogram

// TODO

### Product

- ean (primary key - varchar(13))
- description
- brand
- name

either brand or name must not be null
(TODO: can they both be non null (?))

- category

#### Specialization

- flexible
- rigid

### Category

- name (primary key)

- parent category (nullable)

// TODO is count of sub categories recursive?

#### Specialization

Specialization 1

- ambient temperature
- hot
- cold
  - positive cold
  - negative cold

Specialization 2

- super category
- simple category

### Retailer Restock

- retailer
- category (primary key)
- vending_machine (primary key)

primary_key (category, vending_machine)

### Restock Event

- timestamp (primary key)
- restock_count (primary key, (?))

- product (?)
- retailer / retailer restock

# Doubts

> O pessoal reabastecedor deve assegurar que a prateleira esteja limpa e organizada.
