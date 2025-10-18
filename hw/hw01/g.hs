{-
Kattis – Plants vs Bad Guys

Mikael’s lawn has several rows, each with a number of peashooters that can defend that row.
During wave k, exactly k bad guys appear on each row. A row is breached if the number of bad guys exceeds the number of peashooters in that row. Mikael is attacked during the first wave k where any row is breached.

Input:

\* First line: integer n, the number of rows.
\* Second line: n integers, where the i-th integer is the number of peashooters on row i.

Output:

\* A single integer: the first wave number k where Mikael is attacked.

Example:
Input
5
3 5 7 9 11
Output
4

Input
5
7 7 7 7 7
Output
8

Input
1
1
Output
2
-}

import Data.ByteString.Char8 qualified as C
import Data.List (foldl1')
import Data.Maybe (fromJust)

main :: IO ()
main = do
  n <- readLn :: IO Int
  line <- C.getLine
  let peashooters = map (fst . fromJust . C.readInt) (C.words line)
  let minPeashooters = foldl1' min peashooters
  print (minPeashooters + 1)
