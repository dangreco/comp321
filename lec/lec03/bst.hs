module BST where

data BST a = Empty | Node (BST a) a (BST a)
  deriving (Show, Eq)

insert :: (Ord a) => a -> BST a -> BST a
insert x Empty = Node Empty x Empty
insert x (Node left y right)
  | x <= y = Node (insert x left) y right
  | otherwise = Node left y (insert x right)

member :: (Ord a) => a -> BST a -> Bool
member x Empty = False
member x (Node left y right)
  | x == y = True
  | x < y = member x left
  | otherwise = member x right
