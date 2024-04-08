L000: y = 1;
L001: if ! (1 < 0) goto L005;
L002: x = &y;
L003: y = *x;
L004: goto L007;
L005: x = null;
L006: y = *x;
L007: skip;

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
//@   out: 'x={}, y={}'
//@ label 'L001'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L002'
//@    in: 'x={}, y={}'
//@   out: 'x={y}, y={}'
//@ label 'L003'
//@    in: 'x={y}, y={}'
//@   out: 'x={y}, y={}'
//@ label 'L004'
//@    in: 'x={y}, y={}'
//@   out: 'x={y}, y={}'
//@ label 'L005'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y={}'
//@ label 'L006'
//@    in: 'x={}, y={}'
//@   out: 'x={}, y=bot'
//@ label 'L007'
//@    in: 'x={y}, y={}'
//@   out: 'x={y}, y={}'
