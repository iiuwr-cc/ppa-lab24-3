L000: a = 1;
L001: b = 1;
L002: if ! (1 < 0) goto L007;
L003: x = &a;
L004: *x = 3;
L005: c = a + b;
L006: goto L010;
L007: x = &b;
L008: *x = 3;
L009: c = a + b;
L010: skip;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@ label 'Lexit'
//@    in: 'a=⊤ b=⊤ c=4 x=⊤'
//@   out: 'a=⊤ b=⊤ c=4 x=⊤'
//@ label 'L000'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=⊤ c=⊤ x=⊤'
//@ label 'L001'
//@    in: 'a=1 b=⊤ c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=⊤'
//@ label 'L002'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=⊤'
//@ label 'L003'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=&amp;a'
//@ label 'L004'
//@    in: 'a=1 b=1 c=⊤ x=&amp;a'
//@   out: 'a=3 b=1 c=⊤ x=&amp;a'
//@ label 'L005'
//@    in: 'a=3 b=1 c=⊤ x=&amp;a'
//@   out: 'a=3 b=1 c=4 x=&amp;a'
//@ label 'L006'
//@    in: 'a=3 b=1 c=4 x=&amp;a'
//@   out: 'a=3 b=1 c=4 x=&amp;a'
//@ label 'L007'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=&amp;b'
//@ label 'L008'
//@    in: 'a=1 b=1 c=⊤ x=&amp;b'
//@   out: 'a=1 b=3 c=⊤ x=&amp;b'
//@ label 'L009'
//@    in: 'a=1 b=3 c=⊤ x=&amp;b'
//@   out: 'a=1 b=3 c=4 x=&amp;b'
//@ label 'L010'
//@    in: 'a=⊤ b=⊤ c=4 x=⊤'
//@   out: 'a=⊤ b=⊤ c=4 x=⊤'
