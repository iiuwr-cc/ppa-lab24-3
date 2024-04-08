L000: x = 1;
L001: x = *&x;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}'
//@   out: 'x={}'
//@ label 'Lexit'
//@    in: 'x={}'
//@   out: 'x={}'
//@ label 'L000'
//@    in: 'x={}'
//@   out: 'x={}'
//@ label 'L001'
//@    in: 'x={}'
//@   out: 'x={}'
