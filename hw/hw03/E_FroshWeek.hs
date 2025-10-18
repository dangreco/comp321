data OST
  = Empty
  | Node
      { key :: !Int,
        cnt :: !Int,
        size :: !Int,
        height :: !Int,
        left :: OST,
        right :: OST
      }
  deriving (Show, Eq)

heightOf :: OST -> Int
heightOf Empty = 0
heightOf (Node _ _ _ h _ _) = h

sizeOf :: OST -> Int
sizeOf Empty = 0
sizeOf (Node _ _ s _ _ _) = s

mkNode :: Int -> Int -> OST -> OST -> OST
mkNode k c l r =
  Node
    { key = k,
      cnt = c,
      size = c + sizeOf l + sizeOf r,
      height = 1 + max (heightOf l) (heightOf r),
      left = l,
      right = r
    }

rotateRight :: OST -> OST
rotateRight (Node k c _ _ (Node lk lc _ _ ll lr) r) =
  mkNode lk lc ll (mkNode k c lr r)
rotateRight t = t

rotateLeft :: OST -> OST
rotateLeft (Node k c _ _ l (Node rk rc _ _ rl rr)) =
  mkNode rk rc (mkNode k c l rl) rr
rotateLeft t = t

balanceFactor :: OST -> Int
balanceFactor Empty = 0
balanceFactor n = heightOf (left n) - heightOf (right n)

rebalance :: OST -> OST
rebalance t@(Node _ _ _ _ l r)
  | bf > 1 && balanceFactor l >= 0 = rotateRight t
  | bf > 1 =
      let l' = rotateLeft l in rotateRight (mkNode (key t) (cnt t) l' r)
  | bf < -1 && balanceFactor r <= 0 = rotateLeft t
  | bf < -1 =
      let r' = rotateRight r in rotateLeft (mkNode (key t) (cnt t) l r')
  | otherwise = mkNode (key t) (cnt t) l r
  where
    bf = balanceFactor t
rebalance t = t

insertOST :: Int -> OST -> OST
insertOST x Empty = mkNode x 1 Empty Empty
insertOST x t@(Node k c _ _ l r)
  | x == k = mkNode k (c + 1) l r
  | x < k = rebalance $ mkNode k c (insertOST x l) r
  | otherwise = rebalance $ mkNode k c l (insertOST x r)

countGreater :: Int -> OST -> Int
countGreater _ Empty = 0
countGreater x (Node k c _ _ l r)
  | x < k = sizeOf r + c + countGreater x l
  | x == k = sizeOf r
  | otherwise = countGreater x r

streamInversions :: [Int] -> [Integer]
streamInversions = go Empty 0
  where
    go :: OST -> Integer -> [Int] -> [Integer]
    go _ _ [] = []
    go ost acc (x : xs) =
      let add = fromIntegral (countGreater x ost)
          acc' = acc + add
          ost' = insertOST x ost
       in acc' : go ost' acc' xs

main :: IO ()
main = interact $ show . solve . parse . lines
  where
    parse [] = []
    parse (x : xs) =
      let n = read x :: Int
       in map read (take n xs) :: [Int]

    solve :: [Int] -> Integer
    solve xs = last (streamInversions xs)
