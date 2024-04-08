L000: xs = null;
L001: i = 50;
L002: if ! (i > 0) goto L008;
L003: head = malloc;
L004: *head = xs;
L005: xs = head;
L006: i = i - 1;
L007: goto L002;
L008: skip;
L009: p = malloc;
L010: *p = r;
L011: q = &p;
L012: *q = null;
L013: xs = *p;
L014: *p = head;

//@PRACOWNIA
//@analysis pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@   out: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@ label 'Lexit'
//@    in: 'BOT'
//@   out: 'BOT'
//@ label 'L000'
//@    in: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@   out: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@ label 'L001'
//@    in: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@   out: 'L003={}, L009={}, head={}, i={}, p={}, q={}, r={}, xs={}'
//@ label 'L002'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L003'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L004'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L005'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L006'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L007'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L008'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@ label 'L009'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={}, r={}, xs={L003}'
//@ label 'L010'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={}, r={}, xs={L003}'
//@ label 'L011'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={p}, r={}, xs={L003}'
//@ label 'L012'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={L009}, q={p}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={p}, r={}, xs={L003}'
//@ label 'L013'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={p}, r={}, xs={L003}'
//@   out: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={p}, r={}, xs=bot'
//@ label 'L014'
//@    in: 'L003={L003}, L009={}, head={L003}, i={}, p={}, q={p}, r={}, xs=bot'
//@   out: 'BOT'
