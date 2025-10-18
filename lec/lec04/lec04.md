# Lec 04

## Data Strucutres

### Range Queries

- Problem: Given an array of values, perform the following two operations:
  1. `sum(i,j)` - add all values between indices `i` and `j`
  2. `update(i,v)` - update the value at index `i` to `v`

- Example:
  - `arr = [1, 6, 3, 3, 5, 2, 11, 0]`
  - `sum(1,7) = 6 + 3 + 3 + 5 + 2 + 11 + 0 = 30`
  - `update(4,7) -> arr = [1, 6, 3, 3, 7, 2, 11, 0]`
  - `sum(4,5) = 7 + 2 = 9`
  - `sum(5,5) = 2`

- Brute force:
  - `sum(i,j)` - O(n)
  - `update(i,v)` - O(1)

- Storing running sums:
  - `sum_arr[i]` = sum of `arr[0]` to `arr[i]`
  - `sum(i,j) = sum_arr[j] - sum_arr[i-1]`
  - `sum(i,j)` - O(1)
  - `update(i,v)` - O(n) (need to update all sums from `i` to end)
  - `update(i,v)` - O(n)

- Segment Tree:
  - Binary tree
  - Each node is associated with some interval of the array
  - Non-leaf nodes have two children whose intervals are disjoint
  - Child's intervals are approximately half the size of the parent's interval
  - Each node stores the sum of its interval
  - Sum operations require query for correct partial sum - O(log n)
  - Query operations require updating all partial sums that include the updated
    index - O(log n)

- Fenwick Tree:
  - Similar in concept to segment tree
  - Array used to represent tree
  - Observation: conversion between bases 10 -> 2
    - All numbers in base 10 can be represented by sums of powers of 2
    - 12 = 8 + 4 = 2^3 + 2^2
  - Binary indexed tree - BIT
    - Distribute partial sums based on the powers of 2 in an elements index

## Algorithmic Paradigms

- Complete search
  - Iterative
  - Recursive (backtracking)
- Divide and conquer
- Dynamic programming
  - 1D
  - 2D
  - Interval
  - Tree
  - Subset
- Greedy

### Example

- Given `A = { 10, 7, 3, 5, 8, 2, 9 }`
  - Find largest + smallest element of A => how : iterative complete search
    `O(n)`
  - Kind kth smallest element of A => how : divide and conquer (decrease and conquer)
    `O(n)`
  - Find largest gap `g` such that `x, y in A` and `g = |x - y|` => how : greedy
    smallest/largest
    `O(n)`
  - Find the longest increasing subsequence of A => how : dynamic programming

```hs
largest :: (Ord a) => [a] -> a
largest [] = error "empty list"
largest [x] = x
largest (x:xs) = max x (largest xs)

smallest :: (Ord a) => [a] -> a
smallest [] = error "empty list"
smallest [x] = x
smallest (x:xs) = min x (smallest xs)

smallestLargest :: (Ord a) => [a] -> (a, a)
smallestLargest [] = error "empty list"
smallestLargest [x] = (x, x)
smallestLargest (x:xs) = (min x s, max x l)
    where (s, l) = smallestLargest xs

largestGap :: (Ord a, Num a) => [a] -> a
largestGap xs = largest xs - smallest xs
```
