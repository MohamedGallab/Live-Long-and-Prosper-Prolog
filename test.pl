% Simple Prolog file

% Facts
father(john, jim).
father(john, ann).
mother(jane, jim).
mother(jane, ann).

% Rule: X is a parent of Y if X is a father or mother of Y.
parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).

% Rule: X is a sibling of Y if they have the same parent and are not the same person.
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
