{-
CD

Description:
Jack and Jill have decided to sell some of their Compact Discs while keeping
some. They have decided to sell one of each CD title they both own, and keep
the rest. Determine how many CDs Jack and Jill will both own after the sale.

Input Format:
- Multiple test cases until input contains "0 0"
- Each test case starts with two positive integers N and M
 - N = number of CDs Jack owns
 - M = number of CDs Jill owns
- Next N lines contain catalog numbers of CDs owned by Jack (increasing order)
- Next M lines contain catalog numbers of CDs owned by Jill (increasing order)
- Each catalog number is a positive integer no greater than one billion
- Input terminates when a test case contains "0 0"

Output Format:
For each test case, output one integer: the number of CDs that Jack and Jill
both own (intersection of their collections).

Example:
Input:
3 3
1
2
3
1
2
4
0 0

Output:
2

Constraints:
- 1 ≤ N, M ≤ 1,000,000 (number of CDs each person owns)
- Catalog numbers ≤ 1,000,000,000
- CD catalogs are given in strictly increasing order
- Input terminates with "0 0"
- Multiple test cases per input

Notes:
- This is a set intersection problem
- Since both lists are sorted, can use two-pointer technique for O(N+M) solution
- Alternative: use hash set for one list, iterate through other
- Count common elements between Jack's and Jill's CD collections
- Do not store or output the actual common CDs, just count them
-}

import Data.ByteString.Lazy.Char8 qualified as C
import Data.Maybe (fromJust)

main :: IO ()
main = C.interact $ C.unlines . map (C.pack . show . uncurry solve) . parse . C.lines
  where
    parse :: [C.ByteString] -> [([Int], [Int])]
    parse [] = []
    parse (x : xs)
      | x == C.pack "0 0" = []
      | otherwise =
          let [n, m] = map (fst . fromJust . C.readInt) (C.words x)
              (jkl, rest) = splitAt n xs
              (jll, rest') = splitAt m rest
              jk = map (fst . fromJust . C.readInt) jkl
              jl = map (fst . fromJust . C.readInt) jll
           in (jk, jl) : parse rest'

-- two-pointer technique to count intersection of two sorted lists
solve :: (Ord a, Eq a) => [a] -> [a] -> Int
solve jk jl = go jk jl 0
  where
    go [] _ acc = acc
    go _ [] acc = acc
    go (x : xs) (y : ys) acc
      | x == y = go xs ys (acc + 1)
      | x < y = go xs (y : ys) acc
      | otherwise = go (x : xs) ys acc
