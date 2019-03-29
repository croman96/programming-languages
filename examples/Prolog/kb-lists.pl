member(Item,[Item|Tail]).

member(Item,[Head|Tail]):- member(Item,Tail).

% member(sydney_opera_house, [london_buckingham_palace,paris_eiffel_tower,york_minster,pisa_leaning_tower,athens_parthenon]).

% member(paris_eiffel_tower, [london_buckingham_palace,paris_eiffel_tower,york_minster,pisa_leaning_tower,athens_parthenon]).

build([],[]).

build([X|T],[X|Result]):-
  X > 6,
  build(T,Result).

build([Dump|T],Result):-
  build(T,Result).

% build([4,7,2,8],Result).

% build([12,2,52,28],Result).

delete_all([],X,Result).

delete_all([H|T],X,Result):-
  H = X,
  delete_all(T,X,Result).

delete_all([H|T],X,[H|Result]):-
  delete_all(T,X,Result).

% delete_all([a,b,a,c,a,d],a,Result).
% Result = [b,c,d]

% delete_all([a,b,a,c,a,d],b,Result).
% Result = [a,a,c,a,d]

% delete_all([a,b,a,c,a,d],prolog,Result).
% Result = [a,b,a,c,a,d]
