L000: x = 1;
L001: y = &x;
L002: z = &y;
L003: **z = 2;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'Lexit'
//@    in: 'x={}, y={x}, z={y}'
//@   out: 'x={}, y={x}, z={y}'
//@ label 'L000'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'L001'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={x}, z={}'
//@ label 'L002'
//@    in: 'x={}, y={x}, z={}'
//@   out: 'x={}, y={x}, z={y}'
//@ label 'L003'
//@    in: 'x={}, y={x}, z={y}'
//@   out: 'x={}, y={x}, z={y}'
