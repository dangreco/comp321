#include <stdio.h>
#include <stdlib.h>

#define MAX_N 200000

int cmp(const void *a, const void *b) { return (*(int *)a - *(int *)b); }

int main() {
  int n;
  int price[MAX_N];

  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &price[i]);

  qsort(price, n, sizeof(int), cmp);

  long long discount = 0;
  for (int i = n - 3; i >= 0; i -= 3)
    discount += price[i];

  printf("%lld\n", discount);
}
