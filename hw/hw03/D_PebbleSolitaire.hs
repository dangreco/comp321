import Control.Monad (replicateM)
import Control.Monad.State
import Data.Bits
import Data.List (foldl')
import Data.Map qualified as Map
import Data.Word

type Board = Word64

type Move = (Int, Int)

main :: IO ()
main = do
  n <- readLn :: IO Int
  boards <- replicateM n getLine
  let (resultsRev, _memoFinal) =
        foldl'
          ( \(acc, memo) str ->
              let b = fromList str
                  (res, memo') = runState (minTiles b) memo
               in (res : acc, memo')
          )
          ([], Map.empty)
          boards
      results = reverse resultsRev
  mapM_ print results

fromList :: [Char] -> Board
fromList xs = foldl setBitIf (0 :: Board) (zip [0 ..] xs)
  where
    setBitIf acc (i, 'o') = acc `setBit` i
    setBitIf acc _ = acc

toList :: Board -> [Char]
toList b = map (\i -> if testBit b i then 'o' else '-') [0 .. 11]

apply :: Move -> Board -> Board
apply (f, t) b = bCleared `setBit` t
  where
    mid = (f + t) `div` 2
    bCleared = (b `clearBit` f) `clearBit` mid

moves :: Board -> State (Map.Map Board [Move]) [Move]
moves b = do
  memo <- get
  case Map.lookup b memo of
    Just ms -> return ms
    Nothing -> do
      let ms = moves' b
      put $ Map.insert b ms memo
      return ms

moves' :: Board -> [Move]
moves' b
  | b == 0 = []
  | b == 4095 = []
  | otherwise = concatMap go [0 .. 11]
  where
    go i
      | testBit b i = left ++ right
      | otherwise = []
      where
        left = [(i, i - 2) | i >= 2 && testBit b (i - 1) && not (testBit b (i - 2))]
        right = [(i, i + 2) | i <= 9 && testBit b (i + 1) && not (testBit b (i + 2))]

minTiles :: Board -> State (Map.Map Board Int) Int
minTiles b = do
  memo <- get
  case Map.lookup b memo of
    Just v -> return v
    Nothing -> do
      let ms = moves' b
      result <-
        if null ms
          then return (popCount b)
          else do
            mins <- mapM (\m -> minTiles (apply m b)) ms
            return (minimum mins)
      modify' (Map.insert b result)
      return result
