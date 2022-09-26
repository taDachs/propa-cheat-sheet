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

