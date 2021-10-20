
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/U355FR.pdf").

solution([[1100,	'Pamela',	'Opal',			'14k gold'],       
          [1200,	'Lorraine',	'Aquamarine',	'White gold'],
          [1300,	'Angela',	'Diamond',		'24k gold'],
          [1400,	'Becky',	'Amethyst',		'Silver'],
          [1500,	'Rebecca',	'Topaz',		'Palladium'],
          [1600,	'Darla',	'Sapphire',		'Platinum']
          ]).
customers(['Pamela', 'Lorraine', 'Angela', 'Becky', 'Rebecca', 'Darla']).
stones(['Opal', 'Aquamarine', 'Diamond', 'Amethyst', 'Topaz', 'Sapphire']).
metals(['14k gold', 'White gold', '24k gold', 'Silver', 'Palladium', 'Platinum']).
prices([1100, 1200, 1300, 1400, 1500, 1600]).

solve(T) :-
	T = [ [1100, C1, S1, M1],       
          [1200, C2, S2, M2],
          [1300, C3, S3, M3],
          [1400, C4, S4, M4],
          [1500, C5, S5, M5],
          [1600, C6, S6, M6]
          ],
    stones(Stones), permutation([S1, S2, S3, S4, S5, S6], Stones),
    customers(Customers), permutation([C1, C2, C3, C4, C5, C6], Customers),
    metals(Metals), permutation([M1, M2, M3, M4, M5, M6], Metals),
    clue1(T),
    clue2(T),
    clue3(T),
    clue4(T),
    clue5(T),
    clue7(T),
    clue6(T),
    clue8(T), 
    clue9(T),
    clue10(T),
    clue11(T).

clue1(T) :-
	member([C1, _, _, 'Platinum'], T),
	member([C2, 'Becky', _, _], T),
	C1 > C2.

clue2(T) :- 
	member([_, 'Rebecca', 'Topaz', _], T).

clue3(T) :-
	member([1500, _, 'Topaz', _], T),
	member([_, 'Becky', _, 'Silver'], T);
	member([1500, _, _, 'Silver'], T);
	member([_, 'Becky', 'Topaz', _], T).

clue4(T) :- 
	member([_, _, S, '24k gold'], T),
	S \= 'Sapphire'.

clue5(T) :-
	member([C1, _, _, '24k gold'], T),
	member([C2, _, 'Opal', _], T),
	C1 is C2 + 200.

clue6(T) :-
	member([C1, 'Becky', _, _], T),
	member([C2, _, 'Sapphire', _], T),
	member([C3, _, _, 'Palladium'], T),
	member([C4, _, _, 'White gold'], T),
	member([C5, _, 'Opal', _], T),
	member([C6, _, 'Diamond', _], T),
	prices(Prices), permutation([C1, C2, C3, C4, C5, C6], Prices).

clue7(T) :-
	member([C, 'Pamela', _, _], T),
	C \= 1600.

clue8(T) :-
	member([_, 'Lorraine', _, M], T),
	M \= 'Palladium'.

clue9(T) :-
	member([_, 'Angela', 'Diamond', _], T);
	member([_, 'Angela', 'Aquamarine', _], T).

clue10(T) :-
	member([C1, _, _, 'Silver'], T),
	member([C2, 'Lorraine', _, _], T),
	C1 is C2 + 200.

clue11(T) :-
	member([1400, _, 'Amethyst', _], T).

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
