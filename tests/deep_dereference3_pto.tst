L000: zzz = 1;
L001: yyy = 1;
L002: z = &zz;
L003: zz = &zzz;
L004: y = &yy;
L005: yy = &yyy;
L006: if ! (b == 1) goto L010;
L007: x = &z;
L008: test = ***x;
L009: goto L012;
L010: x = &y;
L011: test = ***x;
L012: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@ label 'Lexit'
//@    in: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L000'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@ label 'L001'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@ label 'L002'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@ label 'L003'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L004'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L005'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L006'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L007'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L008'
//@    in: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L009'
//@    in: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L010'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L011'
//@    in: 'b={}, test={}, x={y}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L012'
//@    in: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
