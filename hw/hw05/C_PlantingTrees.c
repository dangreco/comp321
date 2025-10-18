#include <stdio.h>
#include <stdlib.h>

#define MAX_N 100000
#define max(a, b) ((a) > (b) ? (a) : (b))
#define min(a, b) ((a) < (b) ? (a) : (b))

int cmp(const void *a, const void *b) {
  long la = *(long *)a;
  long lb = *(long *)b;
  if (la < lb)
    return 1;
  else if (la > lb)
    return -1;
  else
    return 0;
}

int main() {
  int n;
  long trees[MAX_N];

  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%ld", &trees[i]);

  // sort in descending order
  qsort(trees, n, sizeof(long), cmp);

  int e = 0;
  for (int i = 0; i < n; i++) {
    e = max(e, trees[i] + i + 1);
  }

  printf("%d\n", e + 1);
}
