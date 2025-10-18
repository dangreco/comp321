#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) { return (a < b) ? a : b; }

int main(void) {
  int s, p, m, n;
  scanf("%d %d %d %d", &s, &p, &m, &n);

  int *dp = (int *)calloc(n, sizeof(int));
  int *ts = (int *)calloc(n, sizeof(int));

  for (int i = 0; i < n; i++) {
    scanf("%d", &ts[i]);
  }

  dp[0] = min(s, p);

  for (int i = 1; i < n; i++) {
    int cs = dp[i - 1] + s;

    int j = i - 1;
    while (j >= 0 && ts[i] - ts[j] < m) {
      j--;
    }

    int cp = (j < 0) ? p : dp[j] + p;

    dp[i] = min(cs, cp);
  }

  printf("%d\n", dp[n - 1]);

  free(ts);
  free(dp);
  return 0;
}
