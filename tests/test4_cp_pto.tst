L000: x = 6;
L001: *x = *y;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'x=6 y=⊤'
//@   out: 'x=6 y=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=6 y=⊤'
//@ label 'L001'
//@    in: 'x=6 y=⊤'
//@   out: 'x=6 y=⊤'
