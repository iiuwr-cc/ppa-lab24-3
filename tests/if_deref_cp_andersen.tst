L000: x = 1;
L001: y = 2;
L002: if ! (x < y) goto L006;
L003: z = &x;
L004: *z = 2;
L005: goto L008;
L006: z = &y;
L007: *z = 3;
L008: skip;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=1 y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤ z=⊤'
//@   out: 'x=1 y=2 z=⊤'
//@ label 'L002'
//@    in: 'x=1 y=2 z=⊤'
//@   out: 'x=1 y=2 z=⊤'
//@ label 'L003'
//@    in: 'x=1 y=2 z=⊤'
//@   out: 'x=1 y=2 z=&amp;x'
//@ label 'L004'
//@    in: 'x=1 y=2 z=&amp;x'
//@   out: 'x=⊤ y=⊤ z=&amp;x'
//@ label 'L005'
//@    in: 'x=⊤ y=⊤ z=&amp;x'
//@   out: 'x=⊤ y=⊤ z=&amp;x'
//@ label 'L006'
//@    in: 'x=1 y=2 z=⊤'
//@   out: 'x=1 y=2 z=&amp;y'
//@ label 'L007'
//@    in: 'x=1 y=2 z=&amp;y'
//@   out: 'x=⊤ y=⊤ z=&amp;y'
//@ label 'L008'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
