L000: i = 0;
L001: end = 0;
L002: xs = &end;
L003: if ! (i < n) goto L009;
L004: head = malloc;
L005: *head = xs;
L006: xs = head;
L007: i = i + 1;
L008: goto L003;
L009: skip;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@ label 'Lexit'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@ label 'L000'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@ label 'L001'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@ label 'L002'
//@    in: 'L004={}, end={}, head={}, i={}, n={}, xs={}'
//@   out: 'L004={}, end={}, head={}, i={}, n={}, xs={end}'
//@ label 'L003'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@ label 'L004'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@ label 'L005'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@ label 'L006'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={L004}'
//@ label 'L007'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={L004}'
//@ label 'L008'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={L004}'
//@ label 'L009'
//@    in: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
//@   out: 'L004={end, L004}, end={}, head={L004}, i={}, n={}, xs={end, L004}'
