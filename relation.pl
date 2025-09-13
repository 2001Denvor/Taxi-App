check_relations :-
	A is 88 + 15 -3,
	B is 110 - 5 * 2,
	write('Expression 1: 88 + 15 -3 = '),write(A),nl,
	write('Expression 2: 110 - 5 * 2 = '),write(B),nl,

(A =:=B ->write('A =:=B -> true'),nl ; write('A=:=B -> false'),nl),
(A > B ->write('A > B -> true'),nl ; write('A>B -> false'),nl),
(A >=B ->write('A>=-> true'),nl ; write('A>=B -> false'),nl),
(A <B ->write('A <B -> true'),nl ; write('A<B -> false'),nl),
(A =< B ->write('A =<B -> true'),nl ; write('A=<B -> false'),nl),
(100 =\=99 -> write('100=\=99 -> true'),nl ; write('100 =\=99 -> false'),nl).