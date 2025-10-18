{-
Kattis – Quick Brown Fox

A pangram is a phrase that contains every letter from 'a' to 'z' at least once, case-insensitive.
For each given phrase, determine whether it is a pangram. If not, list the missing letters in alphabetical order.

Input:

\* First line: integer n, the number of phrases.
\* Next n lines: each contains a phrase (1–100 characters), which may include letters, digits, spaces, and punctuation.

Output:

\* For each phrase:

  * Print "pangram" if it contains all letters.
  * Otherwise, print "missing " followed by the missing letters in lowercase.

Example:
Input
3
The quick brown fox jumps over the lazy dog.
ZYXW, vu TSR Ponm lkj ihgfd CBA.
.,?!'" 92384 abcde FGHIJ
Output
pangram
missing eq
missing klmnopqrstuvwxyz
-}

import Data.Char (isAlpha, toLower)
import Data.Set qualified as Set

main :: IO ()
main =
  interact $
    unlines
      . map solve
      . drop 1
      . lines

solve :: String -> String
solve s =
  case missing s of
    [] -> "pangram"
    miss -> "missing " ++ miss

alphabet :: Set.Set Char
alphabet = Set.fromList ['a' .. 'z']

missing :: String -> [Char]
missing = go Set.empty
  where
    go seen [] = Set.toList (alphabet `Set.difference` seen)
    go seen (c : cs)
      | Set.size seen' == 26 = []
      | otherwise = go seen' cs
      where
        seen' =
          if isAlpha c
            then Set.insert (toLower c) seen
            else seen
