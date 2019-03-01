% ---------------------------------------------------------------------------- %

% Carlos Roman Rivera - A01700820
% Programming Languages
% Lab 5 - Prolog

% ---------------------------------------------------------------------------- %



% ------------------------------ Any Positive ------------------------------- %
% Checks if all the elements of the list are positive numbers.

% Continue if head is greater than 0. False otherwise.
any_positive([H|T]):-
  H > 0, !;
  any_positive(T).

% ------------------------------- Substitutes -------------------------------- %
% Substitute all occurrences of M in a list.

% Base case. First list is empty.
substitute(_, _, [], []).

% Substitute if M and the head are the same.
substitute(M, N, [M|T], [N|NT]):- !,
  substitute(M, N, T, NT).

% Continue if M and the head are different.
substitute(M, N, [H|T], [H|NT]):-
  substitute(M, N, T, NT).

% -------------------------- Eliminate Duplicates --------------------------- %
% Eliminates all duplicated numbers of a list.

% Base case. First list is empty.
eliminate_duplicates([], []).

% Append to new list if Head is not in Tail.
eliminate_duplicates([H|T], [H|NL]):-
  not(element_in_list(H, T)), !,
  eliminate_duplicates(T, NL).

% Skip element if Head is in Tail.
eliminate_duplicates([_|T], NL):-
  eliminate_duplicates(T, NL).

% -------------------------------- Intersect --------------------------------- %
% Finds the elements that intersect in two lists.

% Base case. First list is empty.
intersect([], _, []).

% Ignore repeated elements from the first list.
intersect([H1|T1], L2, NL):-
  element_in_list(H1, T1), !,
  intersect(T1, L2, NL).

% Append element to new list if the head of the first list is in the second list.
intersect([H1|T1], L2, [H1|NL]):-
  element_in_list(H1, L2), !,
  intersect(T1, L2, NL).

% Ignore element if the head of the first list is not in the second list.
intersect([_|T1], L2, NL):-
  intersect(T1, L2, NL).

% --------------------------------- Invert ---------------------------------- %
% Inverts all the elements of a given list.

% Base case. First list is empty.
invert([], []).

% Iterate to the end of the list. Append on the way back.
invert([H|T], ReversedList):-
  invert(T,NL),
  append_element_list(H, NL, ReversedList).

% -------------------------------- Less Than --------------------------------- %
% Returns all the elements from a list that are smaller than N (given).

% Base case. First list is empty.
less_than(_, [], []).

% Append to new list if the Head is smaller than N.
less_than(N, [H|T], [H|NL]):-
  H < N,
  less_than(N, T, NL).

% Ignore the element if the head of the first list is greater than N.
less_than(N, [_|T], NL):-
  less_than(N, T, NL).

% -------------------------------- More Than --------------------------------- %
% Returns all the elements from a list that are greater than N (given).

% Base case. Fist list is empty.
more_than(_, [], []).

% Append to new list if the Head is bigger or equal than N.
more_than(N, [H|T], [H|NL]):-
  H >= N, !,
  more_than(N, T, NL).

% Ignore the element if the head of the first list is greater than N.
more_than(N, [_|T], NL):-
  more_than(N, T, NL).

% --------------------------------- Rotate ---------------------------------- %
% Rotate elements N (given) times. Positive, rotates left. Negative, right.

% Base case. Finished rotating. Counter is 0.
rotate(List,0,List).

rotate([H1|T1], N, RL):-
  N > 0,
  AUX is N-1,
  append_list_list(T1, [H1], NL),
  rotate(NL, AUX, RL).

rotate(L, N, NL):-
    N < 0,
    AUX is -N,
    rotate(NL, AUX, L).

% ---------------------------------- Path ----------------------------------- %
% Return path between origin and destiny. Bidirectional.

% Knowledge Base
road(genua, placentia).
road(placentia, genua).
road(genua, pisae).
road(pisae, genua).
road(genua, roma).
road(roma, genua).
road(placentia, ariminum).
road(ariminum, placentia).
road(pisae, roma).
road(roma, pisae).
road(ariminum, roma).
road(roma, ariminum).
road(ariminum, ancona).
road(ancona, ariminum).
road(ancona, roma).
road(roma, ancona).
road(ancona, castrum_truentinum).
road(castrum_truentinum, ancona).
road(castrum_truentinum, roma).
road(roma, castrum_truentinum).
road(capua, roma).
road(roma, capua).
road(brundisium, capua).
road(capua, brundisium).
road(rhegium ,capua).
road(capua, rhegium).
road(messana, rhegium).
road(rhegium, messana).
road(lilibeum, messana).
road(messana, lilibeum).
road(catina, messana).
road(messana, catina).
road(syracusae, catina).
road(catina, syracusae).

% Transformation function. Add list that will contain path.
path(Origin, Destiny, Path):-
  route(Origin, Destiny, [Origin], Path).

% Base Case. You have a road between origin and destiny.
route(Origin, Destiny, Route, Route):-
  road(Origin, Destiny).

% Recursive call using aux variable to represent the stop/city crossed.
route(Origin, Destiny, Route, Path):-
  road(Origin, AUX_R),
  not(element_in_list(AUX_R, Route)),
  append_element_list(AUX_R, Route, AUX_L),
  route(AUX_R, Destiny, AUX_L, Path).

% --------------------------------- Helpers ---------------------------------- %
% Auxiliary functions to avoid implementing them for each exercise.

% Returns if an element is in a list.
element_in_list(N, [N|_]):- !.
element_in_list(N, [_|T]):-
  element_in_list(N, T).

% Append an element at the end of a list.
append_element_list(X, [], [X]).
append_element_list(X, [H|T], [H|NL]):-
  append_element_list(X, T, NL).

% Append list at the end of the list.
append_list_list([], List, List).
append_list_list([H1|T1], M, [H1|NL]):-
  append_list_list(T1, M, NL).
