#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_N 10000

typedef struct {
  double l;
  double r;
} interval_t;

// compare intervals by left endpoint
int cmp(const void *a, const void *b) {
  const interval_t *ia = (const interval_t *)a;
  const interval_t *ib = (const interval_t *)b;

  if (ia->l < ib->l)
    return -1;
  if (ia->l > ib->l)
    return 1;
  return 0;
}

// find minimum number of intervals to cover [0, L]
// return -1 if not possible
int min(interval_t *intervals, int len, int L) {
  int i = 0;
  int cnt = 0;
  double l = 0.0;
  double r = 0.0;

  while (l < L) {
    bool found = false;

    // find the interval with the left endpoint <= l and the right endpoint is
    // the largest
    while (i < len && intervals[i].l <= l) {
      r = fmax(r, intervals[i].r);
      i++;
      found = true;
    }

    // if no such interval is found, return -1
    if (!found) {
      return -1;
    }

    cnt++;
    l = r;
  }

  return cnt;
}

int main() {
  int N, L, W;
  interval_t intervals[MAX_N];

  while (scanf("%d %d %d", &N, &L, &W) == 3) {
    int len = 0;
    double hlf = W / 2.0;

    for (int i = 0; i < N; i++) {
      double p, r;
      scanf("%lf %lf", &p, &r);
      if (r >= hlf) { // only consider sprinklers that can cover the width
        // calculate the horizontal distance using Pythagorean theorem
        double hor = sqrt(r * r - hlf * hlf);
        intervals[len].l = p - hor;
        intervals[len].r = p + hor;
        len++;
      }
    }

    qsort(intervals, len, sizeof(interval_t), cmp);
    int cnt = min(intervals, len, L);
    printf("%d\n", cnt);
  }
}
