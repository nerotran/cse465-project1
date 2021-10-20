
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/S388IZ.pdf").

solution([[1920,	'Grant',	'Cinnamon',			'Coffee maker'],       
          [1934,	'Sandra',	'Peppermint',		'Blender'],
          [1949,	'Ruby',		'Grape',			'Microwave'],
          [1975,	'Kai',		'Tropical fruit',	'Toaster'],
          [1990,	'Janiya',	'Bubblegum',		'Juice press']
          ]).
firstnames(['Grant', 'Sandra', 'Ruby', 'Kai', 'Janiya']).
gum(['Cinnamon', 'Peppermint', 'Grape', 'Tropical fruit', 'Bubblegum']).
gifts(['Coffee maker', 'Blender', 'Microwave', 'Toaster', 'Juice press']).
years([1920, 1934, 1949, 1975, 1990]).

solve(T) :-
	T = [ [1920, N1, G1, W1],       
          [1934, N2, G2, W2],    
          [1949, N3, G3, W3],
          [1975, N4, G4, W4],
          [1990, N5, G5, W5]],
    gum(Gum), permutation([G1, G2, G3, G4, G5], Gum),
    firstnames(Names), permutation([N1, N2, N3, N4, N5], Names),
    gifts(Gifts), permutation([W1, W2, W3, W4, W5], Gifts),
    clue1(T),
    clue2(T),
    clue3(T),
    clue4(T),
    clue5(T),
    clue7(T),
    clue6(T),
    clue8(T), 
    clue9(T).

clue1(T) :-
	member([Y1, _, 'Tropical fruit', _], T),
	member([Y2, _, _, 'Juice press'], T),
	Y1 < Y2.


clue2(T) :-
	member([1949, 'Ruby', _, _], T).

clue3(T) :-
	member([_, _, G1, 'Toaster'], T),
	G1 \= 'Cinnamon'.

clue4(T) :-
	member([Y1, _, _, 'Blender'], T),
	member([Y2, _, 'Cinnamon', _], T),
	Y1 > Y2.

clue5(T) :-
	member([Y1, 'Sandra', _, _], T),
	member([Y2, _, 'Cinnamon', _], T),
	Y1 > Y2.

clue6(T) :-
	member([1975, _, 'Tropical fruit', _], T).

clue7(T) :-
	member([_, 'Grant', _, 'Coffee maker'], T);
	member([_, 'Grant', _, 'Juice press'], T).

clue8(T) :-
	member([Y1, _, 'Cinnamon', _], T),
	member([Y2, _, _, 'Blender'], T),
	member([1975, _, _, _], T),
	member([Y3, 'Janiya', _, _], T),
	member([Y4, _, 'Grape', _], T),
	years(Years), permutation([Y1, Y2, Y3, 1975, Y4], Years).

clue9(T) :-
	member([1949, _, _, _, 'Microwave'], T),
	member([_, 'Sandra', 'Peppermint', _], T);
	member([_, _, _, 'Peppermint', 'Microwave'], T);
	member([_, 'Sandra', 'Peppermint', _], T).

check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
