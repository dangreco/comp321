def main():
    pass


if __name__ == "__main__":
    main()

    def solve(A: int, B: int) -> tuple[int, int, int]:
        if A == B:
            return (0, 0, A)

        a = A
        seq: list[int] = []
        while a != 1:
            if a % 2 == 0:
                a //= 2
            else:
                a = 3 * a + 1
            seq.append(a)

        b = B
        j = 0
        while 1:
            for i, a in enumerate(seq):
                if a == b:
                    return (i + 1, j, a)
            if b % 2 == 0:
                b //= 2
            else:
                b = 3 * b + 1
            j += 1

        return (0, 0, 0)

    while 1:
        A, B = map(int, input().split())
        if A == 0 and B == 0:
            break

        (sa, sb, x) = solve(A, B)
        print(f"{A} needs {sa} steps, {B} needs {sb} steps, they meet at {x}")
