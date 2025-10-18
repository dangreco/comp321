{-
Doorman

Description:
A doorman at a nightclub needs to manage entry to maintain gender balance.
People arrive in a queue with genders marked as 'W' (women) and 'M' (men).
The doorman can let people enter in order, but wants to keep the absolute
difference between the number of women and men inside the club as small
as possible. He can skip people in the queue (let them wait) and come back
to them later, but cannot change the relative order of people of the same gender.

Input Format:
- First line: positive integer X ≤ 100 (describes largest absolute difference
 the doorman can handle between number of women and men in the club)
- Second line: string of 'W' and 'M' characters (length ≤ 100) representing
 the queue order, describing genders of people waiting to enter

Output Format:
Print the maximum number of people the doorman can let into the club
without the absolute difference between men and women exceeding X.

Example:
Input:
1
WMWMWMWMWM

Output:
10

Input:
0
MWMWMWMWMW

Output:
8

Constraints:
- 1 ≤ X ≤ 100 (maximum allowed gender difference)
- Queue length ≤ 100
- Queue contains only 'W' and 'M' characters
- Must maintain relative order within each gender
- Goal: maximize number of people admitted while keeping |women - men| ≤ X

Notes:
- This is a greedy algorithm problem with gender balance constraint
- At each step, choose to admit the next person if it doesn't violate constraint
- Track running difference between women and men admitted
- Can skip people and return to them later (within gender order constraints)
- Optimal strategy: always admit next person if constraint allows
-}

import Control.Monad.State
import Data.Map.Strict qualified as Map

main :: IO ()
main = do
  n <- readLn :: IO Int
  queue <- getLine
  print $ solve n queue

type Memo = Map.Map ([Char], Int, Int) Int

solve :: Int -> [Char] -> Int
solve x queue = evalState (go queue 0 0) Map.empty
  where
    go ps m w = do
      memo <- get
      case Map.lookup (ps, m, w) memo of
        Just v -> return v
        Nothing -> do
          v <- go' ps m w
          modify (Map.insert (ps, m, w) v)
          return v

    go' [] m w = return (m + w)
    go' [p] m w = admit p [] m w
    go' (p : p' : ps) m w
      | p == p' = admit p (p' : ps) m w
      | otherwise = do
          v1 <- admit p (p' : ps) m w
          v2 <- admit p' (p : ps) m w
          return $ max v1 v2

    admit p ps m w
      | p == 'M' && abs (m + 1 - w) <= x = go ps (m + 1) w
      | p == 'W' && abs (m - (w + 1)) <= x = go ps m (w + 1)
      | otherwise = return (m + w)
