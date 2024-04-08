L000: x = &y;
L001: x = *&x;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'x=&amp;y y=⊤'
//@   out: 'x=&amp;y y=⊤'
//@ label 'L000'
//@    in: 'x=⊤ y=⊤'
//@   out: 'x=&amp;y y=⊤'
//@ label 'L001'
//@    in: 'x=&amp;y y=⊤'
//@   out: 'x=&amp;y y=⊤'
