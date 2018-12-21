#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,accept,accept1,accept2,accept3,accept4,halt_accept,reject,reject1,reject2,reject3,reject4,reject5,halt_reject}

#S = {a,b}

#T = {a,b,0,1,_,T,r,u,e,F,a,l,s}

#q0 = q0

#B = _

#F = {halt_accept}

q0 a 0 r q1
q0 b 1 r q1
q0 _ _ r accept
q0 * * * reject

q1 a a r q2
q1 b b r q2
q1 * * * reject

q2 a a r q1
q2 b b r q1
q2 _ _ l q3
q2 * * * reject

q3 a 0 l q4
q3 b 1 l q4
q3 * * * reject

q4 a a l q4
q4 b b l q4
q4 0 a r q5
q4 1 b r q5
q4 * * * reject

q5 a 0 r q6
q5 b 1 r q6
q5 0 0 l q8
q5 1 1 l q8
q5 * * * reject

q6 a a r q6
q6 b b r q6
q6 0 a l q7
q6 1 b l q7
q6 * * * reject

q7 a 0 l q4
q7 b 1 l q4
q7 * * * reject

q8 a a l q8
q8 b b l q8
q8 _ _ r q9
q8 * * * reject

q9 a 0 r q10
q9 b 1 r q11
q9 * * * reject

q10 a a r q10
q10 b b r q10
q10 0 a r q12
q10 * * * reject

q11 a a r q11
q11 b b r q11
q11 1 b r q12
q11 * * * reject

q12 a 0 l q13
q12 b 1 l q13
q12 _ _ * accept
q12 * * * reject

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


