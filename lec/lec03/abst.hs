module ABST where

-- augmented binary search tree
data ABST = Empty | Node ABST Int Int ABST
  deriving (Show, Eq)

-- insert an element into the tree
insert :: Int -> ABST -> ABST
insert x Empty = Node Empty x 1 Empty
insert x node@(Node left y size right)
  | x <= y = case insert x left of
      left'@(Node {}) -> Node left' y (1 + size) right
      Empty -> node
  | otherwise = case insert x right of
      right'@(Node {}) -> Node left y (1 + size) right'
      Empty -> node

-- find the kth smallest element
kth :: Int -> ABST -> Maybe Int
kth 0 _ = Nothing
kth k Empty = Nothing
kth k (Node left y _ right) = case left of
  Empty -> if k == 1 then Just y else kth (k - 1) right
  Node _ _ m _
    | k == m + 1 -> Just y
    | k < m + 1 -> kth k left
    | otherwise -> kth (k - m - 1) right
