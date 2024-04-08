L000: z = &zz;
L001: zz = &zzz;
L002: y = &zz;
L003: if ! (b == 1) goto L006;
L004: x = &z;
L005: goto L007;
L006: x = &y;
L007: skip;
L008: ***x = &test;
L009: **x = &test;
L010: *x = &test;
L011: x = &test;

//@PRACOWNIA
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'Lexit'
//@    in: 'b=⊤ test=⊤ x=&amp;test y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;test y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'L000'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@ label 'L001'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L002'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L003'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L004'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;z y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L005'
//@    in: 'b=⊤ test=⊤ x=&amp;z y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;z y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L006'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;y y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L007'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L008'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L009'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=⊤ zzz=⊤'
//@ label 'L010'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;zz z=&amp;zz zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'L011'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;test y=⊤ z=⊤ zz=⊤ zzz=⊤'
