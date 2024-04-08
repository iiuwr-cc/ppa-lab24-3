L000: x = 1;
L001: y = 2;
L002: if ! (x < y) goto L006;
L003: y = 3;
L004: x = 2;
L005: goto L008;
L006: y = x + y;
L007: x = 3;
L008: skip;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'x=⊤ y=3'
//@   out: 'x=⊤ y=3'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=1 y=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤'
//@   out: 'x=1 y=2'
//@ label 'L002'
//@    in: 'x=1 y=2'
//@   out: 'x=1 y=2'
//@ label 'L003'
//@    in: 'x=1 y=2'
//@   out: 'x=1 y=3'
//@ label 'L004'
//@    in: 'x=1 y=3'
//@   out: 'x=2 y=3'
//@ label 'L005'
//@    in: 'x=2 y=3'
//@   out: 'x=2 y=3'
//@ label 'L006'
//@    in: 'x=1 y=2'
//@   out: 'x=1 y=3'
//@ label 'L007'
//@    in: 'x=1 y=3'
//@   out: 'x=3 y=3'
//@ label 'L008'
//@    in: 'x=⊤ y=3'
//@   out: 'x=⊤ y=3'
