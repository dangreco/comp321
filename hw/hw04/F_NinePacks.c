#include <stdio.h>

#define min(a, b) ((a) < (b) ? (a) : (b))

int main() {
  int H, B;
  int ans = 8000;
  int dogs[1000];
  int buns[1000];

  int dph[100001] = {4000};
  int dpb[100001] = {4000};

  int sumd = 0;
  scanf("%d", &H);
  for (int i = 0; i < H; i++) {
    scanf("%d", &dogs[i]);
    sumd += dogs[i];
    for (int j = sumd; j >= dogs[i]; j--) {
      dph[j] = min(dph[j], dph[j - dogs[i]] + 1);
    }
  }

  int sumb = 0;
  scanf("%d", &B);
  for (int i = 0; i < B; i++) {
    scanf("%d", &buns[i]);
    sumb += buns[i];
    for (int j = sumb; j >= buns[i]; j--) {
      dpb[j] = min(dpb[j], dpb[j - buns[i]] + 1);
      ans = min(ans, dph[j] + dpb[j]);
    }
  }

  if (ans >= 4000) {
    printf("impossible\n");
  } else {
    printf("%d\n", ans);
  }
}
