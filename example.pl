parent(john, mary).
parent(mary, alice).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

go:-write('Hello world'),nl,
    writeq('hello world').

bird(sparrow). 
bird(eagle).
bird(duck).
bird(crow).
bird(ostrich).
bird(puffin).
bird(swan).
bird(albastrot).
bird(starlling).
bird(owl).
bird(kingfisher).
bird(trush).


can_fly(owl):- !, fail.
can_fly(X):-bird(X).

writeall([]).
writeall([A|L]):- write(A), nl, writeall(L).

remove_spaces(S,S1):-
	splits(S, ' ', Sleft, Sright),
	remove2(S, Sleft, Sright,S1),!.
remove2(S, ' ', Sright, S1):-remove_spaces(Sright, S1).
remove2(S,_,_,S).



    