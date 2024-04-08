L000: a = &b;
L001: z = &a;
L002: if ! (1 > 0) goto L005;
L003: x = &z;
L004: goto L006;
L005: x = null;
L006: skip;
L007: if ! (1 > 0) goto L009;
L008: z = null;
L009: skip;
L010: t = *x;
L011: *t = &u;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, b={}, t={}, u={}, x={}, z={}'
//@   out: 'a={}, b={}, t={}, u={}, x={}, z={}'
//@ label 'Lexit'
//@    in: 'a={u}, b={}, t={a}, u={}, x={z}, z={a}'
//@   out: 'a={u}, b={}, t={a}, u={}, x={z}, z={a}'
//@ label 'L000'
//@    in: 'a={}, b={}, t={}, u={}, x={}, z={}'
//@   out: 'a={b}, b={}, t={}, u={}, x={}, z={}'
//@ label 'L001'
//@    in: 'a={b}, b={}, t={}, u={}, x={}, z={}'
//@   out: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@ label 'L002'
//@    in: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@ label 'L003'
//@    in: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@ label 'L004'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@ label 'L005'
//@    in: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={}, z={a}'
//@ label 'L006'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@ label 'L007'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@ label 'L008'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={}'
//@ label 'L009'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@ label 'L010'
//@    in: 'a={b}, b={}, t={}, u={}, x={z}, z={a}'
//@   out: 'a={b}, b={}, t={a}, u={}, x={z}, z={a}'
//@ label 'L011'
//@    in: 'a={b}, b={}, t={a}, u={}, x={z}, z={a}'
//@   out: 'a={u}, b={}, t={a}, u={}, x={z}, z={a}'
