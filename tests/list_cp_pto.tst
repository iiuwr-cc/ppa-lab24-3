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
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'Lexit'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L000'
//@    in: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=⊤ head=⊤ i=0 n=⊤ xs=⊤'
//@ label 'L001'
//@    in: 'end=⊤ head=⊤ i=0 n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=0 n=⊤ xs=⊤'
//@ label 'L002'
//@    in: 'end=0 head=⊤ i=0 n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=0 n=⊤ xs=&amp;end'
//@ label 'L003'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L004'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L005'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L006'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L007'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L008'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@ label 'L009'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤'
