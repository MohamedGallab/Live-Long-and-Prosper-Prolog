:- include('KB.pl').

goal(S):-
    ids(S, 5).

ids(X, L):-
    (call_with_depth_limit(goal2(X),L,R), number(R));
    (call_with_depth_limit(goal2(X),L,R), R=depth_limit_exceeded,
    L1 is L+1, ids(X,L1)).

goal2(S):-
    S = result(b1, _),
    succ_state(S, _, _, _, 1, 1);
    S = result(b2, _),
    succ_state(S, _, _, _, 1, 1).

succ_state(s0, F, M, E, 0, 0):-
    food(F),
    materials(M),
    energy(E).

succ_state(result(b1, S), F, M, E, 1, B2):-
    succ_state(S, F1, M1, E1, 0, B2),
    build1(Fc, Mc, Ec),
    F is F1 - Fc,
    F >= 0,
    M is M1 - Mc,
    M >= 0,
    E is E1 - Ec,
    E >= 0.

succ_state(result(b2, S), F, M, E, B1, 1):-
    succ_state(S, F1, M1, E1, B1, 0),
    build2(Fc, Mc, Ec),
    F is F1 - Fc,
    F >= 0,
    M is M1 - Mc,
    M >= 0,
    E is E1 - Ec,
    E >= 0.

succ_state(result(reqf, S), F, M, E, B1, B2):-
    succ_state(S, F1, M, E, B1, B2),
    F is F1 + 1.

succ_state(result(reqm, S), F, M, E, B1, B2):-
    succ_state(S, F, M1, E, B1, B2),
    M is M1 + 1.

succ_state(result(reqe, S), F, M, E, B1, B2):-
    succ_state(S, F, M, E1, B1, B2),
    E is E1 + 1.