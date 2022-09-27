---
title: "Programmierparadigmen macht Spaß"
author: "Darius Schefer, Max Schik"
geometry: margin=2cm
output: pdf_document
---
# Viel Spaß

# Haskell
Haskell is great.

## General Haskell stuff
```haskell

-- type definitions are right associative
foo :: (a -> (b -> (c -> d)))
-- function applications are left associative
((((foo a) b) c) d)

-- guards are unnecessary if you know how pattern matching works
foo x y
  | x > y = "shit"
  | x < y = "piss"
  | x == y = "arschsekretlecker"
  | default = "love"

-- case of does pattern matching so its okay
foo x = case x of
          [] -> "fleischpenis"
          [1] -> "kokern"
          (420:l) -> "pimpern"

-- list comprehension is not as good as in python
[foo x | x <- [1..420], x `mod` 2 == 0]

-- alias for pattern matching
foo l@(x:xs) = l == (x:xs) -- returns true

data Tree a = Leaf
              | Node (Tree a) a (Tree a)
              deriving (Show)

-- defines interface
class Eq t where
  (==) :: t -> t -> Bool
  (/=) :: t -> t -> Bool
  -- default implementation
  x /= y = not $ x == y

-- extends interface
class (Show t) => B t where
  foo :: (B t) -> String

-- implement interface
instance Eq Bool where
  True == True = True
  False == False = True
  True == False = False
  False == True = False
```

## Important functions
```haskell
-- fold from left
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- fold from right
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- checks if a in collection
elem :: (Foldable t, Eq a) => a -> t a -> Bool
-- in a list of type [(key, value)]  returns first element where key matches given value
lookup :: Eq a => a -> [(a, b)] -> Maybe b
-- repeated application of function
iterate :: (a -> a) -> a -> [a]
-- repeats constant in infinite list
repeat :: a -> [a]
-- applies function until the predicate is true
until :: (a -> Bool) -> (a -> a) -> a -> a
```

# Lambda Calculus

## General stuff
- Function application is left associative $\lambda x.\ f\ x\ y = \lambda x.\ ((f\ x)\ y)$
- untyped lambda calculus is turing complete

### Primitive Operations

#### Let
- let $x = t_1$ in $t_2$ wird zu $(\lambda x.\,t_2)\,t_1$

#### Church Numbers
- $c_0 = \lambda s.\,\lambda z.z$
- $c_1 = \lambda s.\,\lambda z.s\,z$
- $c_2 = \lambda s.\,\lambda z.s\,(s\,z)$
- $c_3 = \lambda s.\,\lambda z.s\,(s\,(s\,z))$
- etc...
- **Successor Function**
    - $succ\,c_2=c_3$
- **Arithmetic Operations**
    - **TODO**
    - Addition: $plus$
    - Multiplikation: $times$
    - Potenzieren: $exp$

#### Boolean Values
- $True$: $\ c_{true} = \lambda t.\ \lambda f.\ t$
- $False$: $\ c_{false} = \lambda t.\ \lambda f.\,f$

## Equivalences

### $\alpha$-equivalence
Two terms $t_1$ and $t_2$ are $\alpha$-equivalent $t_1 \stackrel{\alpha}{=} t_2$ if $t_1$ and $t_2$ can be transformed into each other just by consistent renaming of the bound variables.

#### Example
$$
\lambda x. x \stackrel{\alpha}{=} \lambda y. y \\
\lambda x. (\lambda z. f (\lambda y. z y) x) \stackrel{\alpha}{\neq} \lambda z. (\lambda z. f (\lambda y. z \ y) z)
$$

### $\eta$-equivalence
Two terms $\lambda x. f \ x$ and $f$ are $\eta$-equivalent $\lambda x. f \ x \stackrel{\eta}{=} f$
if $x$ is not a free variable of $f$.

#### Example
$$
\lambda x.f\,z\,x \stackrel{\eta}{=} f\,z \\
\lambda x.g\,x\,x \stackrel{\eta}{\neq} g\,x
$$

## Reductions

### $\beta$-reduction
A $\lambda$-term of the shape $(\lambda x. x)\ y$ is called a Redex. The $\beta$-reduction is the
evaluation of a function application on a redex.
$$
(\lambda x. t_1)\,t_2 \Rightarrow t1\ [x \mapsto t_2]
$$

### Normal Form
A term that can no longer be reduced is called Normal Form. The Normal Form is unique. Terms that
don't get reduced to Normal Form diverge (grow infinitely large.

### Church-Rosser
The untyped $\lambda$ is confluent $\Leftrightarrow$ If $t \stackrel{*}{\Rightarrow} t_1$ and $t \stackrel{*}{\Rightarrow} t_2$ then there exists a $t'$ with $t_1 \stackrel{*}{\Rightarrow} t'$ and $t_2 \stackrel{*}{\Rightarrow} t'$,

