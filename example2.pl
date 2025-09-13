parent(john, mary).
parent(john, alice).
parent(jane, mary).
parent(jane, alice).
parent(paul, sophie).
parent(linda, sophie).


sibling(X, Y) :- parent(Z, Y), X\=Y.