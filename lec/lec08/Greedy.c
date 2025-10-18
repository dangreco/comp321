#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int start;
  int end;
} interval_t;

int cmp(const void *a, const void *b) {
  interval_t *ia = (interval_t *)a;
  interval_t *ib = (interval_t *)b;

  if (ia->end != ib->end) {
    return ia->end - ib->end;
  }
  return ia->start - ib->start;
}

int main() {
  int t, n;
  scanf("%d", &t);

  while (t-- > 0) {
    scanf("%d", &n);

    interval_t *intervals = (interval_t *)malloc(n * sizeof(interval_t));
    for (int i = 0; i < n; i++) {
      scanf("%d %d", &intervals[i].start, &intervals[i].end);
    }

    qsort(intervals, n, sizeof(interval_t), cmp);

    int cnt = 1;
    int end = intervals[0].end;

    for (int i = 0; i < n; i++) {
      if (intervals[i].start >= end) {
        end = intervals[i].end;
        cnt++;
      }
    }

    printf("%d\n", cnt);
    free(intervals);
  }
}
