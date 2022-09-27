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

