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
//@analysis cp_mem_pto
//@language while_mem
//@ label 'Lentry'
//@    in: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'Lexit'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L000'
//@    in: 'end=⊤ head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=⊤ head=⊤ i=0 n=⊤ xs=⊤ y=⊤'
//@ label 'L001'
//@    in: 'end=⊤ head=⊤ i=0 n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=0 n=⊤ xs=⊤ y=⊤'
//@ label 'L002'
//@    in: 'end=0 head=⊤ i=0 n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=0 n=⊤ xs=&amp;end y=⊤'
//@ label 'L003'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L004'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L005'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L006'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L007'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@ label 'L008'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=&amp;head'
//@ label 'L009'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=&amp;head'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=&amp;head'
//@ label 'L010'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=&amp;head'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=&amp;head'
//@ label 'L011'
//@    in: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
//@   out: 'end=0 head=⊤ i=⊤ n=⊤ xs=⊤ y=⊤'
