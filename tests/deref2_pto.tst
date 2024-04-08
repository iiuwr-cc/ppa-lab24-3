L000: x = &y;
L001: x = *&x;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'Lexit'
//@    in: 'x={y}, y={}'
//@   out: 'x={y}, y={}'
//@ label 'L000'
//@    in: 'x={}, y={}'
//@   out: 'x={y}, y={}'
//@ label 'L001'
//@    in: 'x={y}, y={}'
//@   out: 'x={y}, y={}'