### Recursion
For a recursive function $G = \lambda g.\ (\lambda x .\ g\ x)$ has the fixpoint $g^{*} = G g^{*}$ if it exists.

$Y = \lambda f.\,(\lambda x.\,f\,(x\,x))\,(\lambda x.\,f\,(x\,x))$ is called the recursion operator.
$Y\ G$ is the fixpoint of $G$.

### Evaluation Strategies

#### Full $\beta$-Reduction
Every Redex can be reduced at any time.

#### Normal Order
The leftmost outer redex gets reduced.

#### Call by Name (CBN)
Reduce the leftmost outer Redex if not surrounded by a lambda.

##### Example
$$
(\lambda \textcolor{green}{y}.\ (\lambda x.\ \textcolor{green}{y}\ (\lambda z.\ z)\ x))\ \textcolor{red}{((\lambda x.\ x)\ (\lambda y.\ y))} \\
\Rightarrow (\lambda x.\ ((\lambda \textcolor{green}{x.\ x})\ \textcolor{red}{(\lambda y.\ y)})\ (\lambda z.\ z)\ x) \nRightarrow
$$

#### Call by Value (CBV)
Reduce the leftmost Redex if not surrounded by a lambda and the argument is a value. A value means
the term can not be further reduced.

##### Example
$$
(\lambda y.\ (\lambda x.\ y\ (\lambda z.\ z)\ x))\ ((\lambda \textcolor{green}{x.\ x})\ \textcolor{red}{(\lambda y.\ y)}) \\
\Rightarrow (\lambda \textcolor{green}{y}.\ (\lambda x.\ \textcolor{green}{y}\ (\lambda z.\ z)\ x))\ \textcolor{red}{(\lambda y.\ y)} \\
\Rightarrow (\lambda x.\ (\lambda \textcolor{green}{y}.\ \textcolor{green}{y})\ \textcolor{red}{(\lambda z.\ z)}\ x) \nRightarrow
$$

Call by Name and Call by Value may not reduce to the Normal Form! Call by Name terminates more often than Call by Value.

# Typen

## Regelsysteme
- definieren bestimmte Terme als "herleitbar" (geschr. "$\vdash \psi$")
- Frege'sche Regelnotation: aus dem über dem Strich kann man das unter dem Strich herleiten
- Introduktions- und Eliminationsregeln für und/oder, Quantoren etc. **TODO:** screenshot oder mathtex dafür
- Modus Ponens $\frac{\vdash \psi \Rightarrow \phi \;\; \vdash \psi}{\vdash \phi}$
    - Elimination von Implikation
- LEM $\frac{}{\vdash \phi \vee \neg \phi}$
    - (Law of excluded middle)
    - "Es gilt immer $\phi$ oder $\neg \phi$"
- Beweiskontext: $\Gamma \vdash \phi$
    - $\phi$ unter Annahme von $\Gamma$ herleitbar
    - Erleichtert Herleitung von $\phi \Rightarrow \psi$
    - Assumption Introduktion $\frac{}{\Gamma ,\phi \; \vdash \phi}$

## Typsysteme
- Einfache Typisierung
    - $\vdash (\lambda x.\, 2) : bool \rightarrow int$
    - $\vdash (\lambda x.\, 2) : int \rightarrow int$
    - $\vdash (\lambda f.\, 2) : (int \rightarrow int) \rightarrow int$
- Polymorphe Typen
    - $\vdash (\lambda x.\, 2) : \alpha \rightarrow int$

### Regeln
- $\Gamma \vdash t : \tau$: im Typkontext $\Gamma$ hat Term $t$ den Typ $\tau$
- $\Gamma$ ordnet freien Variablen $x$ ihren Typ $\Gamma(x)$ zu
- **CONST**
$$
 CONST\;\;\frac{c \, \in \, Const}{\Gamma \, \vdash \,  c \, : \, \tau_{c}}
$$
- **VAR**
$$VAR\;\;\frac{\Gamma (x) \, = \, \tau}{\Gamma \, \vdash \, x \, : \, \tau}$$
- **ABS**
$$ABS\;\;\frac{\Gamma , x \, : \, \tau_1 \, \vdash \, t \, : \, \tau_2}{\Gamma \, \vdash \, \lambda x.\, t :\, \tau_1 \, \rightarrow \, \tau_2}$$
- **APP**
$$APP\;\;\frac{\Gamma \, \vdash \, t_1 \, : \, \tau_2 \rightarrow \tau \, \, \, \, \, \, \, \, \Gamma \, \vdash \, t_2 \, : \, \tau_2}{\Gamma \, \vdash \, t_1 \, \, t_2 \, : \, \tau}$$

