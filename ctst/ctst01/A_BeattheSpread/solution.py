N = int(input())

for _ in range(N):
    s, d = map(int, input().split())
    x = (s + d) // 2
    y = s - x
    if (s + d) % 2 != 0 or x < 0 or y < 0:
        print("impossible")
    else:
        print(max(x, y), min(x, y))
