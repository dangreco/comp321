{-
Kattis – Left Beehind

Bill wants to attend the beekeeper’s convention, but his friends judge based on the number of sweet and sour honey jars he has.

\* If sweet > sour, he goes to the convention.
\* If sour > sweet, he is left "beehind".
\* If sweet = sour, they are undecided.
\* However, if the total jars = 13, his friends will "Never speak again." (this overrides all other cases).

Input:

\* Multiple lines, each with two integers s and r (sweet and sour jars).
\* Terminates with "0 0", which should not be processed.
\* Up to 10,000 test cases.

Output:

\* For each case, print one of:

  * "To the convention."
  * "Left beehind."
  * "Undecided."
  * "Never speak again."

Example:
Input
17 3
13 14
8 5
44 44
0 0
Output
To the convention.
Left beehind.
Never speak again.
Undecided.
-}

main :: IO ()
main =
  interact $
    unlines
      . map (uncurry judge . toPair)
      . takeWhile (/= ["0", "0"])
      . map words
      . lines
  where
    toPair [a, b] = (read a, read b)

judge :: Int -> Int -> String
judge s r
  | s + r == 13 = "Never speak again."
  | s > r = "To the convention."
  | s < r = "Left beehind."
  | otherwise = "Undecided."
