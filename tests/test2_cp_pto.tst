L000: if ! (x < 0) goto L003;
L001: p = &y;
L002: goto L004;
L003: p = &z;
L004: skip;
L005: *p = &t;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L000'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=&amp;y t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L002'
//@    in: 'p=&amp;y t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=&amp;y t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L003'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=&amp;z t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L004'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L005'
//@    in: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'p=⊤ t=⊤ x=⊤ y=⊤ z=⊤'
