import Control.Monad.State
import Data.Array
import Data.List (findIndex, sortOn)
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)

data Job = Job {start :: Int, finish :: Int, weight :: Int} deriving (Show)

solve :: [Job] -> Int
solve jobs = evalState (opt n) Map.empty
  where
    n = length jobs
    jobsArr = listArray (1, n) (sortOn finish jobs)

    p :: Int -> Int
    p j = fromMaybe 0 $ findIndex (\i -> finish (jobsArr ! i) <= start (jobsArr ! j)) [j - 1, j - 2 .. 1] >>= Just . (+ 1)

    opt :: Int -> State (Map Int Int) Int
    opt 0 = return 0
    opt j = do
      memo <- get
      case Map.lookup j memo of
        Just v -> return v
        Nothing -> do
          let Job _ _ w = jobsArr ! j
          a <- opt (j - 1)
          b <- opt (p j) >>= \v -> return (v + w)
          let v = max a b
          modify (Map.insert j v)
          return v
