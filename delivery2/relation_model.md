Relations:

- Point of Retail(a̲d̲d̲r̲e̲s̲s̲, name)

- IVM (s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲)

- installed-at(a̲d̲d̲r̲e̲s̲s̲,s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, nr)

  - address: FK(Point of Retail)
  - serial_number, manuf: FK(IVM.serial_number, IVM.manuf)

- Retailer(T̲I̲N̲, name)

  - UNIQUE(name)

- Category(n̲a̲m̲e̲)

- Simple Category(n̲a̲m̲e̲)

  - name: FK (Category)

- Super Category(n̲a̲m̲e̲)

  - name: FK (Category)

- has-other(c̲a̲t̲e̲g̲o̲r̲y̲_n̲a̲m̲e̲, s̲u̲p̲e̲r̲_c̲a̲t̲e̲g̲o̲r̲y̲_n̲a̲m̲e̲)

  - category_name: FK(Category.name)
  - super_category_name: FK(Super Category.name)
	- UNIQUE(category_name)

- Product(E͟A͟N͟, descr)

- has(E͟A͟N͟, n̲a̲m̲e̲)

  - EAN: FK(Product)
  - name: FK(Category)

(Atributo name, derivado da relação M:1
Ver slide 47 de BD S02 - Hora 04 - Modelo Relacional e Conversão - Parte I)

- Shelf(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, height, width, category_name)

  - serial number: FK(IVM)
  - manuf: FK(IVM)
  - category_name: FK(Category.name)

// missing IC's

- Warm Shelf(n̲r̲, s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲)

  - nr, serial_number, manuf: FK (Shelf.nr, Shelf.serial_number, Shelf.manuf)

- Ambient Temperature Shelf(n̲r̲, s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲)

  - nr, serial_number, manuf: FK (Shelf.nr, Shelf.serial_number, Shelf.manuf)

- Cold Shelf(n̲r̲, s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲)

  - nr, serial_number, manuf: FK (Shelf.nr, Shelf.serial_number, Shelf.manuf)

- planogram(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, E͟A͟N͟, faces, units, loc)
  - nr, serial_number, manuf: FK(Shelf.nr, Shelf.serial_number, Shelf.manuf)
	// podemos meter só Shelf em vez de tudo?
  - EAN: FK(Product)

(Dúvidas neste do evento)
(Combinacao do slide 47 do BD S02 - Hora 04 - Modelo Relacional e Conversão - Parte I e
slide 18 do BD S03 - Hora 01 - Modelo Relacional e Conversão - Parte II)
(Comprovativo no slide 9 da solução do lab5 da Eden box)

(Atributo TIN, derivado da relação M:1
Ver slide 47 de BD S02 - Hora 04 - Modelo Relacional e Conversão - Parte I)

- Replenishment Event(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, n̲r̲, E͟A͟N͟, i̲n̲s̲t̲a̲n̲t̲, units,TIN)

  - serial_number, manuf, nr, EAN: FK(planogram.serial_number(?) ,planogram.manuf(?) , planogram.nr, planogram.EAN)
  - TIN: FK(Retailer)

- responsible-for(s̲e̲r̲i̲a̲l̲_n̲u̲m̲b̲e̲r̲, m̲a̲n̲u̲f̲, T̲I̲N̲, n̲a̲m̲e̲)
  - serial_number, manuf: FK(IVM)
  - TIN: FK(Retailer)
  - name: FK(Category)

Constraints:

- name must exist in Simple Category or Super Category
- name never existes in both Simple Category and Super Category simultaneously

- category_name is always different from super_category_name

- Every product(EAN) has a category

- nr must exist in Warm Shelf, Ambient Temperature Shelf or Cold Shelf
- nr never existes in Warm Shelf, Ambient Temperature Shelf and Cold Shelf simultaneously

- nr must exist in Positive Cold Shelf or Negative Cold Shelf(?)
- nr never exists in Positive Cold Shelf and Negative Cold Shelf simultaneously (?)
