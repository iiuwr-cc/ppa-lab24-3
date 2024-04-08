L000: z = &zz;
L001: zz = &zzz;
L002: y = &yy;
L003: yy = &yyy;
L004: if ! (b == 1) goto L007;
L005: x = &z;
L006: goto L008;
L007: x = &y;
L008: skip;
L009: ***x = &test;
L010: **x = &test;
L011: *x = &test;
L012: x = &test;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'Lexit'
//@    in: 'b=⊤ test=⊤ x=&amp;test y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;test y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'L000'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@ label 'L001'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L002'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L003'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L004'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L005'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;z y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L006'
//@    in: 'b=⊤ test=⊤ x=&amp;z y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;z y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L007'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;y y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L008'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L009'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@ label 'L010'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=⊤ z=&amp;zz zz=&amp;zzz zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@ label 'L011'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=⊤ z=&amp;zz zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'L012'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=&amp;test y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
