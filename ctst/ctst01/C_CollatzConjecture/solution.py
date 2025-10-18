def collatz(x: int):
    while True:
        yield x
        if x == 1:
            break
        x = x // 2 if x % 2 == 0 else 3 * x + 1


while True:
    A, B = map(int, input().split())
    if A == 0 and B == 0:
        break

    ca = list(collatz(A))
    cb = list(collatz(B))

    for ib, b in enumerate(cb):
        if b in ca:
            ia = ca.index(b)
            print(f"{A} needs {ia} steps, {B} needs {ib} steps, they meet at {b}")
            break
