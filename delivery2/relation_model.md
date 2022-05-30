Relations:

- Point of Retail(a̲d̲d̲r̲e̲s̲s̲, name)

- IVM (s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲)

- Retailer(T̲I̲N̲, name)

  - unique(name)

- Category(n̲a̲m̲e̲)

- Simple Category(n̲a̲m̲e̲)

  - name: FK (Category)

- Super Category(n̲a̲m̲e̲)

  - name: FK (Category)

- Product(E͟A͟N͟, descr)

- Shelf(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, height, width)

  - serial number: FK(IVM)
  - manuf: FK(IVM)

- Warm Shelf(n̲r̲)

  - nr: FK (Shelf)

- Ambient Temperature Shelf(n̲r̲)

  - nr: FK (Shelf)

- Cold Shelf(n̲r̲)

  - nr: FK (Shelf)

- Positive Cold Shelf(n̲r̲)

  - nr: FK (Cold Shelf.nr)

- Negatie Cold Shelf(n̲r̲)

  - nr: FK (Cold Shelf.nr)

(Dúvidas neste do evento)
(Combinacao do slide 47 do BD S02 - Hora 04 - Modelo Relacional e Conversão - Parte I e
slide 18 do BD S03 - Hora 01 - Modelo Relacional e Conversão - Parte II)

- Replenishment Event(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, E͟A͟N͟, i̲n̲s̲t̲a̲n̲t̲, units)
  - s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, E͟A͟N͟: FK(planogram.serial_number(?) ,planogram.manuf(?) , planogram.nr, planogram.EAN)

Constraints:

- name must exist in Simple Category or Super Category
- name never existes in both Simple Category and Super Category simultaneously

- nr must exist in Warm Shelf, Ambient Temperature Shelf or Cold Shelf
- nr never existes in Warm Shelf, Ambient Temperature Shelf and Cold Shelf simultaneously

- nr must exist in Positive Cold Shelf or Negative Cold Shelf(?)
- nr never exists in Positive Cold Shelf and Negative Cold Shelf simultaneously (?)
