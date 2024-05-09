% ?- ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]).

ciutats(CL, CR, FH, FL, L) :-    columnaLeft(CL), columnaRight(CR), filaHigh(FH), filaLow(FL), solucio(L).

solucio([_, _, _, _]).

columnaLeft([A, B, C, D]) :- A = 1, L1 = [[4, _, _, _], _, _, _], solucio(L1),
                            B = 1, L1 = [_, [4, _, _, _], _, _], solucio(L1),
                            C = 1, L1 = [_, _, [4, _, _, _], _], solucio(L1),
                            D = 1, L1 = [_, _, _, [4, _, _, _]], solucio(L1).

columnaRight([A, B, C, D]) :- A = 1, L2 = [[_ , _, _, 4], _, _, _], solucio(L2),
                            B = 1, L2 = [_, [_ , _, _, 4], _, _], solucio(L2),
                            C = 1, L2 = [_, _, [_ , _, _, 4], _], solucio(L2),
                            D = 1, L2 = [_, _, _, [_ , _, _, 4]], solucio(L2).

filaHigh([A, B, C, D]) :- A = 1, L3 = [[4, _, _, _], _, _, _], solucio(L3),
                            B = 1, L3 = [[_, 4, _, _], _, _, _], solucio(L3),
                            C = 1, L3 = [[_, _, 4, _], _, _, _], solucio(L3),
                            D = 1, L3 = [[_, _, _, 4], _, _, _], solucio(L3).

filaLow([A, B, C, D]) :- A = 1, L4 = [_, _, _, [4, _, _, _]], solucio(L4),
                          B = 1, L4 = [_, _, _, [_, 4, _, _]], solucio(L4),
                          C = 1, L4 = [_, _, _, [_, _, 4, _]], solucio(L4),
                          D = 1, L4 = [_, _, _, [_, _, _, 4]], solucio(L4).