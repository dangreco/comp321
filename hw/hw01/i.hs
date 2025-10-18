{-
Kattis – Erase Securely

A file is erased by overwriting it bit by bit. Each overwrite (sweep) flips every bit:
0 → 1 and 1 → 0. After n sweeps, the file should match the expected pattern:

\* If n is even, the file remains the same.
\* If n is odd, the file is the bitwise inverse.

You must verify whether the file after deletion matches this expected result.

Input:

\* First line: integer n, the number of sweeps (0 ≤ n ≤ 100).
\* Second line: string of 0/1 representing the file before deletion.
\* Third line: string of 0/1 representing the file after deletion.
\* Both strings are of equal length (1–100 characters).

Output:

\* Print "Deletion succeeded" if the result matches the expected bits.
\* Otherwise, print "Deletion failed".

Example:
Input
1
10001110101000001111010100001110
01110001010111110000101011110001
Output
Deletion succeeded

Input
20
0001100011001010
0001000011000100
Output
Deletion failed
-}

main :: IO ()
main = do
  n <- readLn :: IO Integer
  xs <- getLine
  ys <- getLine
  let pred = if even n then (==) else (/=)
  putStrLn $
    if all (uncurry pred) (zip xs ys)
      then "Deletion succeeded"
      else "Deletion failed"
