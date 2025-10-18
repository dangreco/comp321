n = int(input())
intervals = [tuple(map(int, input().split())) for _ in range(n)]
intervals.sort(key=lambda i: i[1])

cnt = 0
while len(intervals):
    r = intervals[0][1]
    while len(intervals) and intervals[0][0] < r:
        intervals = intervals[1:]
    cnt += 1

print(cnt)
