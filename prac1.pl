% ---edge(A,B,W)--


edge(colombo, kandy, 120).
edge(colombo, galle, 116).
edge(kandy, anuradhapura, 138).
edge(galle, matara, 45).
edge(matara, hambanthota, 80).
edge(kandy, hambanthota, 250).


%make as a bidirectional

connected(A,B,w) :- edge(A, B,W).
connected(A,B,w) :- edge(B, A, W).

%bfs

bfs(Start, Goal, Path) :-
	bfs_queue([[Start]], Goal, Path).

bfs_queue([[Goal][Rest]|_], Goal,Path):-
	reverse([Goal|Rest],Path).

bfs_queue([[Current][Rest]|Other], Goal,Path):-
	finall([Next, Current [Rest],
		(Connected(Current, Next, _),
		\+ member(Next, [Current|Rest])),
		NewPaths),
	append(Other, NewPaths, Updated),
	bfs_queue(Update, Gaol, Path).

%dfs


dfs(Start, Goal, Path) :-
	dfs_queue([[Start]], Goal, Path).

dfs_queue([[Goal][Rest]|_], Goal,Path):-
	reverse([Goal|Rest],path).

dfs_queue([[Current][Rest]|Other], Goal,Path):-
	finall([Next, Current [Rest],
		(Connected(Current, Next, _),
		\+ member(Next, [Current|Rest])),
		NewPaths),
	append(NewPaths, Other, Updated),
	bfs_queue(Update, Gaol, Path).



%path cost

pathcost([_],0).
pathcost([A,B|T], Cost) :-
	connected(A,B,w),
	pathcost([B|T],Rest),
	Cost is w + Rest.

all_bfs_paths(Start, Goal, Paths):-
	finall([Paths, bfs(Start, Goal, Path), Paths).
all_dfs_paths(Start, Goal, Paths):-
	finall(Paths,dfs(Start, Goal, Path), Paths).
shortest_path(Paths, ShortestPath, MinCost):-
	map_all_pairs(pathcost, Paths, Pairs),
	keysort(Pairs, [MinCost-ShortestPath|_].

all_dfs_path_bfs(Start, Goal, Path, Cost):-
	all_bfs_paths(Start, Goal, Paths),
	shortest_path(Paths, Path, Cost).