% Knowledge Base 1

hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

% ------------------------------

% Exercise 1.

compatible(X,Y):- hobby(X,Z), 
	hobby(Y,Z),
	dif(X,Y).

% ------------------------------

% Knowledge Base 2

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

% ------------------------------

% Exercise 2.

can_get_to(A,Z):- road(A,Z).

can_get_to(A,Z):- road(A,B),
	can_get_to(B,Z).

% ------------------------------

% Exercise 3.

can_get_to(A,Z):- road(A,Z).

can_get_to(A,Z):- road(A,B),
	can_get_to(B,Z).

