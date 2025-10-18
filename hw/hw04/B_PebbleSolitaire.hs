import Control.Monad (replicateM)
import Control.Monad.State
import Data.Bifunctor (first)
import Data.Bits
import Data.ByteString.Char8 qualified as B
import Data.List (foldl')
import Data.Map qualified as Map
import Data.Maybe (fromJust)
import Data.Word

main :: IO ()
main = do
  n <- B.getLine >>= \l -> return $ fst $ fromJust $ B.readInt l
  bs <- replicateM n getLine
  let (rr, _) =
        foldl'
          ( \(a, m) s ->
              let b = fromList s
                  (r, m') = runState (solve b) m
               in (r : a, m')
          )
          ([], (Map.empty, Map.empty))
          bs
  mapM_ print $ reverse rr

type Board = Word64

type Move = (Int, Int)

type BM = Map.Map Board Int

type MM = Map.Map Board [Move]

cols :: Int
cols = 23

empty :: Board
empty = 0

full :: Board
full = (1 `shiftL` cols) - 1

fromList :: [Char] -> Board
fromList xs = foldl' setBitIf (0 :: Board) (zip [0 ..] xs)
  where
    setBitIf a (i, 'o') = a `setBit` i
    setBitIf a _ = a

apply :: Move -> Board -> Board
apply (f, t) b = cleared `setBit` t
  where
    mid = (f + t) `div` 2
    cleared = (b `clearBit` f) `clearBit` mid

moves' :: Board -> [Move]
moves' b
  | b == empty = []
  | b == full = []
  | otherwise = concatMap go [0 .. cols - 1]
  where
    go i
      | testBit b i = l ++ r
      | otherwise = []
      where
        l = [(i, i - 2) | i >= 2, testBit b (i - 1), not (testBit b (i - 2))]
        r = [(i, i + 2) | i + 2 < cols, testBit b (i + 1), not (testBit b (i + 2))]

moves :: Board -> State (BM, MM) [Move]
moves b = do
  (bm, mm) <- get
  case Map.lookup b mm of
    Just ms -> return ms
    Nothing -> do
      let ms = moves' b
      put (bm, Map.insert b ms mm)
      return ms

solve :: Board -> State (BM, MM) Int
solve b = do
  (bm, _) <- get
  case Map.lookup b bm of
    Just v -> return v
    Nothing -> do
      ms <- moves b
      result <-
        if null ms
          then return (popCount b)
          else do
            vs <- mapM (\m -> solve (apply m b)) ms
            return $ minimum vs
      modify' $ first (Map.insert b result)
      return result
