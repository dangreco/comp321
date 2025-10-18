{-
I Can Guess the Data Structure!

Description:
Given a sequence of operations on an unknown data structure, determine what
type of data structure it could be. The operations are:
1. Insert an element x into the data structure
2. Remove and return an element from the data structure

Based on the pattern of insertions and removals, identify if the data structure
behaves like a stack (LIFO), queue (FIFO), priority queue (largest element first),
or if it's impossible to determine or inconsistent with any of these structures.

Input Format:
- Multiple test cases until EOF
- Each test case starts with integer n (1 ≤ n ≤ 1000)
- Next n lines contain operations:
 - Type 1: "1 x" - insert element x into the data structure
 - Type 2: "2 x" - remove element, expecting to get value x
- Value of x is always a positive integer ≤ 100
- Input terminates when no more data is available

Output Format:
For each test case, output one of the following:
- "stack" - if behavior matches a stack (LIFO)
- "queue" - if behavior matches a queue (FIFO)
- "priority queue" - if behavior matches a priority queue (max element first)
- "impossible" - if the sequence is inconsistent with all three structures
- "not sure" - if more than one data structure could explain the behavior

Example:
Input:
6
1 1
1 2
1 3
2 3
2 2
2 1

Output:
stack

Constraints:
- 1 ≤ n ≤ 1000 (number of operations per test case)
- 1 ≤ x ≤ 100 (element values)
- Operations alternate between insertions and removals
- Must handle multiple test cases until EOF

Notes:
- Simulate each data structure independently
- For each removal operation, check if expected value matches what each
 structure would return
- Stack: Last In, First Out (LIFO)
- Queue: First In, First Out (FIFO)
- Priority Queue: Largest element comes out first
- Track which structures remain consistent after each operation
-}

main :: IO ()
main = interact $ unlines . map solve . parse . lines
  where
    parse [] = []
    parse (n : xs) =
      let (ops, ys) = splitAt (read n) xs
       in map read ops : parse ys

solve :: [Op] -> String
solve ops = go ops (Just (empty S)) (Just (empty Q)) (Just (empty P))
  where
    go [] Nothing Nothing Nothing = "impossible"
    go [] (Just _) Nothing Nothing = "stack"
    go [] Nothing (Just _) Nothing = "queue"
    go [] Nothing Nothing (Just _) = "priority queue"
    go [] _ _ _ = "not sure"
    go (Push x : xs) s q p = go xs (push x <$> s) (push x <$> q) (push x <$> p)
    go (Pop x : xs) s q p = go xs (s >>= pop x) (q >>= pop x) (p >>= pop x)

data Op = Push Int | Pop Int deriving (Eq, Show)

instance Read Op where
  readsPrec _ s =
    case words s of
      ["1", x] -> [(Push (read x), "")]
      ["2", x] -> [(Pop (read x), "")]
      _ -> []

data T = S | Q | P deriving (Eq, Show)

type Bag a = (T, [a])

empty :: T -> Bag a
empty t = (t, [])

push :: (Ord a) => a -> Bag a -> Bag a
push x (S, xs) = (S, x : xs)
push x (Q, xs) = (Q, xs ++ [x])
push x (P, xs) = (P, insert x xs)
  where
    insert y [] = [y]
    insert y ys@(z : zs)
      | y >= z = y : ys
      | otherwise = z : insert y zs

pop :: (Eq a) => a -> Bag a -> Maybe (Bag a)
pop _ (_, []) = Nothing
pop y (t, x : xs)
  | x == y = Just (t, xs)
  | otherwise = Nothing
