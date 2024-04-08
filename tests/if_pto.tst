L000: x = 1;
L001: y = 2;
L002: if ! (x < y) goto L006;
L003: y = 3;
L004: x = 2;
L005: goto L008;
L006: y = x + y;
L007: x = 3;
L008: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'Lexit'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L000'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L001'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L002'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L003'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L004'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L005'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L006'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L007'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L008'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
