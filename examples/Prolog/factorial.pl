factH(1,1).

factH(X, R):-
	X1 is X - 1,
	factH(X1, NR),
	R is X * NR.

factT(X,R):-
	factT(X,0,1,R).

factT(0,_,Res,Res):-!.

factT(X,Ct,Ax,R):-
	X1 is X - 1,
	NewCt is Ct + 1,
	NewAx is NewCt * Ax,
	factT(X1,NewCt,NewAx,NewR).