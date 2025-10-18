{-
Virtual Friends

Description:
Track the size of social networks as friendships are formed on a virtual friends
website. When people become friends, their entire social networks merge together.
Your task is to observe friendship formations and report the size of the combined
network after each new friendship is established.

Input Format:
- First line: integer specifying number of test cases
- Each test case begins with positive integer F (number of friendships formed)
- Following F lines contain pairs of names representing new friendships
- Names are strings of 1-6 letters (uppercase or lowercase)
- Names separated by a space
- All friendships are mutual (if A friends B, then B friends A)

Output Format:
For each friendship formed, print the total number of people in the combined
social network of the two people who just became friends.

Example:
Input:
1
3
Fred Barney
Barney Betty
Betty Wilma

Output:
2
3
4

Constraints:
- Sum of F over all test cases ≤ 100,000
- Names are 1-6 characters, letters only
- Each friendship connects exactly two people
- Networks merge when friendships form

Notes:
- This is a Union-Find (Disjoint Set Union) problem
- Track component sizes as unions occur
- When two people become friends, their entire networks merge
- Use path compression and union by rank for efficiency
- Map names to integers for easier processing
- After each union operation, output the size of the merged component
-}

import Control.Monad (replicateM, replicateM_)
import Control.Monad.State
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $ do
    f <- readLn
    _ <- execStateT (process f) (Map.empty, Map.empty)
    return ()
  where
    process :: Int -> StateT Network IO ()
    process 0 = return ()
    process n = do
      line <- lift getLine
      let [x, y] = words line
      size <- x `union` y
      lift $ print size
      process (n - 1)

type Network = (Map String String, Map String Int) -- (parent map, size map)

root :: String -> StateT Network IO String
root x = do
  (pm, sm) <- get
  case Map.lookup x pm of
    Nothing -> do
      put (Map.insert x x pm, Map.insert x 1 sm)
      return x
    Just p -> do
      if p == x
        then return x
        else do
          r <- root p
          (pm', sm') <- get
          put (Map.insert x r pm', sm')
          return r

union :: String -> String -> StateT Network IO Int
union x y = do
  rx <- root x
  ry <- root y
  if rx == ry
    then do
      (_, sm) <- get
      return $ sm Map.! rx
    else do
      (pm, sm) <- get
      let sizeX = sm Map.! rx
          sizeY = sm Map.! ry
      if sizeX < sizeY
        then do
          put (Map.insert rx ry pm, Map.insert ry (sizeX + sizeY) (Map.delete rx sm))
          return $ sizeX + sizeY
        else do
          put (Map.insert ry rx pm, Map.insert rx (sizeX + sizeY) (Map.delete ry sm))
          return $ sizeX + sizeY
