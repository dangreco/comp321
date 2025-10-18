#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_N 100000

typedef struct {
  int cash;
  int time;
} customer_t;

int cmp(const void *a, const void *b) {
  customer_t *ca = (customer_t *)a;
  customer_t *cb = (customer_t *)b;
  return cb->cash - ca->cash; // descending order of cash
}

int main() {
  int n, t;
  customer_t customers[MAX_N];
  bool used[MAX_N + 1] = {false};

  scanf("%d %d", &n, &t);
  for (int i = 0; i < n; i++) {
    scanf("%d %d", &customers[i].cash, &customers[i].time);
  }

  qsort(customers, n, sizeof(customer_t), cmp);

  long long sum = 0;
  for (int i = 0; i < n; i++) {
    int latest = (customers[i].time < t) ? customers[i].time : t - 1;

    for (int slot = latest; slot >= 0; slot--) {
      if (!used[slot]) {
        used[slot] = true;
        sum += customers[i].cash;
        break;
      }
    }
  }

  printf("%lld\n", sum);
}
