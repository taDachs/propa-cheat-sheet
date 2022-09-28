# Compiler

## Basics
- **Lexikalische Analyse:**
  - Eingabe: Sequenz von Zeichen
  - Aufgaben:
    - erkenne bedeutungstragende Zeichengruppen: Tokens
    - überspringe unwichtige Zeichen (Leerzeichen, Kommentare, ...)
    - bezeichner identifizieren und zusammenfassen in Stringtabelle
  - Ausgabe: Sequenz von Tokens

- **Syntaktische Analyse:**
  - Eingabe: Sequenz von Tokens
  - Aufgaben:
    - überprüfe, ob Eingabe zu kontexfreier Sprache gehört
    - erkenne hierachische Struktur der Eingabe
  - Ausgabe: Abstrakter Syntaxbaum (AST)

- **Semantische Analyse:**
  - Eingabe: Syntax Baum
  - Aufgaben: kontextsensitive Analyse (syntaktische Analyse ist kontextfrei)
    - Namensanalyse: Beziehung zwischen Deklaration und Verwendung
    - Typanalyse: Bestimme und prüfe Typen von Variablen, Funktionen, ...
    - Konsistenzprüfung: Alle Einschränkungen der Programmiersprache eingehalten
  - Ausgabe: Attributierter Syntaxbaum
  - ungültige Programme werden spätestens in Semantischer Analyse abgelehnt

- **Codegenerierung:**
  - Eingabe: Attributierter Syntaxbaum oder Zwischencode
  - Aufgaben: Erzeuge Code für Zielmaschine
  - Ausgabe: Program in Assembler oder Maschinencode

## Linksrekursion
- Linksrekursive kontextfreie Grammatiken sind für kein k SLL(k).
- Für jede kontextfreie Grammatik $G$ mit linksrekursiven Produktionen gibt es eine kontextfreie Grammatik $G'$ ohne Linksrekursion mit $L(G) = L(G')$

## Java Bytecode

```java
void calc(int x, int y) {
  int z = 4;
  z = y * z + x;
}
```

```
iconst_4 // lege eine 4 auf den stack
istore_3 // pop stack und speichere Wert in Variable 3 (z)
iload_2 // lade Variable 2 (y) und lege sie auf den stack
iload_3 // lade Variable 3 (z) und lege sie auf den stack
imul // multipliziere die oberen zwei elemente und lege das ergebnis auf den stack (y * z)
iload_1 // lade Variable 1 (x) und lege sie auf den Stack
iadd // addiere die oberen zwei Elemente und lege sie auf den stack
istore_1 // pop stack und speichere Wert in Variable 3 (z)
```
