% --- Graph definition (edges with cost) ---
edge(a, b, 1).
edge(a, c, 3).
edge(b, d, 3).
edge(b, e, 1).
edge(c, f, 5).
edge(d, g, 2).
edge(e, g, 6).
edge(f, g, 2).

% --- Heuristic values (straight-line estimates to goal g) ---
h(a, 7).
h(b, 6).
h(c, 5).
h(d, 2).
h(e, 3).
h(f, 2).
h(g, 0).

% --- A* Search ---
astar(Start, Goal, Path, Cost) :-
    h(Start, H0),
    astar_search([node(Start, [Start], 0, H0)], Goal, RevPath, Cost),
    reverse(RevPath, Path).

% If we reach the goal, succeed and cut (stop searching further)
astar_search([node(State, Path, G, _)|_], State, Path, G) :- !.

astar_search([node(State, Path, G, _)|Rest], Goal, FinalPath, Cost) :-
    findall(node(Next, [Next|Path], G1, F1),
            ( edge(State, Next, StepCost),
              \+ member(Next, Path),
              G1 is G + StepCost,
              h(Next, H),
              F1 is G1 + H ),
            Children),
    append(Rest, Children, OpenList),
    sort(4, @=<, OpenList, Sorted),   % sort by F value
    astar_search(Sorted, Goal, FinalPath, Cost).




astar(a, g, Path, Cost).
