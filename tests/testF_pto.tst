L000: if ! (1 < 0) goto L004;
L001: x = null;
L002: *x = 1;
L003: goto L005;
L004: x = &y;
L005: skip;
L006: *x = &z;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'Lexit'
//@    in: 'x={y}, y={z}, z={}'
//@   out: 'x={y}, y={z}, z={}'
//@ label 'L000'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'L001'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'L002'
//@    in: 'x={}, y={}, z={}'
//@   out: 'BOT'
//@ label 'L003'
//@    in: 'BOT'
//@   out: 'BOT'
//@ label 'L004'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L005'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L006'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={z}, z={}'
