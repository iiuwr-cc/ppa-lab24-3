L000: x = 1;
L001: x = *&x;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤'
//@   out: 'x=⊤'
//@ label 'Lexit'
//@    in: 'x=1'
//@   out: 'x=1'
//@ label 'L000'
//@    in: 'x=⊤'
//@   out: 'x=1'
//@ label 'L001'
//@    in: 'x=1'
//@   out: 'x=1'
