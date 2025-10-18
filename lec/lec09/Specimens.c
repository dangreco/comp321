#include <stdio.h>
#include <stdlib.h>

#define MAX_C 5
#define MAX_S 10

int cmp(const void *a, const void *b) { return (*(int *)a - *(int *)b); }

int main() {
  int c, s;
  int mass[MAX_S];
  double a = 0;

  scanf("%d %d", &c, &s);
  for (int i = 0; i < s; i++) {
    scanf("%d", &mass[i]);
    a += mass[i];
  }

  // calculate average mass
  a /= (double)c;

  // sort by increasing mass
  qsort(mass, s, sizeof(int), cmp);

  // calculate imbalance
  double imbalance = 0.0;
  int r = s - 1;
  int l = -(2 * c - s);

  while (l < r) {
    int wl = l >= 0 ? mass[l] : 0;
    int wr = mass[r];
    double tmp = (wl + wr) - a;

    if (tmp < 0) {
      imbalance -= tmp;
    } else {
      imbalance += tmp;
    }

    l++;
    r--;
  }

  printf("IMBALANCE = %.5f\n", imbalance);
}
