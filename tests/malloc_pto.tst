L000: x = null;
L001: x = malloc;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L001={}, x={}'
//@   out: 'L001={}, x={}'
//@ label 'Lexit'
//@    in: 'L001={}, x={L001}'
//@   out: 'L001={}, x={L001}'
//@ label 'L000'
//@    in: 'L001={}, x={}'
//@   out: 'L001={}, x={}'
//@ label 'L001'
//@    in: 'L001={}, x={}'
//@   out: 'L001={}, x={L001}'
