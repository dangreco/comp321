{-
Kattis – Permutation Encryption

Encrypt messages using a permutation key. A key is a permutation of numbers 1..k that specifies how to reorder each block of k characters.
If the message length is not a multiple of k, pad with spaces at the end before applying the permutation.
Encryption is applied to every block of length k in sequence.

Input:

\* Multiple test cases, each consisting of:

  * One line: integer k followed by k integers (the permutation).
  * One line: the message text (may contain spaces).
\* Input ends with a line containing a single 0.

Output:

\* For each message, print the encrypted message enclosed in single quotes.

Example:
Input
1 1
Four score and seven years ago
2 2 1
our fathers brough forth on this continent a new nation,
5 1 3 2 5 4
conceived in liberty and dedicated to the proposition
10 5 10 8 1 3 6 4 7 2 9
that all men are created equal.
0

Output
'Four score and seven years ago'
'uo rafhtre srbuohgf rohto  nhtsic noitentna n wen taoi,n'
'cnoeciev di nilbreyt na dddeciaet dt ohtep orpsotiino  '
' mltaatlh rece ea nr luaeedqta   .      '
-}

import Data.Array

main :: IO ()
main = interact process

process :: String -> String
process = unlines . go . lines
  where
    go [] = []
    go (l : rest)
      | l == "0" = []
      | otherwise = case rest of
          (s : remaining) -> ("'" ++ encrypt p s ++ "'") : go remaining
          [] -> []
      where
        p = drop 1 (map read (words l)) :: [Int]

encrypt :: [Int] -> String -> String
encrypt p s = concatMap (permute p) (chunk k s)
  where
    k = length p

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

permute :: [Int] -> String -> String
permute p s = map (pad !) p
  where
    k = length p
    pad = listArray (1, k) (take k (s ++ repeat ' '))
