L000: z = &zz;
L001: zz = &zzz;
L002: y = &yy;
L003: yy = &yyy;
L004: if ! (b == 1) goto L007;
L005: x = &z;
L006: goto L008;
L007: x = &y;
L008: skip;
L009: test = **x;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@ label 'Lexit'
//@    in: 'b={}, test={yyy, zzz}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={yyy, zzz}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L000'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@ label 'L001'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L002'
//@    in: 'b={}, test={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L003'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L004'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L005'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L006'
//@    in: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L007'
//@    in: 'b={}, test={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L008'
//@    in: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L009'
//@    in: 'b={}, test={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'b={}, test={yyy, zzz}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
