L000: if ! (1 > 0) goto L004;
L001: x = null;
L002: y = &z;
L003: goto L006;
L004: x = &z;
L005: y = null;
L006: skip;
L007: if ! (1 > 0) goto L010;
L008: *y = &test1;
L009: goto L011;
L010: *x = &test2;
L011: skip;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L000'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=N y=⊤ z=⊤'
//@ label 'L002'
//@    in: 'test1=⊤ test2=⊤ x=N y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=N y=&amp;z z=⊤'
//@ label 'L003'
//@    in: 'test1=⊤ test2=⊤ x=N y=&amp;z z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=N y=&amp;z z=⊤'
//@ label 'L004'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=&amp;z y=⊤ z=⊤'
//@ label 'L005'
//@    in: 'test1=⊤ test2=⊤ x=&amp;z y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=&amp;z y=N z=⊤'
//@ label 'L006'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L007'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@ label 'L008'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=&amp;test1'
//@ label 'L009'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=&amp;test1'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=&amp;test1'
//@ label 'L010'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=&amp;test2'
//@ label 'L011'
//@    in: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
//@   out: 'test1=⊤ test2=⊤ x=⊤ y=⊤ z=⊤'
