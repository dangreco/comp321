{-
Input:

```
n p
x1 x2 ... xn
```

n := number of commercial breaks in a day
p := price of one commercial break
xi := number of listeners of i-th break

we want CONTINUOUS subsequence of breaks that maximizes profit
profit := sum_0^k (x_i - p)

base cases:
- n = 0 => profit = 0
- n = 1 => profit = max(0, x_1 - p)
- n = 2 => profit = max(x_i - p, x_(i-1) + x_i - p)
-}

import Data.ByteString.Char8 qualified as B
import Data.List (foldl')
import Data.Maybe (fromJust)

main :: IO ()
main = do
  l1 <- B.getLine
  l2 <- B.getLine
  let (_ : p : _) = map (fst . fromJust . B.readInt) (B.words l1)
      xs = map (fst . fromJust . B.readInt) (B.words l2)
  print (solve p xs)

solve :: Int -> [Int] -> Int
solve p xs = fst $ foldl' go (0, 0) xs
  where
    go (!b, !c) x =
      let c' = max 0 (c + x - p)
          b' = max b c'
       in (b', c')
