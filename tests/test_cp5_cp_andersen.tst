L000: x = &y;
L001: y = 1;
L002: z = *x;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=⊤ y=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'x=&amp;y y=1 z=1'
//@   out: 'x=&amp;y y=1 z=1'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤ z=⊤'
//@   out: 'x=&amp;y y=⊤ z=⊤'
//@ label 'L001'
//@    in: 'x=&amp;y y=⊤ z=⊤'
//@   out: 'x=&amp;y y=1 z=⊤'
//@ label 'L002'
//@    in: 'x=&amp;y y=1 z=⊤'
//@   out: 'x=&amp;y y=1 z=1'
