L000: if ! (1 < 0) goto L003;
L001: x = null;
L002: goto L004;
L003: x = &y;
L004: skip;
L005: *x = &z;

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
//@   out: 'x={}, y={}, z={}'
//@ label 'L003'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L004'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={}, z={}'
//@ label 'L005'
//@    in: 'x={y}, y={}, z={}'
//@   out: 'x={y}, y={z}, z={}'
