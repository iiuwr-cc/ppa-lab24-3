L000: a = 1;
L001: b = 1;
L002: if ! (1 < 0) goto L007;
L003: x = &a;
L004: *x = 3;
L005: c = a + b;
L006: goto L010;
L007: x = &b;
L008: *x = 3;
L009: c = a + b;
L010: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'Lexit'
//@    in: 'a={}, b={}, c={}, x={a, b}'
//@   out: 'a={}, b={}, c={}, x={a, b}'
//@ label 'L000'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L001'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L002'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L003'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L004'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L005'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L006'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L007'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L008'
//@    in: 'a={}, b={}, c={}, x={b}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L009'
//@    in: 'a={}, b={}, c={}, x={b}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L010'
//@    in: 'a={}, b={}, c={}, x={a, b}'
//@   out: 'a={}, b={}, c={}, x={a, b}'
