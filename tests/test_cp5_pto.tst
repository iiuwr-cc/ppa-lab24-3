L000: x = &y;
L001: y = 1;
L002: z = *x;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'Lexit'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L000'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L001'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L002'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
