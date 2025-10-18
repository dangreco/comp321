{-
Kattis – Simple Addition

Read two positive integers (each given on a separate line) and output their sum.
The integers can be very large, so they must be handled without overflow.

Input:

\* Two lines, each containing a positive integer (arbitrarily large).

Output:

\* A single line with the sum of the two integers.

Example:
Input
1337
42
Output
1379

Input
1
9999999999999
Output
10000000000000
-}

main :: IO ()
main = do
  a <- readLn :: IO Integer
  b <- readLn :: IO Integer
  print (a + b)
