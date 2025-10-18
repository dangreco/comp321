n = int(input())

for _ in range(n):
    s, d = map(int, input().split())
    x = (s + d) // 2
    y = s - x

    if x < 0 or y < 0:
        print("impossible")
    else:
        print(f"{max(x, y)} {min(x, y)}")
