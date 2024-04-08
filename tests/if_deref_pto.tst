L000: x = 1;
L001: y = 2;
L002: if ! (x < y) goto L006;
L003: z = &x;
L004: *z = 2;
L005: goto L008;
L006: z = &y;
L007: *z = 3;
L008: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={}'
//@ label 'Lexit'
//@    in: 'x={}, y={}, z={x, y}'
//@   out: 'x={}, y={}, z={x, y}'
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
//@   out: 'x={}, y={}, z={x}'
//@ label 'L004'
//@    in: 'x={}, y={}, z={x}'
//@   out: 'x={}, y={}, z={x}'
//@ label 'L005'
//@    in: 'x={}, y={}, z={x}'
//@   out: 'x={}, y={}, z={x}'
//@ label 'L006'
//@    in: 'x={}, y={}, z={}'
//@   out: 'x={}, y={}, z={y}'
//@ label 'L007'
//@    in: 'x={}, y={}, z={y}'
//@   out: 'x={}, y={}, z={y}'
//@ label 'L008'
//@    in: 'x={}, y={}, z={x, y}'
//@   out: 'x={}, y={}, z={x, y}'
