L000: zzz = 1;
L001: yyy = 1;
L002: z = &zz;
L003: zz = &zzz;
L004: y = &yy;
L005: yy = &yyy;
L006: if ! (b == 1) goto L010;
L007: x = &z;
L008: test = ***x;
L009: goto L012;
L010: x = &y;
L011: test = ***x;
L012: skip;

//@PRACOWNIA
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@ label 'Lexit'
//@    in: 'b=⊤ test=1 x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=1 x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L000'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=⊤'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=1'
//@ label 'L001'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=⊤ z=⊤ zz=⊤ zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=⊤ zz=⊤ zzz=1'
//@ label 'L002'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=⊤ zz=⊤ zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=&amp;zz zz=⊤ zzz=1'
//@ label 'L003'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=&amp;zz zz=⊤ zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L004'
//@    in: 'b=⊤ test=⊤ x=⊤ y=⊤ yy=⊤ yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L005'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=⊤ yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L006'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L007'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=⊤ x=&amp;z y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L008'
//@    in: 'b=⊤ test=⊤ x=&amp;z y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=1 x=&amp;z y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L009'
//@    in: 'b=⊤ test=1 x=&amp;z y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=1 x=&amp;z y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L010'
//@    in: 'b=⊤ test=⊤ x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=⊤ x=&amp;y y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L011'
//@    in: 'b=⊤ test=⊤ x=&amp;y y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=1 x=&amp;y y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@ label 'L012'
//@    in: 'b=⊤ test=1 x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
//@   out: 'b=⊤ test=1 x=⊤ y=&amp;yy yy=&amp;yyy yyy=1 z=&amp;zz zz=&amp;zzz zzz=1'
