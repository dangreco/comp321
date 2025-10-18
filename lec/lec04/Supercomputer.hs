import Data.Bits ((.&.))

main :: IO ()
main = interact $ unlines . parse . lines
  where
    parse [] = []
    parse (x : xs) =
      let [n, k] = map read (words x) :: [Int]
       in solve n k xs

data Op = Flip Int | Query Int Int deriving (Show, Eq)

solve :: Int -> Int -> [String] -> [String]
solve _ _ _ = []

newtype FenwickTree a = FenwickTree [a] deriving (Show, Eq)

build :: (Num a) => [a] -> FenwickTree a
build xs = FenwickTree (build' xs)
  where
    build' ys = foldl update' (replicate (length ys + 1) 0) (zip [1 ..] ys)
    update' ft (i, v) = let j = i in go ft j v
      where
        go ft j v
          | j < length ft = go (take j ft ++ [ft !! j + v] ++ drop (j + 1) ft) (j + (j .&. (-j))) v
          | otherwise = ft

query :: (Num a) => FenwickTree a -> Int -> a
query (FenwickTree ft) i = go ft i 0
  where
    go ft j acc
      | j > 0 = go ft (j - (j .&. (-j))) (acc + ft !! j)
      | otherwise = acc

update :: (Num a) => FenwickTree a -> Int -> a -> FenwickTree a
update (FenwickTree ft) i v = FenwickTree (go ft i v)
  where
    go ft j v
      | j < length ft = go (take j ft ++ [ft !! j + v] ++ drop (j + 1) ft) (j + (j .&. (-j))) v
      | otherwise = ft
