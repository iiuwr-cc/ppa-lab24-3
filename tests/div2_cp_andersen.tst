L000: x = 1;
L001: y = 2;
L002: z = x / y;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=1 y=2 z=0'
//@   out: 'x=1 y=2 z=0'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=1 y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤ z=⊤'
//@   out: 'x=1 y=2 z=⊤'
//@ label 'L002'
//@    in: 'x=1 y=2 z=⊤'
//@   out: 'x=1 y=2 z=0'
