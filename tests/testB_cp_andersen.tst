L000: if ! (1 < 0) goto L003;
L001: x = null;
L002: goto L004;
L003: x = &y;
L004: skip;
L005: *x = &z;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=⊤ y=&amp;z z=⊤'
//@   out: 'x=⊤ y=&amp;z z=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=N y=⊤ z=⊤'
//@ label 'L002'
//@    in: 'x=N y=⊤ z=⊤'
//@   out: 'x=N y=⊤ z=⊤'
//@ label 'L003'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=&amp;y y=⊤ z=⊤'
//@ label 'L004'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'L005'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=&amp;z z=⊤'
