L000: a = 1;
L001: b = 2;
L002: x = &a;
L003: *x = 3;
L004: c = a + b;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'Lexit'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L000'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L001'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L002'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L003'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
//@ label 'L004'
//@    in: 'a={}, b={}, c={}, x={a}'
//@   out: 'a={}, b={}, c={}, x={a}'
