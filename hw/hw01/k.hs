{-
Kattis – T9 Spelling

Simulate typing text messages on a traditional phone keypad.
Each letter maps to a digit key, pressed multiple times depending on its position.
If two consecutive letters use the same key, insert a space to indicate a pause.
The space character itself is entered by pressing 0.

Input:

\* First line: integer n (number of test cases).
\* Next n lines: each contains a message (lowercase letters 'a'–'z' and spaces).

Output:

\* For each case i, print: "Case #i: " followed by the sequence of key presses.

Example:
Input
4
hi
yes
foo  bar
hello world

Output
Case #1: 44 444
Case #2: 999337777
Case #3: 333666 6660 022 2777
Case #4: 4433555 555666096667775553
-}

import Data.Map qualified as Map

main :: IO ()
main = do
  n <- readLn :: IO Int
  mapM_ process [1 .. n]
  where
    process i = do
      line <- getLine
      putStrLn $ "Case #" ++ show i ++ ": " ++ convert line

convert :: String -> String
convert s = go (map (buttons Map.!) s)
  where
    go [] = []
    go [x] = x
    go (x@(c : _) : y@(c' : _) : rest) =
      let separator = if c == c' then " " else ""
       in x ++ separator ++ go (y : rest)

buttons :: Map.Map Char String
buttons =
  Map.fromList
    [ ('a', "2"),
      ('b', "22"),
      ('c', "222"),
      ('d', "3"),
      ('e', "33"),
      ('f', "333"),
      ('g', "4"),
      ('h', "44"),
      ('i', "444"),
      ('j', "5"),
      ('k', "55"),
      ('l', "555"),
      ('m', "6"),
      ('n', "66"),
      ('o', "666"),
      ('p', "7"),
      ('q', "77"),
      ('r', "777"),
      ('s', "7777"),
      ('t', "8"),
      ('u', "88"),
      ('v', "888"),
      ('w', "9"),
      ('x', "99"),
      ('y', "999"),
      ('z', "9999"),
      (' ', "0")
    ]
