; the finite set of states
#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,accept,accept1,accept2,accept3,accept4,halt_accept,reject,reject1,reject2,reject3,reject4,reject5,halt_reject}

; the finite set of input symbols
#S = {a,b}

; the complete set of tape symbols
#T = {a,b,0,1,_,T,r,u,e,F,a,l,s}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {halt_accept}

; the transition functions

; State 0 : mark the leftmost symbol, accept if input is empty
q0 a 0 r q1
q0 b 1 r q1
q0 _ _ r accept
q0 * * * reject

; State 1, 2 : check whether the length of input is even or not
q1 a a r q2
q1 b b r q2
q1 * * * reject

q2 a a r q1
q2 b b r q1
q2 _ _ l q3
q2 * * * reject

; State 3 : mark the rightmost symbol
q3 a 0 l q4
q3 b 1 l q4
q3 * * * reject

; State 4, 5 : find the left marked symbol and move it right by one cell
q4 a a l q4
q4 b b l q4
q4 0 a r q5
q4 1 b r q5
q4 * * * reject

q5 a 0 r q6
q5 b 1 r q6
q5 0 0 l q8 ; check if two marked symbol meet
q5 1 1 l q8 ; find the middle point if two marked symbol meet 
q5 * * * reject

; State 6, 7 : find the right marked symbol and move it left by one cell
q6 a a r q6
q6 b b r q6
q6 0 a l q7
q6 1 b l q7
q6 * * * reject

q7 a 0 l q4
q7 b 1 l q4
q7 * * * reject

; State 8 : find the leftmost symbol
q8 a a l q8
q8 b b l q8
q8 _ _ r q9
q8 * * * reject

; State 9 : mark the leftmost symbol and enter
;		  : 10 if marked a
;		  : 11 if marked b
q9 a 0 r q10
q9 b 1 r q11
q9 * * * reject

; State 10, 11 : find the right marked symbol
;			   : and check if same as left marked symbol
q10 a a r q10
q10 b b r q10
q10 0 a r q12
q10 * * * reject

q11 a a r q11
q11 b b r q11
q11 1 b r q12
q11 * * * reject

; State 12 : move the right marked symbol by one cell
;		   : accept if reach end of input
q12 a 0 l q13
q12 b 1 l q13
q12 _ _ * accept
q12 * * * reject

; State 13, 14 : find the left marked symbol and move it left by one cell
q13 a a l q13
q13 b b l q13
q13 0 a r q14
q13 1 b r q14
q13 * * * reject

q14 a 0 r q10
q14 b 1 r q11
q14 * * * reject

accept * * r accept
accept _ _ l accept1
accept1 * _ l accept1
accept1 _ T r accept2
accept2 _ r r accept3
accept3 _ u r accept4
accept4 _ e * halt_accept 

reject * * r reject
reject _ _ l reject1
reject1 * _ l reject1
reject1 _ F r reject2
reject2 _ a r reject3
reject3 _ l r reject4
reject4 _ s r reject5
reject5 _ e * halt_reject


