module Quicksort where

import Control.Monad.ST
import Data.Array.ST

-- pure functional quicksort implementation
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) = quicksort lt ++ [x] ++ quicksort gt
  where
    lt = [y | y <- xs, y <= x]
    gt = [y | y <- xs, y > x]
