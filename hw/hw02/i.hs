{-
Deduplicating Files

Description:
Computer filesystems often contain multiple copies of identical files. To save
storage space, identify and remove duplicate files by comparing their content.
Given pairs of files, determine how many unique files exist and how many hash
collisions occur when using a simple hash function.

Input Format:
- Input consists of up to 250 test cases
- Each test case begins with integer n (≤ 500,000) - number of files
- This is followed by n lines, each representing content of one file
- Each file line has 1 to 40 characters, using only letters a-z, A-Z
- Input ends when n = 0

Output Format:
For each test case, print two numbers:
1. The number of unique files (files with different content)
2. The number of hash collisions between pairs of files

Example:
Input:
4
four score and seven years ago
score four and seven years ago
four score and seven years ago
ask not what your country can d

Output:
3 2

Constraints:
- Up to 250 test cases
- n ≤ 500,000 files per test case
- Each file content: 1-40 characters from [a-zA-Z]
- Hash function uses XOR of ASCII values of all characters

Notes:
- Use XOR hash function: hash = XOR of ASCII values of all bytes in file
- Two files are identical if their content strings are exactly the same
- Hash collision occurs when two different files have the same hash value
- Count unique files by comparing actual file contents, not just hashes
- For collision counting, compare hash values of all distinct file pairs
- Efficient approach: group files by hash value, then check for actual duplicates
-}

import Data.Bits (xor)
import Data.Char (ord)

main :: IO ()
main = interact $ unlines . map show . parse . lines
  where
    parse [] = []
    parse ("0" : _) = []
    parse (x : xs) = do
      n <- [read x :: Int]
      files <- [take n xs]
      solve files : parse (drop n xs)

solve :: [String] -> (Int, Int)
solve files =
  let hashes = map hash files
   in (0, 0)
  where
    hash :: String -> Int
    hash = foldr (xor . ord) 0
