L000: a = 1;
L001: b = 1;
L002: if ! (1 < 0) goto L005;
L003: x = &a;
L004: goto L006;
L005: x = &b;
L006: skip;
L007: *x = 3;
L008: c = a + b;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@ label 'Lexit'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
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
//@   out: 'a=1 b=1 c=⊤ x=&amp;a'
//@ label 'L005'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=&amp;b'
//@ label 'L006'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=1 b=1 c=⊤ x=⊤'
//@ label 'L007'
//@    in: 'a=1 b=1 c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@ label 'L008'
//@    in: 'a=⊤ b=⊤ c=⊤ x=⊤'
//@   out: 'a=⊤ b=⊤ c=⊤ x=⊤'
