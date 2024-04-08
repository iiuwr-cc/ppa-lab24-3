L000: x = 1;
L001: y = null;
L002: *y = 2;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'x=1 y=N'
//@   out: 'x=1 y=N'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=1 y=⊤'
//@ label 'L001'
//@    in: 'x=1 y=⊤'
//@   out: 'x=1 y=N'
//@ label 'L002'
//@    in: 'x=1 y=N'
//@   out: 'x=1 y=N'
