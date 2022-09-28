# Parallelprogrammierung

**Uniform Memory access (UMA):** .

**Parallelismus:** Mindestens zwei Prozesse laufen gleichzeitig.

**Concurrency:** Mindestens zwei Prozesse machen Fortschritt.

**Amdahls' Law:**

$$
S(n) = \frac{T(1)}{T(n)} = \frac{\text{execution time if processed by 1 processor}}{\text{execution time if processed by n processors}} = \text{speedup}
$$
$$
S(n) = \frac{1}{(1 - p) + \frac{p}{n}} \text{ with } p = \text{parallelizable percentage of program}
$$

**Data Parallelism:** Die gleiche Aufgabe wird parallel auf unterschiedlichen Daten ausgeführt.

**Task Parallelism:** Unterschiedliche Aufgaben werden auf den gleichen Daten ausgeführt.

## Flynn's Taxanomy

| Name | Beschreibung | Beispiel |
|------|--------------|----------|
| SISD | a single instruction stream operates on a single memory              | von Neumann Architektur |
| SIMD | one instruction is applied on homogeneous data (e.g. an array) | vector processors of early supercomputer |
| MIMD | different processors operate on different data | multi-core processors |
| MISD | multiple instructions are executed simultaneously on the same data | redundant architectures |

## MPI

```cpp
// default communicator, i.e. the collection of all processes
MPI_Comm MPI_COMM_WORLD;

// returns the number of processing nodes
int MPI_Comm_size(MPI_Comm comm, int *size);

// returns the rank for the processing node, root node has rank 0
int MPI_Comm_size(MPI_Comm comm, int *size);

// initializes MPI
int MPI_Init(int *argc, char ***argv);


// Cleans up MPI (called in the end)
int MPI_Finalize();

// blocks until all processes have called it
int MPI_Barrier(MPI_Comm comm);

// blocking asynchrounous send. blocks until message buffer can be reused, i.e. message has been received.
int MPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm)

// blocking asynchrounous receive. blocks until message is received in the buffer completly.
int MPI_Recv(void *buf, int count, MPI_Datatype datatype, int source, int tag,
             MPI_Comm comm, MPI_Status *status)

```

### Communication Modes

#### Synchronous

No buffer, synchronization (both sides wait for each other)

#### Buffered

Explicit buffering, no synchronization (no wait for each other)

#### Ready

No buffer, no synchronization, matching receive must already be initiated

#### Standard

May be buffered or not, can be synchronous (implementation dependent)

There is only one receive mode.

```cpp
MPI_Send() // standard-mode blocking send
MPI_Bsend() // buffered-mode blocking send
MPI_Ssend() // synchronous-mode blocking send
MPI_Rsend() // ready-mode blocking send

// non-blocking send and receive operations
int MPI_Irecv(void *buf, int count, MPI_Datatype datatype, int source,
              int tag, MPI_Comm comm, MPI_Request * request);
int MPI_Isend(const void *buf, int count, MPI_Datatype datatype, int dest, int tag,
              MPI_Comm comm, MPI_Request *request);

// send and receive operations can be checked for completion
int MPI_Test(MPI_Request* r, int* flag, MPI_Status* s);
// blocking check
int MPI_Wait(MPI_Request* r, MPI_Status* s);

```

### Collective Operations

#### `MPI_Bcast`

```cpp
int MPI_Bcast(void* buffer, int count, MPI_Datatype t, int root, MPI_Comm comm);
```

$$
\begin{bmatrix}
A_0 & \  & \ \\
    & \  & \ \\
    & \  & \
\end{bmatrix}
\overset{Broadcast}{\rightarrow}
\begin{bmatrix}
A_0 & \  & \ \\
A_0 & \  & \ \\
A_0 & \  & \
\end{bmatrix}
$$

#### `MPI_Scatter` `MPI_Gather`

