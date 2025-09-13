%Facts:Defining parent-child relationships
parent(john, mary).
parent(mary, alice).
parent(alice, sophie).

%Recursive ancestor rule
ancestor(X, Y) :- parent(X, Y). % Base case: A parent is an ancestor
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y). % Recursive case