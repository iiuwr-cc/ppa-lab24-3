L000: if ! (1 < 0) goto L003;
L001: x = 6;
L002: goto L004;
L003: x = null;
L004: skip;

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
//@ label 'L002'
//@    in: 'x={}'
//@   out: 'x={}'
//@ label 'L003'
//@    in: 'x={}'
//@   out: 'x={}'
//@ label 'L004'
//@    in: 'x={}'
//@   out: 'x={}'
