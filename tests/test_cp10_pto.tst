L000: a = 1;
L001: b = 2;
L002: *x = 42;
L003: c = a + b;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'Lexit'
//@    in: 'c={}'
//@   out: 'c={}'
//@ label 'L000'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L001'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'a={}, b={}, c={}, x={}'
//@ label 'L002'
//@    in: 'a={}, b={}, c={}, x={}'
//@   out: 'BOT'
//@ label 'L003'
//@    in: 'BOT'
//@   out: 'c={}'
