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
//@analysis cp_mem_andersen
//@language while_mem
//@ label 'Lentry'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'Lexit'
//@    in: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊥'
//@   out: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊥'
//@ label 'L000'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=N'
//@ label 'L001'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=N'
//@   out: 'head=⊤ i=50 p=⊤ q=⊤ r=⊤ xs=N'
//@ label 'L002'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L003'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L004'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L005'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L006'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L007'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L008'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L009'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L010'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@ label 'L011'
//@    in: 'head=⊤ i=⊤ p=⊤ q=⊤ r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=⊤ q=&amp;p r=⊤ xs=⊤'
//@ label 'L012'
//@    in: 'head=⊤ i=⊤ p=⊤ q=&amp;p r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊤'
//@ label 'L013'
//@    in: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊤'
//@   out: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊥'
//@ label 'L014'
//@    in: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊥'
//@   out: 'head=⊤ i=⊤ p=N q=&amp;p r=⊤ xs=⊥'
