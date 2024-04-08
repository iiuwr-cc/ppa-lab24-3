L000: x = 1;
L001: y = &x;
L002: *y = 2;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'Lexit'
//@    in: 'x={}, y={x}'
//@   out: 'x={}, y={x}'
//@ label 'L000'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L001'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={x}'
//@ label 'L002'
//@    in: 'x={}, y={x}'
//@   out: 'x={}, y={x}'
