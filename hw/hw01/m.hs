{-
Kattis – Bus Numbers

A bus stop is served by several bus lines. To shorten the listing, consecutive bus numbers of length ≥ 3 can be represented as a range "a-b".
For example, buses 141, 142, 143 become "141-143". For just two consecutive numbers, they should still be listed separately.

Input:

\* First line: integer n, the number of buses.
\* Second line: n distinct integers (1 ≤ bus number ≤ 1000), the bus lines.

Output:

\* The shortest representation of the list:

  * Sorted in ascending order.
  * Consecutive runs of at least 3 numbers are shown as ranges.
  * Others are written individually.
\* Numbers/ranges are separated by a single space.

Example:
Input
6
180 141 174 143 142 175
Output
141-143 174 175 180
-}

import Data.List (sort)

main :: IO ()
main = do
  n <- readLn :: IO Int
  line <- getLine
  putStrLn $ solve $ sort (map read (words line) :: [Int])

solve :: [Int] -> String
solve [] = ""
solve [x] = show x
solve (x : xs) =
  case run x xs of
    (y, ys)
      | y - x >= 2 -> show x ++ "-" ++ show y ++ " " ++ solve ys
      | otherwise -> show x ++ " " ++ solve xs
  where
    run a [] = (a, [])
    run a (b : bs)
      | b == a + 1 = run b bs
      | otherwise = (a, b : bs)
