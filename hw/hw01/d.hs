{-
Kattis – Help a PhD candidate out!

Jon Marius has a list of problems to solve: either simple additions of two integers or the repeated problem "P=NP".
For each addition, compute the sum. For "P=NP", output "skipped".

Input:

\* First line: integer t, the number of test cases.
\* Next t lines: each line is either "P=NP" or an expression of the form "a+b" with integers a and b.

Output:

\* For each line: print the sum if it's an addition, or "skipped" if the line is "P=NP".

Example:
Input
4
2+2
1+2
P=NP
0+0
Output
4
3
skipped
0
-}

import Control.Monad (replicateM_)

sol :: Int -> IO ()
sol n = replicateM_ n $ do
  l <- getLine
  case break (== '+') l of
    (xs, '+' : ys) -> print (read xs + read ys :: Int)
    _ -> putStrLn "skipped"

main :: IO ()
main = do
  n <- readLn
  sol n
