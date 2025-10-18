N = int(input())
I = [tuple(map(int, input().split())) for _ in range(N)]
I.sort(key=lambda x: x[1])  # sort by finish time

cnt = 0
end = -1
for s, f in I:
    if s >= end:
        cnt += 1
        end = f

print(cnt)
