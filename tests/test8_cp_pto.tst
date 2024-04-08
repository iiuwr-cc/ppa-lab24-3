L000: a = &b;
L001: z = &a;
L002: if ! (1 > 0) goto L005;
L003: x = &z;
L004: goto L006;
L005: x = null;
L006: skip;
L007: t = *x;
L008: *t = &u;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ b=⊤ t=⊤ u=⊤ x=⊤ z=⊤'
//@   out: 'a=⊤ b=⊤ t=⊤ u=⊤ x=⊤ z=⊤'
//@ label 'Lexit'
//@    in: 'a=&amp;u b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;u b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@ label 'L000'
//@    in: 'a=⊤ b=⊤ t=⊤ u=⊤ x=⊤ z=⊤'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=⊤'
//@ label 'L001'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=⊤'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@ label 'L002'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@ label 'L003'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a'
//@ label 'L004'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a'
//@ label 'L005'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=N z=&amp;a'
//@ label 'L006'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@ label 'L007'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@ label 'L008'
//@    in: 'a=&amp;b b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
//@   out: 'a=&amp;u b=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a'