## Forts. Typsysteme
- Nicht alle sicheren Programme sind Typsierbar
    - Typsystem nicht vollständig bzgl. $\beta$-Reduktion
        - insb. Selbsapplikation im Allgemeinen nicht Typisierbar
        - damit auch nicht Y-Kombinator

## Polymorphie
- **Polymorphe Funktionen**
    - Verhalten hängt nicht vom konkreten Typ ab
    - z.B. Operationen auf Containern, wie z.B. Listen

### Typschema
- Für $n \in \mathbb{N}$ heißt $\forall \alpha_1. \dots \forall \alpha_n.\tau$ *Typschema* (Kürzel $\phi$)
- Es bindet freie Typvariablen $\alpha_1, \dots, \alpha_n$ in $\tau$
- VAR-Regel muss angepasst werden
$$VAR\;\;\frac{\Gamma(x) = \phi \; \; \; \; \; \phi \succeq \tau}{\Gamma \, \vdash \, x \, : \, \tau}$$
- LET-Typregel
$$LET\;\;\frac{\Gamma \, \vdash \,t_1 \, : \, \tau_1 \; \; \; \; \; \Gamma , x \, : \, ta\,(\tau_1, \, \Gamma) \, \vdash \, t_2 \, : \, \tau_2}{\Gamma \, \vdash \, let \; x \, = \, t_1 \; in \; t_2 \, : \tau_2}$$
- ta($\tau,\,\Gamma$): Typabstraktion
    - Alle freien Typvariablen von $\tau$ quantifiziert, die nicht frei in Typannahmen von $\Gamma$
    - => Verhindere Abstraktion von globalen Typvariablen im Schema

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


# Unifikation

## Unifikator

- Gegeben: Menge C von Gleichungen über Terme
- $\tau$ = Basistyp, $X$ = Var
- Gesucht ist eine Substitution, die alle Gleichungen erfüllt: **Unifikator**
- **most general unifier**, mgu ist der allgemeinste Unifikator

### Definition Unifikator

Substitution $\sigma$ unifiziert Gleichung $\theta = \theta'$, falls $\sigma\theta = \sigma\theta'$.

$\sigma$ unifiziert C, falls $\forall c \in C$ gilt: $\sigma$ unifiziert c.

Bsp. $C = \{f(a, D) = Y, X = g(b), g(Z) = X\} \Rightarrow \sigma = [Y \rightarrow f(a,b), D \rightarrow d, X \rightarrow g(b), Z \rightarrow b]$

### Definition mgu

$\sigma$ mgu, falls $\forall$ Unifikator $\gamma\ \exists$ Substitution $\delta$. $\gamma = \delta \circ \sigma$.

- Unifikator mit der minimalen Menge an Substitutionen
- Für das Beispiel: $\sigma = [Y \rightarrow f(a, D), X \rightarrow g(b), z \rightarrow b]$
    - für $\gamma$ z. Bsp. $\delta = [D \rightarrow b]$

## Unifikationsalgorithmus: $\texttt{unify(C)} =$

$\texttt{if C == }\emptyset\ \texttt{then []}$

$\texttt{else let }\{\theta_l = \theta_r\} \uplus \texttt{C}' = \texttt{C in}$

$\;\;\;\;\texttt{if } \theta_l \texttt{ == } \theta_r\ \texttt{then unify(C')}$

$\;\;\;\;\texttt{else if }\theta_l\ \texttt{== Y and Y} \notin \texttt{FV(}\theta_r\texttt{) then unify([Y} \rightarrow \theta_r\texttt{]C')} \circ \texttt{[Y}\rightarrow \theta_r\texttt{]}$

$\;\;\;\;\texttt{else if }\theta_r\ \texttt{== Y and Y} \notin \texttt{FV(}\theta_l\texttt{) then unify([Y} \rightarrow \theta_l\texttt{]C')} \circ \texttt{[Y}\rightarrow \theta_l\texttt{]}$

$\;\;\;\;\texttt{else if } \theta_l \texttt{ == f(}\theta_l^1,...,\theta_l^n \texttt{) and } \theta_r \texttt{ == f(}\theta_r^1,...,\theta_r^n\texttt{)}$

$\;\;\;\;\;\;\;\;\texttt{then unify(C'}\cup\{\theta_l^1=\theta_r^1,...,\theta_l^n = \theta_r^n\}\texttt{)}$

$\;\;\;\;\texttt{else \textbf{fail}}$

$\texttt{unify(C)}$ terminiert und gibt **mgu** für C zurück, falls C unifizierbar, ansonsten **fail**.
