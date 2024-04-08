L000: x = null;
L001: x = malloc;

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
//@   out: 'x=N'
//@ label 'L001'
//@    in: 'x=N'
//@   out: 'x=⊤'
