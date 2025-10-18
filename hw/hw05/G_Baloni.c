#include <limits.h>
#include <stdio.h>

#define MAX_N 1000000

int main() {
  int N, h;
  int H[MAX_N] = {0};

  scanf("%d", &N);
  while (N--) {
    scanf("%d", &h);
    if (H[h] > 0) {
      --H[h];
    }
    ++H[h - 1];
  }

  int sum = 0;
  for (int i = 0; i < MAX_N; i++)
    sum += H[i];

  printf("%d\n", sum);
}
