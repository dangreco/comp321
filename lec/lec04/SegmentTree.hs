module SegmentTree where

data SegmentTree a
  = Leaf (Int, Int) a
  | Node (Int, Int) a (SegmentTree a) (SegmentTree a)
  deriving (Show, Eq)

build :: (Num a) => [a] -> SegmentTree a
build [] = error "Cannot build a segment tree from an empty list"
build [x] = Leaf (0, 0) x
build xs = build' xs 0 (length xs - 1)
  where
    build' ys start end
      | start == end = Leaf (start, end) (ys !! start)
      | otherwise =
          let mid = (start + end) `div` 2
              left = build' ys start mid
              right = build' ys (mid + 1) end
              (lr, ls) = case left of
                Leaf r s -> (r, s)
                Node r s _ _ -> (r, s)
              (rr, rs) = case right of
                Leaf r s -> (r, s)
                Node r s _ _ -> (r, s)
           in Node (fst lr, snd rr) (ls + rs) left right

query :: (Num a) => SegmentTree a -> (Int, Int) -> a
query (Leaf (l, r) v) (ql, qr)
  | ql <= l && r <= qr = v
  | otherwise = 0
query (Node (l, r) v left right) (ql, qr)
  | ql <= l && r <= qr = v
  | qr < l || r < ql = 0
  | otherwise = query left (ql, qr) + query right (ql, qr)

update :: (Num a) => SegmentTree a -> Int -> a -> SegmentTree a
update (Leaf (l, r) v) i v'
  | l == i && r == i = Leaf (l, r) v'
  | otherwise = Leaf (l, r) v
update (Node (l, r) v left right) i v'
  | i < l || i > r = Node (l, r) v left right
  | otherwise =
      let left' = update left i v'
          right' = update right i v'
          (ll, lv) = case left' of
            Leaf lr ls -> (lr, ls)
            Node lr ls _ _ -> (lr, ls)
          (rl, rv) = case right' of
            Leaf rr rs -> (rr, rs)
            Node rr rs _ _ -> (rr, rs)
       in Node (l, r) (lv + rv) left' right'
