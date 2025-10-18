import heapq
from collections import defaultdict

N, K = map(int, input().split())
A = list(map(int, input().split()))

occ = defaultdict(int)
for num in A:
    occ[num] += 1

heap = [-x for x in occ.values()]
heapq.heapify(heap)

for _ in range(K):
    heapq.heapreplace(heap, heap[0] + 1)

print(-heap[0])
