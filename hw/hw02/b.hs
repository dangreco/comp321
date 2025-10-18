{-
Backspace

Description:
Simulate a text editor with backspace functionality. Given a string containing
lowercase English letters and '<' symbols (representing backspace), determine
what the final string would look like after processing all characters and
backspace operations.

Input Format:
- Single line containing a string S of length N
- String contains only lowercase English letters (a-z) and '<' symbol
- Length constraint: 1 ≤ N ≤ 100

Output Format:
Print the final string after processing all backspace operations.
If the final string is empty, print an empty line.

Example:
Input: a<bc
Output: b

Input: correctium
Output: correctium

Input: <c<a<c
Output: (empty line)

Constraints:
- 1 ≤ N ≤ 100
- String contains only lowercase letters and '<' symbol
- '<' represents backspace operation (removes previous character if exists)
- Multiple consecutive backspaces are allowed

Scoring:
The solution will be tested on different difficulty groups:
- Group 1 (10 points): Basic cases, 1 ≤ N ≤ 100
- Group 2 (30 points): Cases without consecutive '<', 1 ≤ N ≤ 100
- Group 3 (40 points): General cases, 1 ≤ N ≤ 100
- Group 4 (60 points): All test cases, 1 ≤ N ≤ 100

Notes:
- Process string character by character from left to right
- When encountering '<': remove last character if string is not empty
- When encountering letter: append to current string
- Can be solved using stack data structure or string manipulation
- Handle edge case where backspace is applied to empty string (no effect)
-}

main :: IO ()
main = interact $ unlines . map fix . lines

fix :: String -> String
fix s =
  let (_, s') = go s []
   in reverse s'
  where
    go [] ys = ([], ys)
    go ('<' : xs) [] = go xs []
    go ('<' : xs) (y : ys) = go xs ys
    go (x : xs) ys = go xs (x : ys)
