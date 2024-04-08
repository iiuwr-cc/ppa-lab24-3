L000: x = 1;
L001: y = 0;
L002: z = x / y;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=1 y=0 z=⊥'
//@   out: 'x=1 y=0 z=⊥'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=1 y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤ z=⊤'
//@   out: 'x=1 y=0 z=⊤'
//@ label 'L002'
//@    in: 'x=1 y=0 z=⊤'
//@   out: 'x=1 y=0 z=⊥'
