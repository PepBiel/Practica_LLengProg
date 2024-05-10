% ?- ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]).

% PRINCIPAL
ciutats(CL, CR, FH, FL, L) :- 
    L = [F1, F2, F3, F4],
    permuta([1, 2, 3, 4], F1), 
    permuta([1, 2, 3, 4], F2), 
    permuta([1, 2, 3, 4], F3), 
    permuta([1, 2, 3, 4], F4),
    columnaLeft(CL, L), 
    columnaRight(CR, L), 
    filaHigh(FH, L), 
    filaLow(FL, L).

% PERMUTA
permuta([],[]).
permuta([X|Y],Z) :- permuta(Y,L), insereix(X,L,Z).

% INCEREIX
insereix(E,L,[E|L]).
insereix(E,[X|Y],[X|Z]) :- insereix(E,Y,Z).

%********************* COLUMNA ESQUERRE ***************************
columnaLeft([A, B, C, D], L1) :- analitzamA_CL(A, L1), analitzamB_CL(B, L1), analitzamC_CL(C, L1), analitzamD_CL(D, L1).

% ANALITZAM LA A
analitzamA_CL(A, L1) :- A = 1, L1 = [[4, _, _, _], _, _, _].                       % Sempre es vorà el primer

analitzamA_CL(A, L1) :- A = 2, L1 = [[P, S, T, Q], _, _, _], P < S, T < S, Q < S.  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamA_CL(A, L1) :- A = 2, L1 = [[P, S, T, Q], _, _, _], P > S, P < T, Q < T.  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamA_CL(A, L1) :- A = 2, L1 = [[P, S, T, Q], _, _, _], P > S, P > T, P < Q.  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamA_CL(A, L1) :- A = 3, L1 = [[P, S, T, Q], _, _, _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamA_CL(A, L1) :- A = 3, L1 = [[P, S, T, Q], _, _, _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamA_CL(A, L1) :- A = 3, L1 = [[P, S, T, Q], _, _, _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamA_CL(A, L1) :- A = 4, L1 = [[1, 2, 3, 4], _, _, _].                       % Tots s'han de veure

% ANALITZAM LA B
analitzamB_CL(B, L1) :- B = 1, L1 = [_, [4, _, _, _], _, _].                       % Sempre es vorà el primer

analitzamB_CL(B, L1) :- B = 2, L1 = [_, [P, S, T, Q], _, _], P < S, T < S, Q < S.
analitzamB_CL(B, L1) :- B = 2, L1 = [_, [P, S, T, Q], _, _], P > S, P < T, Q < T.
analitzamB_CL(B, L1) :- B = 2, L1 = [_, [P, S, T, Q], _, _], P > S, P > T, P < Q.

analitzamB_CL(B, L1) :- B = 3, L1 = [_, [P, S, T, Q], _, _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamB_CL(B, L1) :- B = 3, L1 = [_, [P, S, T, Q], _, _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamB_CL(B, L1) :- B = 3, L1 = [_, [P, S, T, Q], _, _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamB_CL(B, L1) :- B = 4, L1 = [_, [1, 2, 3, 4], _, _].                       % Tots s'han de veure

% ANALITZAM LA C
analitzamC_CL(C, L1) :- C = 1, L1 = [_, _, [4, _, _, _], _].

analitzamC_CL(C, L1) :- C = 2, L1 = [_, _, [P, S, T, Q], _], P < S, T < S, Q < S.
analitzamC_CL(C, L1) :- C = 2, L1 = [_, _, [P, S, T, Q], _], P > S, P < T, Q < T.
analitzamC_CL(C, L1) :- C = 2, L1 = [_, _, [P, S, T, Q], _], P > S, P > T, P < Q.

analitzamC_CL(C, L1) :- C = 3, L1 = [_, _, [P, S, T, Q], _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamC_CL(C, L1) :- C = 3, L1 = [_, _, [P, S, T, Q], _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamC_CL(C, L1) :- C = 3, L1 = [_, _, [P, S, T, Q], _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamC_CL(C, L1) :- C = 4, L1 = [_, _, [1, 2, 3, 4], _].                       % Tots s'han de veure

% ANALITZAM LA D
analitzamD_CL(D, L1) :- D = 1, L1 = [_, _, _, [4, _, _, _]].

analitzamD_CL(D, L1) :- D = 2, L1 = [_, _, _, [P, S, T, Q]], P < S, T < S, Q < S.
analitzamD_CL(D, L1) :- D = 2, L1 = [_, _, _, [P, S, T, Q]], P > S, P < T, Q < T.
analitzamD_CL(D, L1) :- D = 2, L1 = [_, _, _, [P, S, T, Q]], P > S, P > T, P < Q.

analitzamD_CL(D, L1) :- D = 3, L1 = [_, _, _, [P, S, T, Q]], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamD_CL(D, L1) :- D = 3, L1 = [_, _, _, [P, S, T, Q]], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamD_CL(D, L1) :- D = 3, L1 = [_, _, _, [P, S, T, Q]], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamD_CL(D, L1) :- D = 4, L1 = [_, _, _, [1, 2, 3, 4]].                       % Tots s'han de veure

%********************* COLUMNA DRETA ***************************
columnaRight([A, B, C, D], L2) :- analitzamA_CR(A, L2), analitzamB_CR(B, L2), analitzamC_CR(C, L2), analitzamD_CR(D, L2).

% ANALITZAM LA A
analitzamA_CR(A, L2) :- A = 1, L2 = [[_ , _, _, 4], _, _, _].                       % Sempre es vorà el primer

analitzamA_CR(A, L2) :- A = 2, L2 = [[Q, T, S, P], _, _, _], P < S, T < S, Q < S.  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamA_CR(A, L2) :- A = 2, L2 = [[Q, T, S, P], _, _, _], P > S, P < T, Q < T.  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamA_CR(A, L2) :- A = 2, L2 = [[Q, T, S, P], _, _, _], P > S, P > T, P < Q.  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamA_CR(A, L2) :- A = 3, L2 = [[Q, T, S, P], _, _, _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamA_CR(A, L2) :- A = 3, L2 = [[Q, T, S, P], _, _, _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamA_CR(A, L2) :- A = 3, L2 = [[Q, T, S, P], _, _, _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamA_CR(A, L2) :- A = 4, L2 = [[4, 3, 2, 1], _, _, _].                       % Tots s'han de veure

% ANALITZAM LA B
analitzamB_CR(B, L2) :- B = 1, L2 = [_, [_ , _, _, 4], _, _].                       % Sempre es vorà el primer

analitzamB_CR(B, L2) :- B = 2, L2 = [_, [Q, T, S, P], _, _], P < S, T < S, Q < S.
analitzamB_CR(B, L2) :- B = 2, L2 = [_, [Q, T, S, P], _, _], P > S, P < T, Q < T.
analitzamB_CR(B, L2) :- B = 2, L2 = [_, [Q, T, S, P], _, _], P > S, P > T, P < Q.

analitzamB_CR(B, L2) :- B = 3, L2 = [_, [Q, T, S, P], _, _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamB_CR(B, L2) :- B = 3, L2 = [_, [Q, T, S, P], _, _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamB_CR(B, L2) :- B = 3, L2 = [_, [Q, T, S, P], _, _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamB_CR(B, L2) :- B = 4, L2 = [_, [4, 3, 2, 1], _, _].                       % Tots s'han de veure

% ANALITZAM LA C
analitzamC_CR(C, L2) :- C = 1, L2 = [_, _, [_ , _, _, 4], _].

analitzamC_CR(C, L2) :- C = 2, L2 = [_, _, [Q, T, S, P], _], P < S, T < S, Q < S.
analitzamC_CR(C, L2) :- C = 2, L2 = [_, _, [Q, T, S, P], _], P > S, P < T, Q < T.
analitzamC_CR(C, L2) :- C = 2, L2 = [_, _, [Q, T, S, P], _], P > S, P > T, P < Q.

analitzamC_CR(C, L2) :- C = 3, L2 = [_, _, [Q, T, S, P], _], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamC_CR(C, L2) :- C = 3, L2 = [_, _, [Q, T, S, P], _], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamC_CR(C, L2) :- C = 3, L2 = [_, _, [Q, T, S, P], _], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamC_CR(C, L2) :- C = 4, L2 = [_, _, [4, 3, 2, 1], _].                       % Tots s'han de veure

% ANALITZAM LA D
analitzamD_CR(D, L2) :- D = 1, L2 = [_, _, _, [_ , _, _, 4]].

analitzamD_CR(D, L2) :- D = 2, L2 = [_, _, _, [Q, T, S, P]], P < S, T < S, Q < S.
analitzamD_CR(D, L2) :- D = 2, L2 = [_, _, _, [Q, T, S, P]], P > S, P < T, Q < T.
analitzamD_CR(D, L2) :- D = 2, L2 = [_, _, _, [Q, T, S, P]], P > S, P > T, P < Q.

analitzamD_CR(D, L2) :- D = 3, L2 = [_, _, _, [Q, T, S, P]], P < S, S < T, Q < T.  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamD_CR(D, L2) :- D = 3, L2 = [_, _, _, [Q, T, S, P]], P > S, P < T, T < Q.  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamD_CR(D, L2) :- D = 3, L2 = [_, _, _, [Q, T, S, P]], P < S, T < S, Q > S.  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamD_CR(D, L2) :- D = 4, L2 = [_, _, _, [4, 3, 2, 1]].                       % Tots s'han de veure

%********************* FILA ADALT ***************************
filaHigh([A, B, C, D], L3) :- analitzamA_FH(A, L3), analitzamB_FH(B, L3), analitzamC_FH(C, L3), analitzamD_FH(D, L3).

% ANALITZAM LA A
analitzamA_FH(A, L3) :- A = 1, P = 4, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], son_diferents(P, S, T, Q).                         % Sempre es vorà el primer

analitzamA_FH(A, L3) :- A = 2, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamA_FH(A, L3) :- A = 2, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamA_FH(A, L3) :- A = 2, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamA_FH(A, L3) :- A = 3, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamA_FH(A, L3) :- A = 3, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamA_FH(A, L3) :- A = 3, L3 = [[P, _, _, _], [S, _, _, _], [T, _, _, _], [Q, _, _, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamA_FH(A, L3) :- A = 4, L3 = [[1, _, _, _], [2, _, _, _], [3, _, _, _], [4, _, _, _]].                       % Tots s'han de veure

% ANALITZAM LA B
analitzamB_FH(B, L3) :- B = 1, P = 4, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], son_diferents(P, S, T, Q).                                                        % Sempre es vorà el primer

analitzamB_FH(B, L3) :- B = 2, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamB_FH(B, L3) :- B = 2, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamB_FH(B, L3) :- B = 2, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamB_FH(B, L3) :- B = 3, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamB_FH(B, L3) :- B = 3, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamB_FH(B, L3) :- B = 3, L3 = [[_, P, _, _], [_, S, _, _], [_, T, _, _], [_, Q, _, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamB_FH(B, L3) :- B = 4, L3 = [[_, 1, _, _], [_, 2, _, _], [_, 3, _, _], [_, 4, _, _]].                       % Tots s'han de veure

% ANALITZAM LA C
analitzamC_FH(C, L3) :- C = 1, P = 4, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], son_diferents(P, S, T, Q).                                                       % Sempre es vorà el primer

analitzamC_FH(C, L3) :- C = 2, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamC_FH(C, L3) :- C = 2, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamC_FH(C, L3) :- C = 2, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamC_FH(C, L3) :- C = 3, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamC_FH(C, L3) :- C = 3, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamC_FH(C, L3) :- C = 3, L3 = [[_, _, P, _], [_, _, S, _], [_, _, T, _], [_, _, Q, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamC_FH(C, L3) :- C = 4, L3 = [[_, _, 1, _], [_, _, 2, _], [_, _, 3, _], [_, _, 4, _]].                       % Tots s'han de veure

% ANALITZAM LA D
analitzamD_FH(D, L3) :- D = 1, P = 4, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], son_diferents(P, S, T, Q).                                                       % Sempre es vorà el primer

analitzamD_FH(D, L3) :- D = 2, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamD_FH(D, L3) :- D = 2, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamD_FH(D, L3) :- D = 2, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamD_FH(D, L3) :- D = 3, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamD_FH(D, L3) :- D = 3, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamD_FH(D, L3) :- D = 3, L3 = [[_, _, _, P], [_, _, _, S], [_, _, _, T], [_, _, _, Q]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamD_FH(D, L3) :- D = 4, L3 = [[_, _, _, 1], [_, _, _, 2], [_, _, _, 3], [_, _, _, 4]].                       % Tots s'han de veure

%********************* FILA ABAIX ***************************
filaLow([A, B, C, D], L4) :- analitzamA_FL(A, L4), analitzamB_FL(B, L4), analitzamC_FL(C, L4), analitzamD_FL(D, L4).

% ANALITZAM LA A
analitzamA_FL(A, L4) :- A = 1, P = 4, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], son_diferents(P, S, T, Q).                                                      % Sempre es vorà el primer

analitzamA_FL(A, L4) :- A = 2, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamA_FL(A, L4) :- A = 2, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamA_FL(A, L4) :- A = 2, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamA_FL(A, L4) :- A = 3, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamA_FL(A, L4) :- A = 3, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamA_FL(A, L4) :- A = 3, L4 = [[Q, _, _, _], [T, _, _, _], [S, _, _, _], [P, _, _, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamA_FL(A, L4) :- A = 4, L4 = [[4, _, _, _], [3, _, _, _], [2, _, _, _], [1, _, _, _]].                       % Tots s'han de veure

% ANALITZAM LA B
analitzamB_FL(B, L4) :- B = 1, P = 4, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], son_diferents(P, S, T, Q).                                                       % Sempre es vorà el primer

analitzamB_FL(B, L4) :- B = 2, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamB_FL(B, L4) :- B = 2, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamB_FL(B, L4) :- B = 2, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamB_FL(B, L4) :- B = 3, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamB_FL(B, L4) :- B = 3, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamB_FL(B, L4) :- B = 3, L4 = [[_, Q, _, _], [_, T, _, _], [_, S, _, _], [_, P, _, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamB_FL(B, L4) :- B = 4, L4 = [[_, 4, _, _], [_, 3, _, _], [_, 2, _, _], [_, 1, _, _]].                       % Tots s'han de veure

% ANALITZAM LA C
analitzamC_FL(C, L4) :- C = 1, P = 4, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], son_diferents(P, S, T, Q).                                                        % Sempre es vorà el primer

analitzamC_FL(C, L4) :- C = 2, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamC_FL(C, L4) :- C = 2, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamC_FL(C, L4) :- C = 2, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamC_FL(C, L4) :- C = 3, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamC_FL(C, L4) :- C = 3, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamC_FL(C, L4) :- C = 3, L4 = [[_, _, Q, _], [_, _, T, _], [_, _, S, _], [_, _, P, _]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamC_FL(C, L4) :- C = 4, L4 = [[_, _, 4, _], [_, _, 3, _], [_, _, 2, _], [_, _, 1, _]].                       % Tots s'han de veure

% ANALITZAM LA D
analitzamD_FL(D, L4) :- D = 1, P = 4, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], son_diferents(P, S, T, Q).                                                      % Sempre es vorà el primer

analitzamD_FL(D, L4) :- D = 2, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P < S, T < S, Q < S, son_diferents(P, S, T, Q).  % Si el primer és més petit que el segon, el tercer i quart han de ser més petits que el segon
analitzamD_FL(D, L4) :- D = 2, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P > S, P < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer i el tercer és més gran que el primer, el quart ha de ser més petit que el tercer
analitzamD_FL(D, L4) :- D = 2, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P > S, P > T, P < Q, son_diferents(P, S, T, Q).  % Si el segon i tercer són més petits que el primer, el quart ha de ser més gran que el primer

analitzamD_FL(D, L4) :- D = 3, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P < S, S < T, Q < T, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més gran que el segon, el quart ha de ser més petit que el tercer
analitzamD_FL(D, L4) :- D = 3, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P > S, P < T, T < Q, son_diferents(P, S, T, Q).  % Si el segon és més petit que el primer, el tercer ha de ser més gran que el primer i el quart més gran que el tercer
analitzamD_FL(D, L4) :- D = 3, L4 = [[_, _, _, Q], [_, _, _, T], [_, _, _, S], [_, _, _, P]], P < S, T < S, Q > S, son_diferents(P, S, T, Q).  % Si el segon és més gran que el primer i el tercer més petit que el segon, el quart ha de ser més gran que el segon

analitzamD_FL(D, L4) :- D = 4, L4 = [[_, _, _, 4], [_, _, _, 3], [_, _, _, 2], [_, _, _, 1]].                       % Tots s'han de veure


%***********************************************************************
% COMPROVAM QUE SIGUIN DIFERENTS
son_diferents(P, S, T, Q) :- P \= S, P \= T, P \= Q,
                            S \= T, S \= Q,
                            T \= Q.
