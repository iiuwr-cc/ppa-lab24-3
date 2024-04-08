L000: a = &b;
L001: aa = &bb;
L002: z = &a;
L003: zz = &aa;
L004: if ! (1 > 0) goto L007;
L005: x = &z;
L006: goto L008;
L007: x = &zz;
L008: skip;
L009: t = *x;
L010: *t = &u;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@ label 'Lexit'
//@    in: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L000'
//@    in: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@   out: 'a=&amp;b aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@ label 'L001'
//@    in: 'a=&amp;b aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@ label 'L002'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L003'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L004'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L005'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=&amp;aa'
//@ label 'L006'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=&amp;aa'
//@ label 'L007'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=&amp;aa'
//@ label 'L008'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L009'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L010'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
