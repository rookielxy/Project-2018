#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,accept,accept1,accept2,accept3,accept4,halt_accept,reject,reject1,reject2,reject3,reject4,reject5,halt_reject}

#S = {1,x,=}

#T = {0,1,x,=,_,T,r,u,e,F,a,l,s}

#q0 = q0

#B = _

#F = {halt_accept}

q0 1 _ r q1
q0 * * * reject

q1 1 1 r q1
q1 x x r q2
q1 * * * reject

q2 1 0 r q3
q2 = = l q8
q2 * * * reject

q3 1 1 r q3
q3 = = r q4
q3 * * * reject

q4 1 1 r q4
q4 _ _ l q5
q4 * * * reject

q5 1 _ l q6
q5 * * * reject

q6 1 1 l q6
q6 = = l q7
q6 * * * reject

q7 1 1 l q7
q7 0 1 r q2
q7 * * * reject

q8 1 1 l q8
q8 x x l q9
q8 * * * reject

q9 1 1 l q9
q9 _ _ r q10
q9 * * * reject

q10 1 _ r q1
q10 x x r q11
q10 * * * reject

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
