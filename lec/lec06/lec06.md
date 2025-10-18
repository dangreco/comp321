# Lec 06

## Dynamic Programming Pt. 1

- Breaks problem into smaller, overlapping subproblems
- Avoids the recomputation of solutions to subproblems

### Fibonacci Numbers

- `fib(n) = fib(n-1) + fib(n-2)`
- `fib(1) = 1`
- `fib(0) = 0`

#### Naive

```hs
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
```

- Call stack:

```plain
fib(5)
  fib(4)
    fib (3)
      fib (2)
        fib (1)
        fib (0)
      fib (1)
    fib (2)
      fib (1)
      fib (0)
  fib(3)
    fib (2)
      fib (1)
      fib (0)
    fib (1)
```

- Lots of repeated calls
- Exponential time complexity: O(2^n)

#### Memoization

```hs
import Control.Monad.State
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)

fib :: Int -> Int
fib n = evalState (fib' n) Map.empty
  where
    fib' 0 = return 0
    fib' 1 = return 1
    fib' n = do
      memo <- get
      case Map.lookup n memo of
        Just v -> return v
        Nothing -> do
          a <- fib' (n - 1)
          b <- fib' (n - 2)
          let v = a + b
          modify (Map.insert n v)
          return v
```

- Now, the call stack:

```plain
fib(5)
  fib(4)
    fib(3)
      fib(2)
        fib(1) -> 1
        fib(0) -> 0
      fib(2) -> 1 [insert]
    fib(3) -> 2 [insert]
  fib(4) -> 3 [insert]
  fib(3) -> 2 [lookup]
fib(5) -> 5 [insert]
```

#### When to use DP?

Need to guarantee two things:

1. Optimal substructures
2. Overlapping subproblems

#### Solving DP

1. Define subproblems
   - e.g. `fib(n-1)`, `fib(n-2)`
2. Write down the recurrence relation
   - e.g. `fib(n) = fib(n-1) + fib(n-2)`
3. Recognize and solve the base cases
   - e.g. `fib(0) = 0`, `fib(1) = 1`
4. Implement a solving methodology:
   - Memoization (top-down)
   - Tabulation (bottom-up)

## Ex. Weighted Interval Scheduling

- Input: set `S` of `n` jobs, `a_1, a_2, ..., a_n`
  - Each job `a_i` has:
    - start time `s_i`
    - finish time `f_i`
    - weight `w_i`
  - Assume jobs are sorted by finish time: `f_1 <= f_2 <= ... <= f_n`
- Output: find maximum weight subset of mutually compatible jobs
  - 2 jobs `a_i` and `a_j` are compatible if they do not overlap:
    - `s_i >= f_j` or `s_j >= f_i`
- `p(i) :=` largest index `i < j` such taht job `i` is compatible with job `j`.
  - I.e. what is the last job that finishes before job `j` starts?

### Step 1: Define subproblems

Let `OPT(j)` be the maximum total weight of compatible jobs 1..`j` (i.e. the
value of the optimal solution to the problem including activities 1 to `j`)

### Step 2: Recurrence relation

#### Case 1: `OPT` selects `j`

- Add weight `w_j`
- Cannot use incompatible jobs
- Must include optimal solution on remaining compatible jobs (1, 2, ..., `p(j)`)

#### Case 2: `OPT` does not select `j`

- Must include optimal solution on jobs (1, 2, ..., `j-1`)

#### Recurrence relation

```plain
opt 0 = 0
opt j = max( w_j + opt(p(j)), opt(j-1) ) for j >= 1
```

```hs
data Job = Job { start :: Int, finish :: Int, weight :: Int } deriving (Show)

opt :: Array Int Job -> Int
opt jobs = evalState (opt' (n - 1)) Map.empty
    where
        n = length jobs
        p j = fromMaybe 0 $ findIndex (\i -> finish (jobs ! i) <= start (jobs ! j)) [j-1, j-2 .. 0]

        opt' 0 = return 0
        opt' j = do
            memo <- get
            case Map.lookup j memo of
                Just v -> return v
                Nothing -> do
                    let Job _ _ wj = jobs ! j
                    a <- opt' (p j)
                    b <- opt' (j - 1)
                    let v = max (wj + a) b
                    modify (Map.insert j v)
                    return v
```

## Ex. 2

- Input: Given `n`, find the number of different ways to write `n` as the sum of
  numbers 1, 3, 4
- E.g. `n = 5`:
  - 1 + 1 + 3
  - 1 + 3 + 1
  - 3 + 1 + 1
  - 1 + 4
  - 4 + 1
  - 1 + 1 + 1 + 1 + 1
  - => 6 ways

### Step 1: Define subproblems

- Let `D_(n-i)` be the number of ways to write `n-i` as the sum of 1, 3, 4

### Step 2: Recurrence relation

- Consider one possible solution `n = x_1 + x_2 + ... + x_m`
- If `x_m = 1`, then the rest of the terms must sum to `n-1`.
  Thus, the number of sums that end with `x_m = 1` is equal to `D_(n-1)`.
- `D_n = D_(n-1) + D_(n-3) + D_(n-4)`
- `D_0 = 1` (base case, one way to sum to zero: the empty sum)

```hs
ways :: Int -> Int
ways 0 = 1
ways k | k < 0 = 0
ways k = ways (k - 1) + ways (k - 3) + ways (k - 4)
```

## Ex. Coin Change

- Input: coin denominations `1, 5, 10, 25`, amount `A`
- Output: minimum number of ways one make change for `A` (order matters)

- Memoization:
  - Time:
  - Space:
- Iteration:
  - Time:
  - Space:

### Memoization

- For every coin you have, make a decision
  1. Include current coin (i.e. `count(coins, n, sum - coins[n-1])`)
  2. Exclude current coin (i.e. `count(coins, n-1, sum)`)
- Relation: sum both decisions

```hs
count :: [Int] -> Int -> Int
count [] _ = 0
count _ 0 = 1
count coins@(c:cs) sum
    | sum < 0 = 0
    | otherwise = count coins sum - c + count cs sum
```
