; This example program checks if the input string is a binary palindrome.
; Input: a string of 0's and 1's, eg '1001001'

; finite state set
#Q={0,1o,1i,2o,2i,3,4,accept,accept2,accept3,accept4,halt-accept,reject,reject2,reject3,reject4,reject5,halt-reject}

; input symbol set
#S={0,1}

; tape symbol set
#T={0,1,_,T,r,u,e,F,a,l,s}

; initial state
#q0=0

; blank symbol
#B=_

; final state set
#F={halt-accept,halt-reject}

; State 0: read the leftmost symbol
0 0 _ r 1o
0 1 _ r 1i
0 _ _ * accept     ; Empty input

; State 1o, 1i: find the rightmost symbol
1o _ _ l 2o
1o * * r 1o

1i _ _ l 2i
1i * * r 1i

; State 2o, 2i: check if the rightmost symbol matches the most recently read left-hand symbol
2o 0 _ l 3
2o _ _ * accept
2o * * * reject

2i 1 _ l 3
2i _ _ * accept
2i * * * reject

; State 3, 4: return to left end of remaining input
3 _ _ * accept
3 * * l 4
4 * * l 4
4 _ _ r 0  ; Back to the beginning

accept * T r accept2
accept2 * r r accept3
accept3 * u r accept4
accept4 * e * halt-accept

reject * _ l reject
reject _ F r reject2
reject2 _ a r reject3
reject3 _ l r reject4
reject4 _ s r reject5
reject5 * e * halt-reject