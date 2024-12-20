% **************************************************************
% ************************ PRÀCTICA LISP ***********************
% **************************************************************

% ************************ AUTORS ***********************

% Jordi Florit Ensenyat
% Josep Gabriel Fornes Reynes

% ************************ OBJECTIUS ***********************

% ?- ciutats([2,1], [1,2], [2,1], [1,2], [F1,F2])
% ?- ciutats([2,1,2], [1,2,2], [3,1,2], [2,2,1], [F1,F2,F3]). EXEMPLE ERRONI
% L'exemple anterior és erroni, ja que ens diu que a la part superior es veuen 3 edificis(la columna hauria de ser [1, 2, 3]) 
% i a la part inferior ens diu que s'han de veure 2 edificis, cosa que és impossible, ja que el primer edifici és d'altura
% 3, i sols es veuria 1 edifici.
% ?- ciutats([3,1,2], [1,2,2], [3,1,2], [2,1,3], [F1,F2,F3]).
% ?- ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]).
% ?- ciutats([5,4,2,2,1], [1,2,2,2,4], [4,3,3,2,1], [1,2,3,2,3], [F1,F2,F3,F4,F5]).
% Per poder veure totes les solucions podem insertar aquests objectius
% ?- ciutats(A, B, C, D, [F1,F2]).
% ?- ciutats(A, B, C, D, [F1,F2,F3]).
% ?- ciutats(A, B, C, D, [F1,F2,F3,F4]).
% ?- ciutats(A, B, C, D, [F1,F2,F3,F4,F5]). TARDARÀ BASTANT, PERÒ FUNCIONA

% ************************ INICI ***********************

ciutats(CL, CR, FH, FL, L) :- arrayPermutacio(L, A), files(CL, CR, L, A), transposta(L, Trans), files(FH, FL, Trans, A).

% predicat per generar l'array de permutacions per a les possibles solucions
arrayPermutacio(L, Res) :-
    length(L, N),
    llista(1, N, Res).

% retorna una llista amb valors entre el valor inicial i el final
llista(Final, Final, [Final]) :- !.
llista(Inici, Final, [Inici | Resta]) :-
    Inici < Final,
    Seguent is Inici + 1,
    llista(Seguent, Final, Resta).

% ens pasen dues llistes inicials i generam les possibles solucions, primer per la primera llista i llavors per la segona
files([], [], [], _).
files([X | F1], [Y | F2], [R | L1], A) :- permuta(A, R), 
                                        comprova(X, R), 
                                        invertir(R, T), 
                                        comprova(Y, T), 
                                        files(F1, F2, L1, A).

% comprovam que el valor que ens pasen en el primer element coincideix amb el nombre d'edificis que hem detectat que es veuen.
% SI coincideixen és correcte la solucio, sino no ho es.
comprova(X, R) :- contar(R, N, 0), X = N.

% mirar quants edificis es veuen
contar([], 0, _).
contar([X | L1], N, I) :- I < X, I \= X, contar(L1, N1, X), N is N1 + 1.
contar([X | L1], N, I) :- I > X, I \= X, contar(L1, N, I).

% feim la transposta de la matriu que ens passen
transposta([[]|_], []).
transposta(L1,[L3|L5]):-agafaPrimers(L1,L3), agafaDarrers(L1,L4), 
                                                transposta(L4,L5). 

agafaPrimers([],[]).
agafaPrimers([[X|_]|L2],[X|L3]):-agafaPrimers(L2,L3).

agafaDarrers([],[]).
agafaDarrers([[_|L1]|L2],[L1|L3]):-agafaDarrers(L2,L3).


% PERMUTA
permuta([],[]).
permuta([X|Y],Z) :- permuta(Y,L), insereix(X,L,Z).

% INSEREIX
insereix(E,L,[E|L]).
insereix(E,[X|Y],[X|Z]) :- insereix(E,Y,Z).

% INVERTIM
invertir([],[]).
invertir([X | L1], L2) :- invertir(L1, L3), afegir(L3, [X], L2).

% AFEGIM
afegir([], L, L).
afegir([X | L1], L2, [X | L3]) :- afegir(L1, L2, L3).