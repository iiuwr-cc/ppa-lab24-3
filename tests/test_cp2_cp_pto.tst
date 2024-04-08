L000: x = 1;
L001: y = &x;
L002: z = &y;
L003: **z = 2;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=2 y=&amp;x z=&amp;y'
//@   out: 'x=2 y=&amp;x z=&amp;y'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=1 y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤ z=⊤'
//@   out: 'x=1 y=&amp;x z=⊤'
//@ label 'L002'
//@    in: 'x=1 y=&amp;x z=⊤'
//@   out: 'x=1 y=&amp;x z=&amp;y'
//@ label 'L003'
//@    in: 'x=1 y=&amp;x z=&amp;y'
//@   out: 'x=2 y=&amp;x z=&amp;y'
