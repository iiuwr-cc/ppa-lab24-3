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
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@ label 'L004'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L005'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L006'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={}'
//@ label 'L007'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L008'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L009'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@ label 'L010'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z}, z={a}, zz={aa}'
//@ label 'L011'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L012'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L013'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L014'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={}, z={a}, zz={aa}'
//@ label 'L015'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={zz}, z={a}, zz={aa}'
//@ label 'L016'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@ label 'L017'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b}, aa={bb}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@ label 'L018'
//@    in: 'a={b}, aa={bb}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
//@   out: 'a={b, u}, aa={bb, u}, b={}, bb={}, t={a, aa}, u={}, x={z, zz}, z={a}, zz={aa}'
