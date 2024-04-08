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
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, aa={}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@   out: 'a={}, aa={}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@ label 'Lexit'
//@    in: 'a={b, u}, aa={bb, u}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b, u}, aa={bb, u}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@ label 'L000'
//@    in: 'a={}, aa={}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@   out: 'a={b}, aa={}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@ label 'L001'
//@    in: 'a={b}, aa={}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@ label 'L002'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={}, zz={}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@ label 'L003'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L004'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L005'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@ label 'L006'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@ label 'L007'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L008'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L009'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L010'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L011'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L012'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@ label 'L013'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@ label 'L014'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b, u}, aa={bb, u}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
