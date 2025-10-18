# Lec 05

## Complete Search + D&C

### Chess

- Standard 8x8 board in chess
- Is it possible to place eight queens on the board such that no two queens
  can take each other
- Write a program that will determine all such possible arrangements given the
  initial position of the queens
- Size of the search space is up to you
- 64 cells in the grid
  - Sol 1: E.g. create vector of size 64 to represent the board
    - 0 = empty cell
    - 1 = queen
    - Total size is 2^64 ~ 1.8e19
  - Sol 2: Maybe we can design the search space a bit better
    - Model vector of size 8
    - Each index represents a row
    - Each value represents the column of the queen in that row
    - Total size is 64^8 ~ 1.8e14
  - Sol 3: Can we do even better?
    - Prune solution 2 by removing symmetries
    - Ensure that the queen in `a_i` is sits on a higher number square than `a_{i-1}`
    - How many ways can you choose k things from a set of n items?
    - This will reduce search space to `(64 choose 8) = 4.4e9`
    - Includes lots of set ups with multiple queens in the same column
  - Sol 4:
    - 8^8 = 1.7e7
  - Sol 5:
    - No two queens can share row/coumn
    - We know that the n columns of a complete solution must form a permutation
      of `n`.
    - We reduce seach space to `8! = 40320`
  - Sol X;
    - We know that there are 12 uniqiue solutions, generate them all by
      reflecting and rotating, get to 92 solutions

- Sol 4 w/ recursive backtracking:

## Divide In Conquer

- Divide the problem into smaller subproblems
- Solve the subproblems recursively

### Merge Sort
