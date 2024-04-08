L000: a = &b;
L001: aa = &bb;
L002: z = &a;
L003: if ! (1 > 0) goto L006;
L004: zz = &aa;
L005: goto L007;
L006: zz = null;
L007: skip;
L008: if ! (1 > 0) goto L011;
L009: x = &z;
L010: goto L016;
L011: if ! (1 > 0) goto L014;
L012: x = &zz;
L013: goto L015;
L014: x = null;
L015: skip;
L016: skip;
L017: t = *x;
L018: *t = &u;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=⊤ zz=⊤'
//@ label 'Lexit'
//@    in: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
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
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L004'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L005'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=&amp;aa'
//@ label 'L006'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=N'
//@ label 'L007'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L008'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L009'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=⊤'
//@ label 'L010'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;z z=&amp;a zz=⊤'
//@ label 'L011'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L012'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=⊤'
//@ label 'L013'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=&amp;zz z=&amp;a zz=⊤'
//@ label 'L014'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=N z=&amp;a zz=⊤'
//@ label 'L015'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L016'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L017'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@ label 'L018'
//@    in: 'a=&amp;b aa=&amp;bb b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
//@   out: 'a=⊤ aa=⊤ b=⊤ bb=⊤ t=⊤ u=⊤ x=⊤ z=&amp;a zz=⊤'
