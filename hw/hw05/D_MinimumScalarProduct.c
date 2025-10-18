#include <stdio.h>
#include <stdlib.h>

#define MAX_N 800

int asc(const void *a, const void *b) {
  int ia = *(int *)a;
  int ib = *(int *)b;
  return ia - ib;
}

int dsc(const void *a, const void *b) {
  int ia = *(int *)a;
  int ib = *(int *)b;
  return ib - ia;
}

int main() {
  int t, n, c = 1;
  int v1[MAX_N], v2[MAX_N];

  scanf("%d", &t);
  while (t-- > 0) {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
      scanf("%d", &v1[i]);
    for (int i = 0; i < n; i++)
      scanf("%d", &v2[i]);

    qsort(v1, n, sizeof(int), asc);
    qsort(v2, n, sizeof(int), dsc);

    long long sum = 0;
    for (int i = 0; i < n; i++)
      sum += (long long)v1[i] * v2[i];
    printf("Case #%d: %lld\n", c, sum);
    c++;
  }
}
