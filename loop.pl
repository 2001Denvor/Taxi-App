loop_to(N):-
	loop_from_to(0, N).

loop_from_to(Current, N):-
	Current =< N,
	write('The vlaue is : '), write(Current),nl,
	Next is Current + 1,
	loop_from_to(Next, N).

loop_from_to(Current, N):-
	Current>N.
	
readline:-get0(X), process(X).
process(10).
process(X):-X=\=10, put(X),nl,readline.

loop(0).
loop(N):-N>0, write('The Value is : '), write(N),nl,M is N-1,
	loop(M).


dog(rova).
dog(tarzan).
dog(rex).

alldogs:-dog(X), write(X), write( ' is a dog '),nl,fail.
alldogs.