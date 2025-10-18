import Control.Monad.State
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)

-- order matters
solve :: Int -> Int
solve n = evalState (ways n) Map.empty
  where
    ways 0 = return 1
    ways k | k < 0 = return 0
    ways k = do
      memo <- get
      case Map.lookup k memo of
        Just v -> return v
        Nothing -> do
          a <- ways (k - 1)
          b <- ways (k - 3)
          c <- ways (k - 4)
          let v = a + b + c
          modify (Map.insert k v)
          return v
