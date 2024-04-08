L000: a = 1;
L001: b = 2;
L002: x = &a;
L003: *x = 3;
L004: c = a + b;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@ label 'Lexit'
//@    in: 'a=3 b=2 c=5 x=&amp;a'
//@   out: 'a=3 b=2 c=5 x=&amp;a'
//@ label 'L000'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=⊤ c=⊤ x=⊤'
//@ label 'L001'
//@    in: 'a=1 b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=2 c=⊤ x=⊤'
//@ label 'L002'
//@    in: 'a=1 b=2 c=⊤ x=⊤'
//@   out: 'a=1 b=2 c=⊤ x=&amp;a'
//@ label 'L003'
//@    in: 'a=1 b=2 c=⊤ x=&amp;a'
//@   out: 'a=3 b=2 c=⊤ x=&amp;a'
//@ label 'L004'
//@    in: 'a=3 b=2 c=⊤ x=&amp;a'
//@   out: 'a=3 b=2 c=5 x=&amp;a'
