L000: z = &zz;
L001: zz = &zzz;
L002: y = &yy;
L003: yy = &yyy;
L004: if ! (b == 1) goto L007;
L005: x = &z;
L006: goto L008;
L007: x = &y;
L008: skip;
L009: **x = malloc;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@ label 'Lexit'
//@    in: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy, L009}, yyy={}, z={zz}, zz={zzz, L009}, zzz={}'
//@   out: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy, L009}, yyy={}, z={zz}, zz={zzz, L009}, zzz={}'
//@ label 'L000'
//@    in: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={}, zz={}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@ label 'L001'
//@    in: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L002'
//@    in: 'L009={}, b={}, x={}, y={}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L003'
//@    in: 'L009={}, b={}, x={}, y={yy}, yy={}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L004'
//@    in: 'L009={}, b={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L005'
//@    in: 'L009={}, b={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L006'
//@    in: 'L009={}, b={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L007'
//@    in: 'L009={}, b={}, x={}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={y}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L008'
//@    in: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@ label 'L009'
//@    in: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy}, yyy={}, z={zz}, zz={zzz}, zzz={}'
//@   out: 'L009={}, b={}, x={y, z}, y={yy}, yy={yyy, L009}, yyy={}, z={zz}, zz={zzz, L009}, zzz={}'
