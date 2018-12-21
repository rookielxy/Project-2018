; the finite set of states
#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,accept,accept1,accept2,accept3,accept4,halt_accept,reject,reject1,reject2,reject3,reject4,reject5,halt_reject}

; the finite set of input symbols
#S = {1,x,=}

; the complete set of tape symbols
#T = {0,1,x,=,_,T,r,u,e,F,a,l,s}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {halt_accept}

; the transition functions

; State 0 : change the leftmost symbol to blank
q0 1 _ r q1
q0 * * * reject

; State 1 : find the first 1 after x
q1 1 1 r q1
q1 x x r q2
q1 * * * reject

; State 2 : change the 1 to 0 as a mark
q2 1 0 r q3
q2 = = l q8 ; if all 1 between x and = have been read
q2 * * * reject

; State 3, 4 : find the rightmost of input, 
;			   split into two states to check whether there is only = or not
q3 1 1 r q3
q3 = = r q4
q3 * * * reject

q4 1 1 r q4
q4 _ _ l q5
q4 * * * reject

; State 5 : remove rightmost 1
q5 1 _ l q6
q5 * * * reject

; State 6, 7 : return to the marked 1 between x and =
q6 1 1 l q6
q6 = = l q7
q6 * * * reject

q7 1 1 l q7
q7 0 1 r q2
q7 * * * reject

; State 8, 9 : return to the rightmost symbol in input
q8 1 1 l q8
q8 x x l q9
q8 * * * reject

q9 1 1 l q9
q9 _ _ r q10
q9 * * * reject

; State 10 : check if there is remaining 1 before x
q10 1 _ r q1 ; remove the leftmost 1 and loop
q10 x x r q11 ; no remaining 1 and check 
q10 * * * reject

; State 11, 12 : find the rightmost symbol and check if 1's after = have been removeed completely
q11 1 1 r q11
q11 = = r q12
q11 * * * reject

q12 _ _ l accept
q12 * * * reject

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
