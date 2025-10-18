#include <stdio.h>

#define MAX_K 205
#define INF -1

int max(int a, int b) { return (a > b) ? a : b; }

int main() {
  int N, k;

  while (scanf("%d %d", &N, &k) == 2 && (N != 0 || k != 0)) {
    int values[2];
    int prev[MAX_K][3], curr[MAX_K][3];

    for (int j = 0; j <= k; j++) {
      for (int s = 0; s < 3; s++) {
        prev[j][s] = INF;
        curr[j][s] = INF;
      }
    }

    scanf("%d %d", &values[0], &values[1]);
    prev[0][0] = values[0] + values[1];
    if (k >= 1) {
      prev[1][1] = values[0];
      prev[1][2] = values[1];
    }

    for (int i = 1; i < N; i++) {
      scanf("%d %d", &values[0], &values[1]);

      for (int j = 0; j <= k; j++) {
        for (int s = 0; s < 3; s++) {
          curr[j][s] = INF;
        }
      }

      for (int closed = 0; closed <= k; closed++) {
        for (int prev_state = 0; prev_state < 3; prev_state++) {
          if (prev[closed][prev_state] == INF)
            continue;

          int base_val = prev[closed][prev_state];

          curr[closed][0] =
              max(curr[closed][0], base_val + values[0] + values[1]);

          if (closed + 1 <= k && prev_state != 2) {
            curr[closed + 1][1] =
                max(curr[closed + 1][1], base_val + values[0]);
          }

          if (closed + 1 <= k && prev_state != 1) {
            curr[closed + 1][2] =
                max(curr[closed + 1][2], base_val + values[1]);
          }
        }
      }

      for (int j = 0; j <= k; j++) {
        for (int s = 0; s < 3; s++) {
          prev[j][s] = curr[j][s];
        }
      }
    }

    int answer = 0;
    for (int state = 0; state < 3; state++) {
      if (prev[k][state] != INF) {
        answer = max(answer, prev[k][state]);
      }
    }

    printf("%d\n", answer);
  }

  return 0;
}
