% ?- ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]).

% PERMUTA
permuta([],[]).
permuta([X|Y],Z) :- permuta(Y,L), insereix(X,L,Z).

% INCEREIX
insereix(E,L,[E|L]).
insereix(E,[X|Y],[X|Z]) :- insereix(E,Y,Z).

invertir([],[]).
invertir([X], [X]).
invertir([X | L1], L2) :- invertir(L1, L3), agefir(L3, [X], L2).

afegir([], L, L).   %afegir una llista buida a una llista, el resultat es la llista igual
afegir([X | L1], L2, [X | L3]) :- afegir(L1, L2, L3).

ciutats(CL, CR, FH, FL, L) :- files(CL, CR, L).


files([], [], []).
files([X | F1], [Y | F2], [R | L1]) :- permuta([1, 2, 3, 4], R), comprova(X, R), invertir(R, T), comprova(Y, T), files(F1, F2, L1).

comprova(X, R) :- contar(R, N, 0), X = N.

% mirar quants edificis es veuen
contar([], _, _).
contar([X | L1], N, I) :- I < X, contar(L1, N1, X), N is N1 + 1.