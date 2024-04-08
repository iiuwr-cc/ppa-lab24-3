L000: x = 6;
L001: *x = *y;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'Lexit'
//@    in: 'BOT'
//@   out: 'BOT'
//@ label 'L000'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L001'
//@    in: 'x={}, y={}'
//@   out: 'BOT'
