L000: i = 0;
L001: end = 0;
L002: xs = &end;
L003: if ! (i < n) goto L011;
L004: head = malloc;
L005: *head = xs;
L006: xs = head;
L007: i = i + 1;
L008: y = &head;
L009: **y = &i;
L010: goto L003;
L011: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@ label 'Lexit'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@ label 'L000'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@ label 'L001'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@ label 'L002'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}, y={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={end}, y={}'
//@ label 'L003'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@ label 'L004'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@ label 'L005'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@ label 'L006'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@ label 'L007'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@ label 'L008'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@ label 'L009'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@ label 'L010'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={L004}, y={head}'
//@ label 'L011'
//@    in: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
//@   out: 'L004={end, i, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}, y={head}'
