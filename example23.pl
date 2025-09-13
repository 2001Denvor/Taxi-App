% -------- Weighted edges (undirected distances in km) --------
edge(colombo, kandy, 120).
edge(colombo, galle, 116).
edge(kandy, anuradhapura, 138).
edge(galle, matara, 45).
edge(matara, hambantota, 80).
edge(kandy, hambantota, 250).

% Make them bidirectional
connected(A,B,W) :- edge(A,B,W).
connected(A,B,W) :- edge(B,A,W).

% -------- BFS (shortest by number of edges) --------
bfs(Start, Goal, Path) :-
    bfs_queue([[Start]], Goal, Path).

bfs_queue([[Goal|Rest]|_], Goal, Path) :-
    reverse([Goal|Rest], Path).
bfs_queue([[Current|Rest]|Other], Goal, Path) :-
    findall([Next,Current|Rest],
            (connected(Current, Next, _),
             \+ member(Next, [Current|Rest])),
            NewPaths),
    append(Other, NewPaths, Updated),
    bfs_queue(Updated, Goal, Path).

% -------- DFS (depth-first search) --------
dfs(Start, Goal, Path) :-
    dfs_stack([[Start]], Goal, Path).

dfs_stack([[Goal|Rest]|_], Goal, Path) :-
    reverse([Goal|Rest], Path).
dfs_stack([[Current|Rest]|Other], Goal, Path) :-
    findall([Next,Current|Rest],
            (connected(Current, Next, _),
             \+ member(Next, [Current|Rest])),
            NewPaths),
    % push to FRONT to behave like a stack (LIFO)
    append(NewPaths, Other, Updated),
    dfs_stack(Updated, Goal, Path).

% -------- Path cost (sum distances along a path) --------
path_cost([_], 0).
path_cost([A,B|T], Cost) :-
    connected(A,B,W),
    path_cost([B|T], Rest),
    Cost is W + Rest.

% -------- Collect all paths --------
all_bfs_paths(Start, Goal, Paths) :-
    findall(Path, bfs(Start, Goal, Path), Paths).

all_dfs_paths(Start, Goal, Paths) :-
    findall(Path, dfs(Start, Goal, Path), Paths).

% -------- Find shortest path by distance --------
shortest_path(Paths, ShortestPath, MinCost) :-
    map_list_to_pairs(path_cost, Paths, Pairs),   % [(Cost,Path),...]
    keysort(Pairs, [MinCost-ShortestPath|_]).     % take the smallest cost

% -------- Convenience predicates --------
shortest_bfs_path(Start, Goal, Path, Cost) :-
    all_bfs_paths(Start, Goal, Paths),
    shortest_path(Paths, Path, Cost).

shortest_dfs_path(Start, Goal, Path, Cost) :-
    all_dfs_paths(Start, Goal, Paths),
    shortest_path(Paths, Path, Cost).
