# Curry-Howard Isomorphism 

(constructive logic) proving = (functional) programming

## Grundregeln
$$
\begin{array}{rl}
  \textbf{fst} \langle M, N \rangle &\leadsto M \\[4pt]
  \textbf{snd} \langle M, N \rangle &\leadsto N \\[4pt]
  (\lambda u. M)\;N &\leadsto M[u \mapsto N] \\[4pt]
  \textbf{case}\;\textbf{inl}\;M\;\textbf{of} &
    \begin{array}[t]{l}
      \textbf{inl}\;u \Rightarrow N \, | \,     \textbf{inr}\;w \Rightarrow O
    \end{array}
  \leadsto N[u \mapsto M] \\[8pt]
  \textbf{case}\;\textbf{inr}\;M\;\textbf{of} &
    \begin{array}[t]{l}
      \textbf{inl}\;u \Rightarrow N \, | \,
      \textbf{inr}\;w \Rightarrow O
    \end{array}
  \leadsto O[w \mapsto M]
\end{array}
$$

## Allgemeines Vorgehen
Ziel ist, die Ableitungen auf der linken Seite zu vereinfachen (oder im Fall von $\eta$-expansion zu erweitern). Dazu heben sich typischerweise aufeinanderfolgende Operationen der Art Introduction/Destruktion gegenseitig auf. 

\begin{center}
  \textit{Justification: reduce elimination of introduction / destructor~$\circ$~constructor}
\end{center}

## $\beta$-reduction Beispiel:

$$
\frac{\frac{
\begin{array}{c}
  \overline{u : A} \\
  \mathcal{D} \\
  M : B
\end{array}}
{{\lambda u.M : A \to B}} \, \, \, \begin{array}{c} \overline{\, \, \mathcal{E} \, \, } \\ N : A \end{array}}{
     {(\lambda u. M)\;N : B}}
\quad\leadsto\quad
\begin{array}{c}
\frac{\mathcal{E}}{u : A} \\
     {\mathcal{D}[u \mapsto N]} \\
M[u \mapsto N] : B 
\end{array}
$$

