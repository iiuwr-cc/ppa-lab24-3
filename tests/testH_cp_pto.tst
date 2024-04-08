L000: if ! (1 < 0) goto L003;
L001: x = 6;
L002: goto L004;
L003: x = null;
L004: skip;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤'
//@   out: 'x=⊤'
//@ label 'Lexit'
//@    in: 'x=⊤'
//@   out: 'x=⊤'
//@ label 'L000'
//@    in: 'x=⊤'
//@   out: 'x=⊤'
//@ label 'L001'
//@    in: 'x=⊤'
//@   out: 'x=6'
//@ label 'L002'
//@    in: 'x=6'
//@   out: 'x=6'
//@ label 'L003'
//@    in: 'x=⊤'
//@   out: 'x=N'
//@ label 'L004'
//@    in: 'x=⊤'
//@   out: 'x=⊤'
