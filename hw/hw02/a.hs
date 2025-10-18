{-
Numbers On a Tree

Description:
Given a perfect binary tree with numbered nodes, find the label of a specific
node by following a path described by 'L' (left) and 'R' (right) moves from
the root. The tree has height H with nodes numbered from 1 at the top level
to 2^H at the bottom level, following a specific labeling scheme where each
node has two children except the bottom layer nodes.

Input Format:
- First line: height H of the tree (1 ≤ H ≤ 30)
- Second line: string of 'L' and 'R' characters describing path from root
- Path length may be empty or at most H letters
- 'L' means go to left child, 'R' means go to right child

Output Format:
Single line containing the label of the node reached by following the given path.

Example:
Input:
3
LR

Output:
6

Constraints:
- Tree height: 1 ≤ H ≤ 30
- Path consists only of 'L' and 'R' characters
- Path length ≤ H (cannot go deeper than tree height)
- Tree is a perfect binary tree

Notes:
- This is a binary tree traversal problem with specific node numbering
- Root node is labeled 1
- For any node with label n: left child = 2*n, right child = 2*n+1
- Can solve iteratively by following the path and updating node number
- Alternative: calculate final position mathematically using path binary value
-}

main :: IO ()
main = do
  line <- getLine
  case words line of
    [h] -> print $ solve (read h) []
    [h, path] -> print $ solve (read h) path
    _ -> return ()

solve :: Int -> String -> Int
solve h [] = 2 ^ (h + 1) - 1
solve h path =
  2 ^ (h + 1) - 2 ^ n - p
  where
    n = length path
    p = foldl (\acc c -> acc * 2 + (if c == 'R' then 1 else 0)) 0 path
