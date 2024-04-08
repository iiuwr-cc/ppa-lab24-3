L000: p = malloc;
L001: x = y;
L002: x = z;
L003: *p = z;
L004: p = q;
L005: q = &y;
L006: x = *p;
L007: p = &z;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'p=&amp;z q=&amp;y x=⊤ y=⊤ z=⊤'
//@   out: 'p=&amp;z q=&amp;y x=⊤ y=⊤ z=⊤'
//@ label 'L000'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L002'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L003'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L004'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L005'
//@    in: 'p=⊤ q=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=&amp;y x=⊤ y=⊤ z=⊤'
//@ label 'L006'
//@    in: 'p=⊤ q=&amp;y x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ q=&amp;y x=⊤ y=⊤ z=⊤'
//@ label 'L007'
//@    in: 'p=⊤ q=&amp;y x=⊤ y=⊤ z=⊤'
//@   out: 'p=&amp;z q=&amp;y x=⊤ y=⊤ z=⊤'
