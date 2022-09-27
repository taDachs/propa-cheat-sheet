# Java

## Multithreading
### Race conditions
A race condition exists if the order in which threads execute thei operations influences the result of the program.

#### Mutual Exclusion
A code section, of which only one thread is allowed to execute operations at a time, is called a critical section.
If one thread exectues operations of a critical section, other threads will be blocked if they want to enter it as well.

```java
// Synchronized block, someObject is used as the monitor
synchronized(someObject) {
  ...
}

// synchronized function
synchronized void foo() {
  ...
}
```

### Caching and code reordering

- cached variables can lead to inconsistency
- code can be reordered by the compiler

#### `volatile`-keyword

`volatile` ensures that changes to variables are immediately visible to all threads/processors.

- establishes a happens-before relationship
- values are not locally cached in a CPU cache
- no optimization by compiler

```java
// declares a volatile variable
volatile int c = 420;
```

## Functional programming

```java
// lambdas
(int i, int j) -> i + j;

// functional interfaces
@FunctionalInterface
interface Predicate {
  boolean check(int value);
}

public int sum(List<Integer> values, Predicate predicate) {
  ...
};

sum(values, i -> i > 5);

// method reference to static function
SomeClass::staticFunction;
// method reference to object function
someObject::function;
```

## Executors

- Executors abstract from thread creation.
- provides an execute method that accepts a `Runnable`
  ```java
  void execute(Runnable runnable);
  ```
- `ExecutorService` is an interface that provides further lifecycle management logic

```java
Callable<Integer> myCallable = () -> { return currentValue; };
Future<Integer> myFuture = executorService.submit(myCallable);
```

## Streams

Provides functions like

- `filter`
- `map, reduce`
- `collect`
- `findAny`, `findFirst`
- `min`, `max`

Any Java collection can be treated as a stream by calling the `stream()` method

### Example
```java
List<Person> personsInAuditorum = ...;
double average =
  personsInAuditorum
  .stream()
  .filter(Person::isStudent)
  .mapToInt(Person::getAge) // converts a regular Stream to IntStream
  .average()
  .getAsDouble();

// collector
R collect(
  Supplier<R> supplier,
  BiConsumer<R, ? super T> accumulator,
  BiConsumer<R, R> combiner // only used for parallel streams
);

personsInAuditorum.stream().collect(
  () -> 0,
  (currentSum, person) -> { currentSum += person.getAge(); }.
  (leftSum, rightSum) -> { leftSum += rightSum; }
);


// parallel stream
someValues.parallelStream();
```

## Design by Contract
Form of a Hoare triple $\{P\}\ C\ \{Q\}$

- $P$: precondition $\rightarrow$ specification what the supplier expects from the client
- $C$: series of statements $\rightarrow$ the method of body
- $Q$: postcondition $\rightarrow$ specification of what the client can expect from the supplier if the precondition is fulfilled


- client has to ensure that the precondition is fulfilled
- client can expect the postcondition to be fulfilled, if the precondition is
- **Non-Redundancy-Principle:** the body of a routine shall not test for the routine's precondition

```java
/*@ requires size > 0;
  @ ensures size == \old(size) - 1;
  @ ensures \result == \old{top()};
  @ ensures true; // trivial constraint
  @*/
Object pop() { ... }
```

### Liskov Substitution Principle
- preconditions must not be more restrictive than those of the overwritten method: $\texttt{Precondition}_{Super} \Rightarrow \texttt{Precondition}_{Sub}$
- postcondition must be at least as restrictive as thos of the overwritten methods: $\texttt{Postcondition}_{Sub} \Rightarrow \texttt{Postcondition}_{Super}$
