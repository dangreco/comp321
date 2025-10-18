#include <stdbool.h>
#include <stdio.h>

int main(void) {
  int n, m;
  int s[10];
  bool dp[1000001];

  while (scanf("%d %d", &n, &m) == 2) {
    for (int i = 0; i < m; i++)
      scanf("%d", &s[i]);

    dp[0] = false;
    for (int i = 1; i <= n; i++) {
      dp[i] = false;
      for (int j = 0; j < m; j++) {
        if (i >= s[j] && !dp[i - s[j]]) {
          dp[i] = true;
          break;
        }
      }
    }

    if (dp[n])
      printf("Stan wins\n");
    else
      printf("Ollie wins\n");
  }

  return 0;
}
