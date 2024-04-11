L000: a = 1;
L001: b = 2;
L002: x = &b;
L003: *x = 42;
L004: c = a + b;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@ label 'Lexit'
//@    in: 'a=1 b=42 c=43 x=&amp;b'
//@   out: 'a=1 b=42 c=43 x=&amp;b'
//@ label 'L000'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=⊤ c=⊤ x=⊤'
//@ label 'L001'
//@    in: 'a=1 b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=2 c=⊤ x=⊤'
//@ label 'L002'
//@    in: 'a=1 b=2 c=⊤ x=⊤'
//@   out: 'a=1 b=2 c=⊤ x=&amp;b'
//@ label 'L003'
//@    in: 'a=1 b=2 c=⊤ x=&amp;b'
//@   out: 'a=1 b=42 c=⊤ x=&amp;b'
//@ label 'L004'
//@    in: 'a=1 b=42 c=⊤ x=&amp;b'
//@   out: 'a=1 b=42 c=43 x=&amp;b'
