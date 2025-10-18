# Lec 06

## Dynamic Programming Pt. 2

### Ex. 3

- Problem: Given `n`, find the number of ways to fill in a 3 x `n` board with `1x2`
  dominose.

- Issue: `D_n` does not relate in simple terms -- can have overlapping tiles.
- What if we introduce more subproblems?
  - Consider different ways to fill in the `n`th column and see what the
    remaining shape is.
  - Can end with different shapes:
    - D. XXX
    - A. -XX (XX-)
    - B. X-X
    - C. --X (X--)
    - E. -X-
  - In `n`, if `n-1` is in state `A`, then we can have a proper tiling.
  - Now define:
    `D_n = D_(n-2) + A_(n-1) + A_(n-1)`
  - Now:
    - Let `D_(n-i)` be the number of ways to tile a `3 x (n-i)` board and
    - Let `A_(n-i)` be the number of ways to tile a `3 x (n-i)` board that ends in
      state `A`.
    - `D_n = D_(n-2) + 2 * A_(n-1)`
  - Now:
    - `A_n = D_(n-1) + A_(n-2)`
  - So we have:
    - `D_n = D_(n-2) + 2 * A_(n-1)`
    - `A_n = D_(n-1) + A_(n-2)`

### Knapsack

- Given `n` objects and a "knapsack"
- Item `i` weights `w_i > 0` and value `v_i > 0
- Knapsack can hold weight `W`
- Goal: fill knapsack with items to maximize value

- Let `OPT(i)` be the maximum total values of items `1, 2, ..., i`.
- Cases:
  1. `OPT(i)` does not select item `i`
     - Must include optimal solution on others `1, 2, ..., i-1`
  2. `OPT(i)` selects item `i`
     - Add weight `w_i`
     - Cannot use incompatible items
     - Must include optimal solution on remaining compatible items `1, 2, ..., p(j)`

Recurrence relation:

```hs
opt 0 _ = 0
opt i w
  | weight i > w = opt (i-1) w
  | otherwise = max ( opt (i-1) w ) ( value i + opt (i-1) (w - weight i) )
```

Iterative:

```plain
FOR w = 0 TO W
  M[0,w] <- 0

FOR i = 1 TO n
  FOR w = 1 TO W
    IF (w_i > w) M[i,w] <- M[i-1,w]
    ELSE M[i,w] <- max { M[i-1,w], v_i + M[i-1,w-w_i] }

RETURN M[n,W]
```
