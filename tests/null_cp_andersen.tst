L000: y = 1;
L001: if ! (1 < 0) goto L004;
L002: x = &y;
L003: goto L005;
L004: x = null;
L005: skip;
L006: y = *x;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=1'
//@ label 'L001'
//@    in: 'x=⊤ y=1'
//@   out: 'x=⊤ y=1'
//@ label 'L002'
//@    in: 'x=⊤ y=1'
//@   out: 'x=&amp;y y=1'
//@ label 'L003'
//@    in: 'x=&amp;y y=1'
//@   out: 'x=&amp;y y=1'
//@ label 'L004'
//@    in: 'x=⊤ y=1'
//@   out: 'x=N y=1'
//@ label 'L005'
//@    in: 'x=⊤ y=1'
//@   out: 'x=⊤ y=1'
//@ label 'L006'
//@    in: 'x=⊤ y=1'
//@   out: 'x=⊤ y=⊤'
