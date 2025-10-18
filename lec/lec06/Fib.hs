import Control.Monad.State
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)

solve :: Int -> Int
solve n = evalState (fib n) Map.empty
  where
    fib 0 = return 0
    fib 1 = return 1
    fib n = do
      memo <- get
      case Map.lookup n memo of
        Just v -> return v
        Nothing -> do
          a <- fib (n - 1)
          b <- fib (n - 2)
          let v = a + b
          modify (Map.insert n v)
          return v
