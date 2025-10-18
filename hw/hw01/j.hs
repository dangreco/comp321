{-
Kattis – Timebomb

The bomb displays a code using ASCII art digits (5 rows × 3 columns per digit, separated by 1 column of spaces).
Each digit must match one of the valid representations for 0–9. If any digit is invalid, the bomb explodes. Otherwise, interpret the ASCII art as an integer.
If the number is divisible by 6, it is safe to press the button and the bomb is defused; otherwise, the bomb explodes.

Input:

\* An ASCII art representation of a code with 2–8 digits.
\* Each digit is 5 rows high, 3 columns wide, separated by 1 space column.
\* Only characters ' ' and '\*' are used.

Output:

\* Print "BEER!!" if the number is valid and divisible by 6.
\* Otherwise, print "BOOM!!".

Example:

Input
\***   * * * *** *** *** ***
\* *   * * *   *   *   * *
\* *   * *** *** *** *** ***
\* *   *   * *     * *   * *
\***   *   * *** *** *** ***

Output
BEER!!

Input
\*   * *** *** *** * *
\*   * **    * * * * *
\*   * *** *** *** ***
\*   * *   *   * *   *
\*   * *** *** ***   *

Output
BOOM!!

Input
\*** ***   * *** ***   *
\*   * *   * * *   *   *
\*** * *   * *** ***   *
  * * *   *   * *     *
\*** ***   * *** ***   *

Output
BOOM!!

Input
\*** *** *** * * ***
  *   *   * * * * *
\***   * *** *** ***
\*     *   *   * * *
\***   * ***   * ***

Output
BEER!

AAA BBB CCC DDD EEE FFF GGG
AAA BBB CCC DDD EEE FFF GGG
AAA BBB CCC DDD EEE FFF GGG
AAA BBB CCC DDD EEE FFF GGG
AAA BBB CCC DDD EEE FFF GGG
-}

import Data.List (transpose)
import Data.Map qualified as Map

main :: IO ()
main = interact $ solve . parse . lines

parse :: [String] -> Maybe Int
parse input = do
  digits <- mapM (flip Map.lookup font . concat) (transpose (map chunk input))
  return (read (concatMap show digits))

solve :: Maybe Int -> String
solve (Just n) = (if n `mod` 6 == 0 then "BEER!!" else "BOOM!!") ++ "\n"
solve Nothing = "BOOM!!\n"

chunk :: String -> [String]
chunk [] = []
chunk (c1 : c2 : c3 : s')
  | null s' = [[c1, c2, c3]]
  | otherwise = [c1, c2, c3] : chunk (drop 1 s')
chunk _ = []

font :: Map.Map String Int
font =
  Map.fromList
    [ ("**** ** ** ****", 0),
      ("  *  *  *  *  *", 1),
      ("***  *****  ***", 2),
      ("***  ****  ****", 3),
      ("* ** ****  *  *", 4),
      ("****  ***  ****", 5),
      ("****  **** ****", 6),
      ("***  *  *  *  *", 7),
      ("**** ***** ****", 8),
      ("**** ****  ****", 9)
    ]
