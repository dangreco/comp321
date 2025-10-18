{-
Kattis – A Different Problem

Given pairs of non-negative integers, compute the absolute difference between them.
Each pair is provided on a separate line, and the input ends at end-of-file.

Input:

\* Multiple lines, each containing two integers a and b (0 ≤ a, b ≤ 10^15).
\* Input terminates with EOF.

Output:

\* For each line, output |a − b| on its own line.

Example:
Input
10 12
71293781758123 72784
1 12345677654321
Output
2
71293781685339
12345677654320
-}

main :: IO ()
main =
  interact $
    unlines
      . map (show . uncurry diff . toPair . words)
      . takeWhile (not . isZeroPair . words)
      . lines
  where
    toPair [a, b] = (read a :: Integer, read b :: Integer)
    diff a b = abs (a - b)
    isZeroPair [a, b] = a == "0" && b == "0"
    isZeroPair _ = False
