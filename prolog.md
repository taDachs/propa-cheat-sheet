# Prolog

## Generelles Zeug
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

% Arithmetik ist komisch. 2 - 1 ist ein Term, keine Zahl!
2 - 1 \= 1

% Um Terme auszuwerten braucht man "is"
N1 is N - 1.
```

## Wichtige Funktionen
```prolog
% prüft ob X in L
member(X, L).

% fügt A und B zu C zusammen.
append(A, B, C).

% Länge N einer Liste L
length(L, N).

% sowas wie append kann auch als Generator verwendet werden, sofern C instanziiert ist.
append(A, B, C) % A und B gehen durch alle Teillisten von C

% Negation
not(X). % X ist ein prädikat
```


