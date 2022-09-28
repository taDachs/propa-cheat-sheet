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

### General

```
// this list partly is stolen from some guy on discord, but I forgot which one
// types
i -> int
l -> long
s -> short
b -> byte
c -> char
f -> float
d -> double
a -> reference

// load constants on the stack
aconst_null // null object
dconst_0 // double 0
dconst_1 // double 1
fconst_0 ... fconst_2 // float 0 to 2
iconst_0 ... iconst_5 // integer 0 to 5

// push immediates
bipush i // push signed byte i on the stack
sipush i // push signed short i on the stack

// variables (X should be replaced by a type, for example i (integer))
// there exists Xload_i for i in [0, 3] to save a few bytes
Xload i // load local variable i (is a number)
Xstore i // store local variable i

// return from function
return // void return
Xreturn // return value of type X

// conditional jumps
if_icmpeq label // jump if ints are equal
if_icmpge label // jump if first int is >=
if_icmpgt label // jump if first int is >
if_icmple label // jump if first int is <
if_icmplt label // jump if first int is <=

ifeq label // jump if = zero
ifge label // jump if >= zero
ifgt label // jump if > zero
iflt label // jump if < zero
ifle label // jump if <= zero
ifne label // jump if != zero

ifnull label // jump if null
ifnonnull label // jump if not null

// Arithmetic, always operates on stack
iinc var const // increment variable var (number) by const (immediate)
isub // Integer subtraction
iadd // Integer addition
imul // Integer multiplication
idiv // Integer division
ineg // negate int
ishl // shift left (arith)
ishr // shift right (arith)

// Logic (für [i, l])
iand // Bitwise and
ior // Bitwise or
ixor // Bitwise or

// Method calls. Stack: [objref, arg1, arg2] <‐
invokevirtual #desc // call method specified in desc
invokespecial #desc // call constructor
invokeinterface #desc // call method on interface
invokestatic #desc // call static method (no objref)

// Misc
nop // No operation

// Arrays
newarray T // new array of type T
Xaload // load type X from array [Stack: arr, index] <‐
Xastore // store type X in array [Stack: arr, index, val] <‐
arraylength // length of array
```

### Examples

#### Arithmetic

**Java:**

```java
void calc(int x, int y) {
  int z = 4;
  z = y * z + x;
}
```

**Bytecode:**

```nasm
iconst_4 // lege eine 4 auf den stack
istore_3 // pop stack und speichere Wert in Variable 3 (z)
iload_2 // lade Variable 2 (y) und lege sie auf den stack
iload_3 // lade Variable 3 (z) und lege sie auf den stack
imul // multipliziere die oberen zwei elemente und lege das ergebnis auf den stack (y * z)
iload_1 // lade Variable 1 (x) und lege sie auf den Stack
iadd // addiere die oberen zwei Elemente und lege sie auf den stack
istore_1 // pop stack und speichere Wert in Variable 3 (z)
```

#### Loops

**Java:**

```java
public int fib(int steps) {
  int last0 = 1;
  int last1 = 1;
  while (--steps > 0) {
    int t = last0 + last1;
    last1 = last0;
    last0 = t;
  }
}
```

**Bytecode:**

```nasm
  iconst_1 // put 1 on stack
  istore_2 // store top of stack in var 2
  iconst_1 // put 1 on stack
  istore_3 // store top of stack in var 3

loop_begin: // label
  iinc 1 -1 // increment var 1 by -1
  iload_1 // load var 1 and put on stack
  ifle after_loop // if top of stack <= 0, jump to after_loop
  iload_2 // put var 2 on stack
  iload_3 // put bar 3 on stack
  iadd // add top two elements and put on stack
  istore 4 // store top of stack in var 4
  iload_2 // load var 2 and put on stack
  istore_3 // store top of stack in var 3
  iload 4 // load var 4 and put on stack
  istore_2 // store top of stack in var 2
  goto loop_begin // jump to loop_begin
after_loop: // label
  iload_2 // load var 2 and put on stack
  ireturn // return top of stack
```
