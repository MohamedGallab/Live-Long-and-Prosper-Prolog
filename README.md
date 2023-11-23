# Live-Long-and-Prosper-Prolog



## goal2(S)
```prolog
goal2(S):-
    food(F),
    materials(M),
    energy(E),
    helper(s0, F, M, E, 0, 0, S).
```
This fluent represents the implementation of a goal. this is the entry point and it initializes the problem by calling helper and passing the starting parameters. where S represents the goal state.
s0 is the initial state and all the other parameters are matched with the knowledge base. The 2 zeros represent the number of build1 and build2 operations that are performed respectively.

## helper(S, F, M, E, B1, B2, S1)

The successor state axioms define how the state of the system changes after performing an action. In this project, the successor state axioms are implemented in the helper/7 predicate, which recursively explores the state space.
- S represents the current state.
- S1 represents the final output.
- F, M, E represent the resources at the current state.
- B1, B2 represent whether we have any builds 1 or 2.

`helper(S, _, _, _, 1, 1, S).` 

this is the base case. it matches the output with the current state once the conditions are met which means one of each buildings were built.

```prolog
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
```

This denotes the state that there was no building 1 and then the successor state is performing the build1 action given that the conditions are met.

```prolog
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
```

This is the same as the above case but for building 2.


```prolog
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
```

These 3 cases denote the case where we order one of the 3 resources.

In all the previous predicates:
- S represents the current state.
- S1 represents the final output.
- F, M, E represent the resources at the current state.
- B1, B2 represent whether we have any builds 1 or 2.
- S2 represents an intermediate step of applying the effect axiom of the successor state.
