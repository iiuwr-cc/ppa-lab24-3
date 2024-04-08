L000: x = 25;
L001: y = 100;
L002: z = malloc;
L003: *z = &x;
L004: *z = &y;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L002={}, x={}, y={}, z={}'
//@   out: 'L002={}, x={}, y={}, z={}'
//@ label 'Lexit'
//@    in: 'L002={x, y}, x={}, y={}, z={L002}'
//@   out: 'L002={x, y}, x={}, y={}, z={L002}'
//@ label 'L000'
//@    in: 'L002={}, x={}, y={}, z={}'
//@   out: 'L002={}, x={}, y={}, z={}'
//@ label 'L001'
//@    in: 'L002={}, x={}, y={}, z={}'
//@   out: 'L002={}, x={}, y={}, z={}'
//@ label 'L002'
//@    in: 'L002={}, x={}, y={}, z={}'
//@   out: 'L002={}, x={}, y={}, z={L002}'
//@ label 'L003'
//@    in: 'L002={}, x={}, y={}, z={L002}'
//@   out: 'L002={x}, x={}, y={}, z={L002}'
//@ label 'L004'
//@    in: 'L002={x}, x={}, y={}, z={L002}'
//@   out: 'L002={x, y}, x={}, y={}, z={L002}'
