import Control.Monad.State
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)

solve :: [Int] -> Int -> Int
solve _ 0 = 1
solve [] _ = 0
solve coins@(c : cs) sum
  | sum < 0 = 0
  | otherwise = solve coins (sum - c) + solve cs sum

solve' :: [Int] -> Int -> Int
solve' coins sum = evalState (ways sum) Map.empty
  where
    ways 0 = return 1
    ways k | k < 0 = return 0
    ways k = do
      memo <- get
      case Map.lookup k memo of
        Just v -> return v
        Nothing -> do
          results <- mapM (\c -> ways (k - c)) coins
          let v = Prelude.sum results
          modify (Map.insert k v)
          return v
