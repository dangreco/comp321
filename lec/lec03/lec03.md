# Lec 03

## Binary Search Tree (BST)

- Idea: each node has at most two children
- Binary tree w/ the following property:
  - Value `v` >= values in `v`'s left subtree
  - Value `v` < values in `v`'s right subtree
- Can solve many different problems with BSTs

- Three operations:
  1. Insert(x) - insert a node in `O(h)` time
  2. Delete(x) - delete a node in `O(h)` time
  3. Search(x) - search for a node in `O(h)` time

- Extensions:
  - Count(x) - count occurrences of `x` in `O(h)` time
  - GetNext(x) - get the next larger value than `x` in `O(h)` time
  - Find the k-th smallest value in `O(h)` time

- Problem: unbalanced trees could be linear

## Augmented BST - Example

- kth smallest element
  - `O(n^2)` => bubblesort, index into array
  - `O(n log n)` => quicksort, index into array
  - `O(n)` =>

## Hash Tables

- Efficient
- Kattis problem types:
  - Compute hash function itself (se deduplicating_files)
  - Check for data integrity
