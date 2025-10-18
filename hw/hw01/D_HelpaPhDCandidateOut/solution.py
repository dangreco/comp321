N = int(input())
for _ in range(N):
    l = input()
    if "+" in l:
        A, B = map(int, l.split("+"))
        print(A + B)
    else:
        print("skipped")
