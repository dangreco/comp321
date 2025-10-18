#include <stdint.h>
#include <stdio.h>

#define MAX_N 1000
#define abs(a) ((a) < 0 ? -(a) : (a))

int main() {
  int N, M, t = 0, x, ans, cur;
  uint64_t num[MAX_N];

  while (scanf("%d", &N)) {
    printf("Case %d:\n", t++);

    for (int i = 0; i < N; i++)
      scanf("%lu", &num[i]);

    scanf("%d", &M);

    for (int i = 0; i < M; i++) {
      scanf("%d", &x);
      ans = num[0] + num[1];
      cur = 0;

      for (int j = 0; j < N; j++) {
        for (int k = j + 1; k < N; k++) {
          cur = num[j] + num[k];
          if ((abs(ans - x) > abs(cur - x)))
            ans = cur;
        }
      }

      printf("Closest sum to %d is %d.", x, ans);
    }
  }
}
