1.  (σ sum>10( EAN, descr G sum(units)( σinstant > "2021/12/31" (σCategoria = "Barras Energéticas" (Product ⨝ Category ) ⨝ Replenishment Event)))

2.  π serial_number(σ EAN = "9002490100070" ( Product ⨝ Category ⨝ IVM))

3.  σSuper_Category = "Sopas Take-Away" (super_Category G count(has-other) )

4.  π EAN, desc (EAN Gmax(units) ((Product ⨝ Replenishment Event))