```cpp
int MPI_Scatter(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
               void *recvbuf, int recvcount, MPI_Datatype recvtype, int root,
               MPI_Comm comm)

int MPI_Gather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
               void *recvbuf, int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)
```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
    & \   & \ \\
    & \   & \
\end{bmatrix}
\overset{scatter}{\underset{gather}{\rightleftarrows}}
\begin{bmatrix}
A_0 & \  & \ \\
A_1 & \  & \ \\
A_2 & \  & \
\end{bmatrix}
$$

#### `MPI_Allgather`

```cpp
int MPI_Allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                  void *recvbuf, int recvcount, MPI_Datatype recvtype, MPI_Comm comm)
```

$$
\begin{bmatrix}
A_0 & \  & \ \\
B_0 & \  & \ \\
C_0 & \  & \
\end{bmatrix}
\overset{Allgather}{\rightarrow}
\begin{bmatrix}
A_0 & B_0  & C_0 \ \\
A_0 & B_0  & C_0 \ \\
A_0 & B_0  & C_0 \
\end{bmatrix}
$$

#### `MPI_Alltoall`

```cpp
int MPI_Alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                 void *recvbuf, int recvcount, MPI_Datatype recvtype,
                 MPI_Comm comm)

```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
B_0 & B_1 & B_2 \\
C_0 & C_1 & C_2
\end{bmatrix}
\overset{Alltoall}{\rightarrow}
\begin{bmatrix}
A_0 & B_0  & C_0 \ \\
A_1 & B_1  & C_1 \ \\
A_2 & B_2  & C_2 \
\end{bmatrix}
$$


#### `MPI_Reduce`

```cpp
int MPI_Reduce(const void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype,
               MPI_Op op, int root, MPI_Comm comm);
```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
B_0 & B_1 & B_2 \\
C_0 & C_1 & C_2
\end{bmatrix}
\overset{Reduce}{\rightarrow}
\begin{bmatrix}
A_0 + B_0 + C_0 & A_1 + B_1 + C_1  & A_2 + B_2 + C_2 \\
 \  & \    & \     \\
 \  & \    & \
\end{bmatrix}
$$

#### `MPI_allreduce`

```cpp
int MPI_Allreduce(const void *sendbuf, void *recvbuf, int count,
                  MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
B_0 & B_1 & B_2 \\
C_0 & C_1 & C_2
\end{bmatrix}
\overset{Allreduce}{\rightarrow}
\begin{bmatrix}
A_0 + B_0 + C_0 & A_1 + B_1 + C_1  & A_2 + B_2 + C_2 \\
A_0 + B_0 + C_0 & A_1 + B_1 + C_1  & A_2 + B_2 + C_2 \\
A_0 + B_0 + C_0 & A_1 + B_1 + C_1  & A_2 + B_2 + C_2
\end{bmatrix}
$$

#### `MPI_Reduce_scatter`

```cpp
int MPI_Reduce_scatter(const void *sendbuf, void *recvbuf, const int recvcounts[],
                       MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
B_0 & B_1 & B_2 \\
C_0 & C_1 & C_2
\end{bmatrix}
\overset{Reduce-scatter}{\rightarrow}
\begin{bmatrix}
A_0 + B_0 + C_0  & \ & \ \\
A_1 + B_1 + C_1  & \ & \ \\
A_2 + B_2 + C_2  & \ & \
\end{bmatrix}
$$

#### `MPI_Scan`

```cpp
int MPI_Scan(const void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype,
             MPI_Op op, MPI_Comm comm);
```

$$
\begin{bmatrix}
A_0 & A_1 & A_2 \\
B_0 & B_1 & B_2 \\
C_0 & C_1 & C_2
\end{bmatrix}
\overset{Scan}{\rightarrow}
\begin{bmatrix}
A_0 & A_1 & A_2 \\
A_0 + B_0 & A_1 + B_1 & A_2 + B_2 \\
A_0 + B_0 + C_0 & A_1 + B_1 + C_1 & A_2 + B_2 + C_2
\end{bmatrix}
$$

