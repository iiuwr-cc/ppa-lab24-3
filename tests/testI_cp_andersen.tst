L000: x = 25;
L001: y = 100;
L002: z = malloc;
L003: *z = &x;
L004: *z = &y;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=25 y=100 z=⊤'
//@   out: 'x=25 y=100 z=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=25 y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=25 y=⊤ z=⊤'
//@   out: 'x=25 y=100 z=⊤'
//@ label 'L002'
//@    in: 'x=25 y=100 z=⊤'
//@   out: 'x=25 y=100 z=⊤'
//@ label 'L003'
//@    in: 'x=25 y=100 z=⊤'
//@   out: 'x=25 y=100 z=⊤'
//@ label 'L004'
//@    in: 'x=25 y=100 z=⊤'
//@   out: 'x=25 y=100 z=⊤'
