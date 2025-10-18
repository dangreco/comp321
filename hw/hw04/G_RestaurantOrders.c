#include <stdio.h>

#define MAX_N 100
#define MAX_M 1000
#define MAX_S 30000

int main() {
  int n, m, order;
  int cost[MAX_N];
  int dp[MAX_N][MAX_S];

  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &cost[i]);

  scanf("%d", &m);
  while (m-- > 0) {
    scanf("%d", &order);

    for (int i = 0; i < n; i++)
      for (int j = 0; j <= order; j++)
        dp[i][j] = 0;
  }
}
