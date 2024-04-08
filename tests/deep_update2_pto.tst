L000: z = &zz;
L001: zz = &zzz;
L002: y = &zz;
L003: if ! (b == 1) goto L006;
L004: x = &z;
L005: goto L007;
L006: x = &y;
L007: skip;
L008: ***x = &test;
L009: **x = &test;
L010: *x = &test;
L011: x = &test;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'b={}, test={}, x={}, y={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, z={}, zz={}, zzz={}'
//@ label 'Lexit'
//@    in: 'b={}, test={}, x={test}, y={test, zz}, z={test, zz}, zz={test}, zzz={test}'
//@   out: 'b={}, test={}, x={test}, y={test, zz}, z={test, zz}, zz={test}, zzz={test}'
//@ label 'L000'
//@    in: 'b={}, test={}, x={}, y={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, z={zz}, zz={}, zzz={}'
//@ label 'L001'
//@    in: 'b={}, test={}, x={}, y={}, z={zz}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L002'
//@    in: 'b={}, test={}, x={}, y={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L003'
//@    in: 'b={}, test={}, x={}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L004'
//@    in: 'b={}, test={}, x={}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L005'
//@    in: 'b={}, test={}, x={z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L006'
//@    in: 'b={}, test={}, x={}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L007'
//@    in: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L008'
//@    in: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={zzz}, zzz={test}'
//@ label 'L009'
//@    in: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={zzz}, zzz={test}'
//@   out: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={test}, zzz={test}'
//@ label 'L010'
//@    in: 'b={}, test={}, x={y, z}, y={zz}, z={zz}, zz={test}, zzz={test}'
//@   out: 'b={}, test={}, x={y, z}, y={test, zz}, z={test, zz}, zz={test}, zzz={test}'
//@ label 'L011'
//@    in: 'b={}, test={}, x={y, z}, y={test, zz}, z={test, zz}, zz={test}, zzz={test}'
//@   out: 'b={}, test={}, x={test}, y={test, zz}, z={test, zz}, zz={test}, zzz={test}'
