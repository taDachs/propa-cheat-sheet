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
$$

$$
\lambda x. (\lambda z. f (\lambda y. z y) x) \stackrel{\alpha}{\neq} \lambda z. (\lambda z. f (\lambda y. z \ y) z)
$$

### $\eta$-equivalence
Two terms $\lambda x. f \ x$ and $f$ are $\eta$-equivalent $\lambda x. f \ x \stackrel{\eta}{=} f$
if $x$ is not a free variable of $f$.

#### Example
$$
\lambda x.f\,z\,x \stackrel{\eta}{=} f\,z \\
$$

$$
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
$$

$$
\Rightarrow (\lambda x.\ ((\lambda \textcolor{green}{x.\ x})\ \textcolor{red}{(\lambda y.\ y)})\ (\lambda z.\ z)\ x) \nRightarrow
$$

#### Call by Value (CBV)
Reduce the leftmost Redex if not surrounded by a lambda and the argument is a value. A value means
the term can not be further reduced.

##### Example
$$
(\lambda y.\ (\lambda x.\ y\ (\lambda z.\ z)\ x))\ ((\lambda \textcolor{green}{x.\ x})\ \textcolor{red}{(\lambda y.\ y)}) \\
$$

$$
\Rightarrow (\lambda \textcolor{green}{y}.\ (\lambda x.\ \textcolor{green}{y}\ (\lambda z.\ z)\ x))\ \textcolor{red}{(\lambda y.\ y)} \\
$$

$$
\Rightarrow (\lambda x.\ (\lambda \textcolor{green}{y}.\ \textcolor{green}{y})\ \textcolor{red}{(\lambda z.\ z)}\ x) \nRightarrow
$$

Call by Name and Call by Value may not reduce to the Normal Form! Call by Name terminates more often than Call by Value.

