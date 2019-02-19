% ---------------------------------------------------------------------------- %

% Carlos Roman Rivera - A01700820
% Programming Languages
% Lab 4 - Prolog

% ---------------------------------------------------------------------------- %

% Exercise 1

/* Define a predicate “compatible(X,Y)”. We say that X and Y are compatible if
% they share at least 1 hobby. */

hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

compatible(X,Y):-
	hobby(X,Z),
	hobby(Y,Z),
	dif(X,Y).

% compatible(juan,Y).
% Y = simon.

% ---------------------------------------------------------------------------- %

% Exercise 2

/* Generate a KB of the paths that lead to Rome.
Every road is a one way road and the all lead to the capital, because
“all roads lead to Rome”. The directions in your predicates should be from
left (start) to right (end).

Define the rule can_get_to(Origin, Destination) which is true if there is a
path that starts in Origin and following the directionality of the roads can
get to Destination. */

road(placentia,ariminum).
road(placentia,genua).
road(ariminum,ancona).
road(ariminum,roma).
road(ancona,castrum-truentinum).
road(ancona,roma).
road(castrum-truentinum,roma).
road(brundisium,capua).
road(rhegium,capua).
road(catina,rhegium).
road(syracusae,catina).
road(lilibeum,messana).
road(messana,capua).
road(capua,roma).
road(pisae,roma).
road(genua,pisae).
road(genua,placentia).
road(genua,roma).

can_get_to(Origin,Destination):-
	road(Origin,Destination).

can_get_to(Origin,Destination):-
	road(Origin,B),
	can_get_to(B,Destination).

%	can_get_to(lilibeum, capua).
%	true.

% can_get_to(syracusae,roma).
% true.

% can_get_to(roma,pisae).
% false.

% ---------------------------------------------------------------------------- %

% Exercise 3.

/* Define the predicate size(X, Y, Z) which returns in Z the number of cities
crossed in the path from X to Y, the optimal path is not required, yet. */

size(X,Y,Z):-
	road(X,Y),
	Z is 1.

size(X,Y,Z):-
	road(X,B),
	size(B,Y,AUX),
	Z is AUX + 1.

% size(lilibeum,capua,Z).
% Z = 2.

% size(syracusae,roma,Z).
% Z = 4.

% size(ariminum,roma,Z).
% Z = 1.

% size(roma,pisae,Z).
% false.

% ---------------------------------------------------------------------------- %

% Exercise 4.

/* Define the predicate min(A, B, C, Z), which returns Z as the minimal value
between A, B, and C. */

min(A,B,C,Z):- A<B, A<C, Z is A.
min(A,B,C,Z):- B<A, B<C, Z is B.
min(A,B,C,Z):- C<A, C<B, Z is C.

min(A,B,C,Z):- A=B, B=C, Z is A.

min(A,B,C,Z):- A<B, B=C, Z is A.
min(A,B,C,Z):- B<A, A=C, Z is B.
min(A,B,C,Z):- C<A, A=B, Z is C.

min(A,B,C,Z):- A=B, A<C, Z is A.
min(A,B,C,Z):- B=C, B<A, Z is B.
min(A,B,C,Z):- A=C, A<B, Z is A.

% min(10,20,30,Z).
% Z = 10.

% min(20,10,30,Z).
% Z = 10.

% min(30,20,10,Z).
% Z = 10.

% min(10,10,20,Z).
% Z = 10.

% min(20,10,10,Z).
% Z = 10.

% min(10,10,10,Z).
% Z = 10.

% ---------------------------------------------------------------------------- %

% Exercise 5.

/* Define the predicate gcd(A, B, Z), which returns Z as the greatest common
divisor (or highest common factor) of A and B. */

gcd(0,X,X):- X > 0, !.
gcd(X,Y,Z):- X >= Y, X1 is X-Y, gcd(X1,Y,Z).
gcd(X,Y,Z):- X < Y, X1 is Y-X, gcd(X1,X,Z).

% gcd(8,12,Z).
% Z = 4.

% gcd(54,24,Z).
% Z = 6.

% gcd(48,180,Z).
% Z = 12.
