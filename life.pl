% Define custom operators
:- op(150, xfy, likes).
:- op(150, xfy, owns).
:- op(150, fx, is_female).
:- op(150, xf, isa_cat).

%Female persons
is_female(sara).
is_female(amy).
is_female(jessi).

%Ownership facts
sara owns kitty.
amy owns sparky.
jessi owns mickey.

%Pet types
kitty isa_cat.
sparky isa_cat.
mickey isa_cat.

%Age facts
age(john, 30).
age(sara, 25).
age(amy, 32).
age(jessi, 27).


%Rule: John likes someone if she is female, owns a cat, and is younger than him
john likes X :- is_female(X), X owns Pet, Pet isa_cat, age(john, A1), age(X, A2), A2<A1.