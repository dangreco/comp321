{-
Galactic Collegiate Programming Contest

Description:
Track the performance of teams in a programming contest over multiple events.
Each team has a score represented as a pair of integers (a, b) where 'a' is the
number of problems solved and 'b' is the penalty. When teams participate in
events, their scores may improve. After processing all events, determine the
final ranking of a specified favorite team.

Input Format:
- First line: two integers n and m (1 ≤ n ≤ 10^6, 1 ≤ m ≤ 10^6)
 - n = number of teams
 - m = number of events
- Next m lines describe events, each containing two integers i and p
 - i = team number (1-indexed)
 - p = penalty value for that team in this event
- Events are ordered by the time when they happen

Output Format:
Output the rank of your favorite team (team 1) after all events have been
processed. Rank is determined by:
1. Team with more problems solved ranks higher
2. If tied on problems solved, team with lower penalty ranks higher

Example:
Input:
3 4
1 5
2 3
1 4
2 6

Output:
2

Constraints:
- 1 ≤ n ≤ 10^6 (number of teams)
- 1 ≤ m ≤ 10^6 (number of events)
- Team numbers are 1-indexed
- All penalty values are positive integers
- Events are processed in chronological order

- Use BST
- Big picture:
-}

main :: IO ()
main = interact $ unlines . parse . lines
  where
    parse [] = []
    parse (x : xs) =
      let [n, m] = map read (words x) :: [Int]
       in []

type Event = (Int, Int) -- (team, penalty)

type Score = (Int, Int) -- (solved, penalty)

data Tree = Empty | Node Tree Int Score Tree
  deriving (Show, Eq)
