L000: a = &b;
L001: aa = &bb;
L002: z = &a;
L003: zz = &aa;
L004: if ! (1 > 0) goto L007;
L005: x = &z;
L006: goto L012;
L007: if ! (1 > 0) goto L010;
L008: x = &zz;
L009: goto L011;
L010: x = null;
L011: skip;
L012: skip;
L013: t = *x;
L014: *t = &u;

//@PRACOWNIA
//@analysis cp_mem_andersen
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
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L008'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=&amp;aa'
//@ label 'L009'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=&amp;aa'
//@ label 'L010'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=N z=&amp;a zz=&amp;aa'
//@ label 'L011'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L012'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L013'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L014'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
