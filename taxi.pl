% -------- Weighted edges (From, To, undirected distances in km) --------
%----western Provice-----

edge(colombo, gampaha, 31).
edge(colombo, kalutara, 44).
edge(gampaha, kurunegala, 50).
edge(colombo, kandy, 117).
edge(colombo, matara, 160).
edge(colombo, negambo, 37).
edge(colombo, panadura, 26).
edge(colombo, ratnapura, 102).
edge(colombo, sri_jayawardenepura_kotte, 10).
edge(colombo, trincomalee, 257).
edge(colombo, wattala, 10).
edge(colombo, ja_ela, 21).
edge(colombo, homagama, 24).
edge(colombo, beruwala, 54).
edge(colombo, aluthgama, 60).
edge(colombo, kalpitiyaa, 130).
edge(colombo, galle, 126).

% Central Province


edge(kandy, matale, 20).
edge(kandy, badulla, 150).
edge(kandy, hatton, 75).
edge(kandy, ella, 150).
edge(kandy, dambulla, 72).
edge(kandy, anuradhapura, 138).
edge(kandy, kurunegala, 94).
edge(kandy, nuwara_eliya, 75).
edge(matale, dambulla, 47).
edge(dambulla, polonnaruwa, 67).

% Southern Province

edge(matara, tangalle, 120).
edge(matara, weligama, 35).
edge(matara, ambalangoda, 60).
edge(matara, aluthgama, 80).
edge(matara, kalutara, 100).
edge(galle, matara, 45).
edge(matara, hambantota, 80).


% North Central Provice

edge(kurunegala, anuradhapura, 100).
edge(anuradhapura, dambulla, 72).
edge(anuradhapura, kandy, 138).
edge(anuradhapura, colombo, 205).
edge(anuradhapura, sigiriya, 50).
edge(mihintale, anuradhapura, 25).
edge(trincomalee, mihinatale, 30).
edge(anuradhapura, vavuniya, 60).
edge(anuradhapura, trincomalee, 105).
edge(anuradhapura, polonnaruwa, 100).

% North Western Province

edge(kurunegala, chilaw, 60).
edge(kurunegala, puttalam, 90).
edge(kurunegala, anuradhapura, 105).
edge(kurunegala, dambulla, 75).
edge(kurunegala, colombo, 94).


% Northern Provice

edge(vavuniya, jaffna, 130).
edge(vavuniya, mullaitivu, 65).
edge(jaffna, colombo, 400).
edge(jaffna, trincomalee, 280).
edge(mannar, jaffna, 140).
edge(mannar, mullaitivu, 220).
edge(mannar, colombo, 330).
edge(mannar, kurunegala, 180).
edge(mannar, anuradhapura, 150).
edge(vavuniya, kilinochchi,90).
edge(mannar, vavuniya, 70).

% Eastern Province 

edge(trincomalee, batticaloa, 140).
edge(trincomalee, ampara, 130).
edge(trincomalee, polonnaruwa, 120).
edge(trincomalee, kandy, 160).
edge(trincomalee, colombo, 257).
edge(batticaloa, ampara, 65).
edge(ampara, monaragala, 70).

% Uva & Sabaragamuwa

edge(badulla, monaragala, 65).
edge(badulla, kandy, 150).
edge(badulla, colombo, 230).
edge(badulla, monaragala, 70).
edge(badulla, ampara, 150).
edge(badulla, ratnapura, 120).
edge(ratnapura, colombo, 100).
edge(ratnapura, balangoda, 40).
edge(ratnapura, ella, 150).
edge(ratnapura, ambalangoda, 90).
edge(kegalle, colombo, 65).

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


% Heuristic values (perfect shortest path distances from colombo).

h(colombo, batticaloa, 350).
h(gampaha, batticaloa, 330).
h(kalutara, batticaloa, 380).
h(kandy, batticaloa, 200).
h(matale, batticaloa, 180).
h(dambulla, batticaloa, 140).
h(anuradhapura, batticaloa, 120).
h(trincomalee, batticaloa, 80).
h(ampara, batticaloa, 50).
h(batticaloa, batticaloa, 0).
h(matara, batticaloa, 220).
h(weligama, batticaloa, 230).
h(tangalle, batticaloa, 260).
h(ambalangoda, batticaloa, 240).
h(aluthgama, batticaloa, 380).
h(galle, batticaloa, 250).
h(ratnapura, batticaloa, 300).
h(balangoda, batticaloa, 280).
h(kegalle, batticaloa, 310).
h(badulla, batticaloa, 100).
h(monaragala, batticaloa, 70).
h(hatton, batticaloa, 180).
h(nuwara_eliya, batticaloa, 190).
h(ella, batticaloa, 140). 
h(sigiriya, batticaloa, 100).
h(mihintale, batticaloa, 110).
h(puttalam, batticaloa, 400).
h(chilaw, batticaloa, 380).
h(vavuniya, batticaloa, 160).
h(jaffna, batticaloa, 300).
h(mullaitivu, batticaloa, 220).
h(mannar, batticaloa, 200).
h(polonnaruwa, batticaloa, 60).
h(hambantota, batticaloa, 140).
h(ja_ela, batticaloa, 340).
h(sri_jayawardenepura_kotte, batticaloa, 345).
h(wattala, batticaloa, 345).
h(beruwala, batticaloa, 380).
h(aluthgama, batticaloa, 380).
h(kalpitiya, batticaloa, 430).
h(negambo, batticaloa, 360).
h(panadura, batticaloa, 370).
h(matara, batticaloa, 220).
h(tangalle, batticaloa, 260).


% --- A* Search ---


astar(Start, Goal, Path, Cost) :-
    h(Start, Goal, H0),
    astar_search([node(Start, [Start], 0, H0)], Goal, RevPath, Cost),
    reverse(RevPath, Path).

% If we reach the goal, succeed and cut (stop searching further)

astar_search([node(State, Path, G, _)|_], State, Path, G) :- !.

astar_search([node(State, Path, G, _)|Rest], Goal, FinalPath, Cost) :-
    findall(node(Next, [Next|Path], G1, F1),
            ( edge(State, Next, StepCost),
              \+ member(Next, Path),
              G1 is G + StepCost,
              h(Next, Goal, H),
              F1 is G1 + H ),
            Children),
    append(Rest, Children, OpenList),
    sort(4, @=<, OpenList, Sorted),   % sort by F value
    astar_search(Sorted, Goal, FinalPath, Cost).

% Optional test predicate(safe, no singleton warning)

astar_test:-
astar(Start, batticaloa, Path, Cost),
write('Path: '), writeln(Path),
write('Cost: '), writeln(Cost).






