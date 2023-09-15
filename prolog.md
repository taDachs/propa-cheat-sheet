# Prolog

## Generelles Zeug
Prolog ist nicht vollständig da die nächste Regel deterministisch gewählt wird, daher können Endlosschleifen entstehen und keine Lösung gefunden werden obwohl sie existiert.
```prolog
% klein geschriebene Namen sind Atome
mag(ich, dich). % nein tu ich nicht

% Prolog erfüllt Teilziele von links nach rechts
foo(X) :- subgoal1(X), subgoal2(X), subgoal3(X).

% ! signalisiert einen cut, alles vor dem cut ist nicht reerfüllbar.
% Arten von Cuts:
%  - Blauer Cut
%      - beeinflusst weder Programmlaufzeit, noch -verhalten
%  - Grüner Cut
%      - beeinflusst Laufzeit, aber nicht Verhalten
%  - Roter Cut
%      - beeinflusst das Programmverhalten
% Zuweisungen immer nach dem cut!
foo(X, Y) :- operation_where_we_only_want_the_first_result(X, Z), !, Y = Z.

% generate and test
foo(X, Y) :- generator(X, Y), tester(Y).

% listen sind so wie in haskell
foo([H|T]) :- ...

% weitere listen sachen
[1,2,3|[4,5,6,7]] = [1,2,3,4,5,6,7]

% Arithmetik ist komisch. 2 - 1 ist ein Term, keine Zahl!
2 - 1 \= 1

% Um Terme auszuwerten braucht man "is"
N1 is N - 1.
```

## Wichtige Funktionen
```prolog
% Negation
not(X). % X ist ein prädikat

%% Listen:

member(X, L). % prüft ob X in L

append(A, B, C). % fügt A und B zu C zusammen.

prefix(P, S). % Ist P Prefix von S

length(L, N). % Hat Liste L genau N Elemente

reverse(L, R). % Ist R das Reverse von L

permutation(L, P). % Ist P eine Permutation von Liste L

sum_list(L, N). % Ist L die Summe der Elemente von N

max_list(L, M). % Ist M das größte Element in L

is_set(L). % Besitzt die Liste L nur unique Elemente

length(L, N). % Länge N einer Liste L

% sowas wie append kann auch als Generator verwendet werden, sofern C instanziiert ist.
append(A, B, C) % A und B gehen durch alle Teillisten von C

% Beispieldefinition zu not(X) (impossible without \!):
not(X) :- call(X),!,fail.
not(X).

% Beispiel: Quicksort in Haskell
split(P,[H|A],B,[H|T]) :- H<P, !, split(P,A,B,T).
split(P,A,[H|B],[H|T]) :- split(P,A,B,T).
split(_,[],[],[]).

qsort([],[]).
qsort([P|L],S) :- 
	split(P,X,Y,L), !, 
	qsort(X,XS), !,
	qsort(Y,YS), !,
	append(XS,[P|YS],S), !.
```


