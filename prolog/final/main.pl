% ---------------------------------------------------------------------------- %

% Carlos Roman Rivera - A01700820
% Programming Languages
% Examen Final - Putin

% ---------------------------------------------------------------------------- %

% A simple basic sentence in english is made by subject, verb and predicate.

part(carlos,subject).
part(sandra,subject).
part(sofia,subject).
part(marco,subject).
part(hugo,subject).
part(rudy,subject).
part(benji,subject).
part(he,subject).
part(she,subject).

part(plays,verb).
part(sees,verb).
part(loves,verb).
part(hates,verb).
part(likes,verb).
part(dislikes,verb).

part(football,predicate).
part(baseball,predicate).
part(basketball,predicate).
part(unicorns,predicate).
part(ponies,predicate).
part(computers,predicate).
part(fakers,predicate).
part(cheaters,predicate).
part(carlos,predicate).

% Message to display after success. Putin approves.

resultS('Cookie').

% Auxiliary function to check whether list is empty.

is_empty(List):- not(member(_,List)).

% Base function.

checkSentence(L,R):-
	check(L,R,0).

% Check if the list is empty and the state is final.

check(L,Result,State):-
	is_empty(L),
	State == 3,
	resultS(Result).

% Check if the state is the fist and the word is a subject.

check([H|T],Result,State):-
	State == 0,
	part(H,subject),
	NewState is State + 1,
	check(T,Result,NewState).

% Check if the state is the second and the word is a verb.

check([H|T],Result,State):-
	State == 1,
	part(H,verb),
	NewState is State + 1,
	check(T,Result,NewState).

% Check if the state is the third and the word is a predicate.

check([H|T],Result,State):-
	State == 2,
	part(H,predicate),
	NewState is State + 1,
	check(T,Result,NewState).

% Tests

% checkSentence([carlos,loves,football],R).
% R = 'Cookie'

% checkSentence([benji,hates,cheaters],R).
% R = 'Cookie'

% checkSentence([carlos],R).
% false

% checkSentence([carlos,loves,hates],R).
% false

% checkSentence([carlos,loves,carlos],R).
% R = 'Cookie'
% Boy, am I beatiful.
