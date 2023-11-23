:- include('KB.pl').

goal(S):-
    ids(S, 1).

ids(X, L):-
    (call_with_depth_limit(goal2(X),L,R), number(R));
    (call_with_depth_limit(goal2(X),L,R), R=depth_limit_exceeded,
    L1 is L+1, ids(X,L1)).

goal2(S):-
    food(F),
    materials(M),
    energy(E),
    helper(s0, F, M, E, 0, 0, S).

helper(S, _, _, _, 1, 1, S).

helper(S, F, M, E, 0, B2, S1):-
    S2 = result(b1, S),
    build1(Fc, Mc, Ec),
    F1 is F - Fc,
    F1 >= 0,
    M1 is M - Mc,
    M1 >= 0,
    E1 is E - Ec,
    E1 >= 0,
    helper(S2, F1, M1, E1, 1, B2, S1).

helper(S, F, M, E, B1, 0, S1):-
    S2 = result(b2, S),
    build2(Fc, Mc, Ec),
    F1 is F - Fc,
    F1 >= 0,
    M1 is M - Mc,
    M1 >= 0,
    E1 is E - Ec,
    E1 >= 0,
    helper(S2, F1, M1, E1, B1, 1, S1).

helper(S, F, M, E, B1, B2, S1):-
    S2 = result(reqf, S),
    F1 is F + 1,
    helper(S2, F1, M, E, B1, B2, S1).

helper(S, F, M, E, B1, B2, S1):-
    S2 = result(reqm, S),
    M1 is M + 1,
    helper(S2, F, M1, E, B1, B2, S1).

helper(S, F, M, E, B1, B2, S1):-
    S2 = result(reqe, S),
    E1 is E + 1,
    helper(S2, F, M, E1, B1, B2, S1).