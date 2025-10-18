# Lec 09

## Complete Search + Dynamic Programming + Greedy

### Ex. 5 - Specimens

Given `1 <= c <= 5` chambers which can store, 0, 1, or, 2 specimens,
`1 <= s <= 2c` specimens, and `M` a list of mass of `S` specimens.
Determine in which chamber we should store each specimens in order to
minimize:

```plain
IMBALANCE = sum_{i=1}^{c} | X_i - A |
```

i.e. the sum of differences between the mass in each chamber w.r.t. A,
where X_i is the total mass of specimens in chamber

```plain
A = (sum_{j=1}^{S} M_j) / c
```

A is the average of all mass over `c` chambers.

### Ex. 6 - Barn Repair

`S` stalls in a row, `C` of wwhich have cows in them so you would have
to cover them up. The location of the `C` stalls are given.
You have `M` boards that can each cover any number of consecutive stalls.
Find a way to block the stalls with cows such that the total number of blocked
stalls is minimum.

- `M = 1` -> block from the first to the last cow
- `M >= C` -> block each cow individually
- `M = 2` -> greedily split at the largest gap between cows

If we can purchase `M` boards, we can leave unblocked `M - 1` gaps.
We input the list of cows in the stalls, storing into an array
whether or not there is a call in a stall.

Then we waalk the array counting the sizes of runs.
We sort the list of sizes and pick the `M - 1` largest ones
as stalls that will remain uncovered.

### Ex. 7 - Shopaholic

[Shopaholic](https://open.kattis.com/problems/shopaholic)

There is a discount where you can buy three items but only pay for two,
getting the cheapest one for free.

You want to buy `n` items that respectively cost `p_1, p_2, ..., p_n`,
with the maximal discount.

### Ex. 8 - Boss Battle

[Boss Battle](https://open.kattis.com/problems/bossbattle)

- Boss battle in circular room
- `n` indestructible pillars arranged evenly
- Boss hides behind unknown pillar
- Alternating turns:
  - You can throw a bomb past a pillar - killing if boss behind it or adjacent
  - Boss can either stay where it is or move to adjacent pillar
    - Cannot see movement
- Want to gather enough bombs
- What is minimum number of bombs?

- `1 <= n <= 100`
- Ex: `n = 4` -> 2
- Ex: `n = 7` -> 5

```plain
-------      7
XXX---- 1    4
-X-----      6
-XXXX-- 2    3
--XX---      5
--XXXXX 3    2
---XXX-      4
XX-XXXX 4    1
X---XXX      3
XXXXXXX 5    0
```

- Idea: increase number of impossible locations each throw

```c
#include <stdio.h>

int main() {
  int n;
  scanf("%d", &n);

  int b = 0;

  while (1) {
    b += 1;
    n -= 3;
    if (n <= 0)
      break;
    n += 2;
  }

  printf("%d\n", b);
}
```

Or:

```hs
main :: IO ()
main = interact $ map (show . f . read) . lines
    where
        f n
            | n < 3 = 1
            | otherwise = n - 2
```
