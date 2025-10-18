#include <stdio.h>
#include <stdlib.h>

#define MAX_N 1000

int cmp(const void *a, const void *b) {
  long long ia = *(long long *)a;
  long long ib = *(long long *)b;
  if (ia < ib)
    return -1;
  else if (ia > ib)
    return 1;
  else
    return 0;
}

int main() {
  int N, T;
  int A, B, C, t0;

  scanf("%d %d", &N, &T);
  scanf("%d %d %d %d", &A, &B, &C, &t0);

  // initialize times
  long long *times = (long long *)malloc(N * sizeof(long long));
  times[0] = t0;
  for (int i = 1; i < N; i++) {
    times[i] = (A * times[i - 1] + B) % C + 1;
  }

  // sort times in ascending order
  qsort(times, N, sizeof(long long), cmp);

  int solved = 0;
  long long penalty = 0;
  long long elapsed = 0;

  for (int i = 0; i < N; i++) {
    if (elapsed + times[i] <= T) {
      elapsed += times[i];
      penalty += elapsed;
      solved++;
    } else {
      break;
    }
  }

  printf("%d %lld\n", solved, penalty % 1000000007);
}
