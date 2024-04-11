L000: a = 1;
L001: b = 2;
L002: x = &b;
L003: *x = 42;
L004: c = a + b;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'Lexit'
//@    in: 'a={}, b={}, c={}, x={b}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L000'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L001'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L002'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L003'
//@    in: 'a={}, b={}, c={}, x={b}'
//@   out: 'a={}, b={}, c={}, x={b}'
//@ label 'L004'
//@    in: 'a={}, b={}, c={}, x={b}'
//@   out: 'a={}, b={}, c={}, x={b}'
