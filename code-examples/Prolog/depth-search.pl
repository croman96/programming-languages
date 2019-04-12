member(X,[X|_]).

member(X,[_|T]):- member(X,T).

empty_stack([]).

member_stack(E,S):- member(E,S).

stack(E,S,[E|S]).

go(Start,Goal,R):-
  empty_stack(Empty_been_list),
  stack(Start,Empty_been_list,Been_list),
  path(Start,Goal,Been_list,R).

path(Goal,Goal,R,R).

path(State,Goal,Been_list,R):-
  mov(State,Next),
  not(member_stack(Next,Been_list)),
  stack(Next,Been_list,New_been_list),
  path(Next,Goal,New_been_list,R),
  !.
