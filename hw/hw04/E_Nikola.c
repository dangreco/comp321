#include <limits.h>
#include <stdio.h>

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))
#define MAX_N 1000 + 1
#define INF INT_MAX

int n;
int fee[MAX_N];
int dp[MAX_N][MAX_N];

int main() {
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &fee[i]);

  for (int i = 0; i < n; i++)
    for (int j = 0; j <= n; j++)
      dp[i][j] = INF;

  for (int j = 0; j <= n; j++)
    dp[n - 1][j] = 0;

  for (int j = n - 1; j >= 0; j--) {
    for (int i = 0; i < n; i++) {
      if (i == n - 1) {
        dp[i][j] = 0;
        continue;
        ;
      }

      int fw = i + j + 1;
      int bw = i - j;
      int best = INF;

      if (fw >= 0 && fw < n) {
        if (dp[fw][j + 1] < INF) {
          int cfw = fee[fw] + dp[fw][j + 1];
          if (cfw < best)
            best = cfw;
        }
      }
      if (bw >= 0 && bw < n) {
        if (dp[bw][j] < INF) {
          int cbw = fee[bw] + dp[bw][j];
          if (cbw < best)
            best = cbw;
        }
      }

      dp[i][j] = best;
    }
  }
  int ans;
  if (1 >= 0 && 1 < n && dp[1][1] < INF) {
    long long tmp = (long long)fee[1] + dp[1][1];
    ans = (tmp >= INF ? -1 : (int)tmp);
  } else {
    ans = -1;
  }

  printf("%d\n", ans);
}
