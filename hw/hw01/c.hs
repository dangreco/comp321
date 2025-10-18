{-
Kattis – Solving for Carrots

Each contestant in a contest writes a self-description, but the only relevant information is the number of problems solved.
You are given the number of contestants and the number of solved problems. The task is to output the number of carrots awarded, which equals the number of solved problems.

Input:

\* First line: two integers n and p, where
  n = number of contestants,
  p = number of problems solved.
\* Next n lines: each contains a self-description (irrelevant to the answer).

Output:

\* A single integer: the number of carrots awarded (equal to p).

Example:
Input
2 1
carrots?
bunnies
Output
1

Input
1 5
sovl problmz
Output
5
-}

skip :: Int -> IO ()
skip 0 = return ()
skip n = do
  _ <- getLine
  skip (n - 1)

main :: IO ()
main = do
  [n, p] <- fmap (map read . words) getLine
  skip n
  print p
