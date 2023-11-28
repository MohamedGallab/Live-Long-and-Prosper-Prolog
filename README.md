# Live-Long-and-Prosper-Prolog
This is an implementation of a logic-based agent that uses situation calculus for the "Live Long and Prosper" (LLAP) Situation Calculus project within the Introduction to Artificial Intelligence course.

The primary goal of the agent is to engage in reasoned decision-making regarding actions within a simplified construction environment, ultimately generating plans to construct both a type-1 building and a type-2 building.
## Explanaion
### goal2(S)
```prolog
goal2(S):-
    S = result(b1, _),
    succ_state(S, _, _, _, 1, 1);
    S = result(b2, _),
    succ_state(S, _, _, _, 1, 1).
```
This fluent represents the implementation of a goal and S here is a goal state. this is the entry point and it initializes the problem by calling helper and passing the starting parameters.
This predicate also insures that there are no unnecessary actions being made after performing the last build1 or build2.
The last 2 parameters represent the fact that one of each building types has been built.

### succ_state(S, F, M, E, B1, B2)

The successor state axioms define how the state of the system changes after performing an action. In this project, the successor state axioms are implemented in the helper/6 predicate, which recursively explores the state space.
- S represents the successor state.
- F, M, E represent the resources at the successor state.
- B1, B2 represent whether we have any buildings of type 1 and 2 respectively.

```prolog
succ_state(s0, F, M, E, 0, 0):-
    food(F),
    materials(M),
    energy(E).
```

this is the base case. it matches the current state with the initial state of the world once the conditions are met which means that the current plan is a valid plan to reach a goal state.

- s0 represents the initial state of the world.
- F, M, E represent the resources at the initial state of the world.
- The last 2 parameters indicate that no buildings of type 1 and 2 are present.

```prolog
succ_state(result(b1, S), F, M, E, 1, B2):-
    succ_state(S, F1, M1, E1, 0, B2),
    build1(Fc, Mc, Ec),
    F is F1 - Fc,
    F >= 0,
    M is M1 - Mc,
    M >= 0,
    E is E1 - Ec,
    E >= 0.
```

This is the successor state axiom for the action of build1.
- b1 represents the action build1
- S here represents the current state while result(b1, S) is the successor state. notice that the parameter turns from 0 in the current state to 1 in the successor state indicating a build1 action has been made.
- F1, M1, E1 represent the different resources in the current state
- F, M, E represnt the different resources in the successor state
- Fc, Mc, Ec represnt the different resources needed to perfrom a build1

```prolog
succ_state(result(b2, S), F, M, E, B1, 1):-
    succ_state(S, F1, M1, E1, B1, 0),
    build2(Fc, Mc, Ec),
    F is F1 - Fc,
    F >= 0,
    M is M1 - Mc,
    M >= 0,
    E is E1 - Ec,
    E >= 0.
```

This is the same as the above case but for building 2.

```prolog
succ_state(result(reqf, S), F, M, E, B1, B2):-
    succ_state(S, F1, M, E, B1, B2),
    F is F1 + 1.

succ_state(result(reqm, S), F, M, E, B1, B2):-
    succ_state(S, F, M1, E, B1, B2),
    M is M1 + 1.

succ_state(result(reqe, S), F, M, E, B1, B2):-
    succ_state(S, F, M, E1, B1, B2),
    E is E1 + 1.
```

These 3 cases denote the case where we order one of the 3 resources.

In all the previous predicates:
- S represents the current state while result(X, S) represents the successor state.
- F, M, E represent the resources at the successor state.
- F1, M1, E1 represent the resources in the current state
- B1, B2 represent whether we have any buildings of type 1 and 2 respectively.


## Test Cases
- Query 1: goal(S).
  
  Output: S = result(b1, result(b2, result(reqf, result(reqf, result(reqf, result(reqf, result(reqm, result(reqm, result(reqm, result(reqe, s0))))))))))

  Performance: 4,038,303 inferences, 0.344 CPU in 0.342 seconds (100% CPU, 11747791 Lips)
  
- Query 2: goal(result(b1, result(reqf, result(reqm, result(reqm, result(reqe, result(b2, result(reqf, result(reqf, result(reqf, result(reqm, s0))))))))))).
  
  Output: true
  
  Performance: 378 inferences, 0.000 CPU in 0.000 seconds (0% CPU, Infinite Lips)

- Query 3: goal(result(b1, result(reqf, result(reqm, result(b2, result(reqf, result(reqm, result(reqm, result(reqf, result(reqe, result(reqf, s0))))))))))).
  
  Output: true
  
  Performance: 383 inferences, 0.000 CPU in 0.000 seconds (0% CPU, Infinite Lips)

- Query 4: goal(result(b2, result(reqf, result(reqf, result(reqf, result(reqf, result(reqm, result(reqe, result(b1, result(reqm, result(reqm, s0))))))))))).
  
  Output: true

  Performance: 354 inferences, 0.000 CPU in 0.000 seconds (0% CPU, Infinite Lips)
  
- Query 5: goal(result(b1, result(reqf, s0))).
  
  Output: false
  
  Performance: 81 inferences, 0.000 CPU in 0.000 seconds (0% CPU, Infinite Lips)
