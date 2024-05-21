% ?- ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]).

% ciutats([], [], [], [], []).
ciutats(CL, CR, FH, FL, L) :- arrayPermutacio(L, A, 0), files(CL, CR, L), transposta(L, Trans), files(FH, FL, Trans).

arrayPermutacio([], [], _).
arrayPermutacio(L, A, N) :- N is N1 + 1, 


files([], [], []).
files([X | F1], [Y | F2], [R | L1]) :- permuta([1, 2, 3, 4], R), 
                                        comprova(X, R), 
                                        invertir(R, T), 
                                        comprova(Y, T), 
                                        files(F1, F2, L1).

comprova(X, R) :- contar(R, N, 0), X = N.

% mirar quants edificis es veuen
contar([], 0, _).
contar([X | L1], N, I) :- I < X, I \= X, contar(L1, N1, X), N is N1 + 1.
contar([X | L1], N, I) :- I > X, I \= X, contar(L1, N, I).


transposta([], []).
transposta([F | F1], T) :- transposta(F, [F | F1], T). 

transposta([], _, []).
transposta([_ | F1], M, [C | T]) :- columna(M, C, M1), transposta(F1, M1, T).

columna([], [], []).
columna([[X | F] | F1], [X | C], [F | F2]) :- columna(F1, C, F2).


% PERMUTA
permuta([],[]).
permuta([X|Y],Z) :- permuta(Y,L), insereix(X,L,Z).

% INCEREIX
insereix(E,L,[E|L]).
insereix(E,[X|Y],[X|Z]) :- insereix(E,Y,Z).

% INVERTIM
invertir([],[]).
invertir([X | L1], L2) :- invertir(L1, L3), afegir(L3, [X], L2).

% AFEGIM
afegir([], L, L).   %afegir una llista buida a una llista, el resultat es la llista igual
afegir([X | L1], L2, [X | L3]) :- afegir(L1, L2, L3).