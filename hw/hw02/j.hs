{-
Working at the Restaurant

Description:
Simulate restaurant operations where Tom manages plates using two stacks.
Tom takes plates from tables, washes them, and organizes them efficiently.
He can perform DROP (add plates to washing pile), TAKE (move plates from
washing to clean pile), and MOVE (transfer multiple plates between piles)
operations. Track and output all operations performed.

Input Format:
- Multiple test cases, at most 50 total
- Each test case starts with line containing N (1 ≤ N ≤ 100,000)
- Next N lines contain operations:
 - "DROP m" or "TAKE m" where m > 0 (number of plates)
- Input ends with line containing N = 0

Output Format:
For each test case, output series of lines describing actual operations:
- "DROP i" (DROP 2 m) - Tom takes plate from waiter, drops i on pile 2
- "TAKE i" (TAKE 2 m) - Tom takes plate from top of pile 1, uses i, drops on pile 2
- "MOVE i->j" (MOVE 2->1 m) - Tom moves plate from top of pile i to pile j

Example:
Input:
4
DROP 100
TAKE 50
TAKE 50
DROP 1

Output:
DROP 2 100
MOVE 2->1 100
TAKE 1 50
TAKE 1 50
DROP 2 1

Constraints:
- At most 50 test cases
- 1 ≤ N ≤ 100,000 operations per test case
- Sum of all plate numbers in DROP/MOVE operations ≤ 100,000
- Cannot TAKE more plates than available
- Must output at most 6N lines per test case

Notes:
- Two piles: pile 1 (clean plates), pile 2 (washing pile)
- DROP: add plates to pile 2 (washing)
- TAKE: remove plates from pile 1 (clean), if pile 1 empty, first MOVE from pile 2
- MOVE: transfer plates from pile 2 to pile 1 when needed
- Optimize moves to minimize operations while respecting constraints
- Use stack operations (LIFO) for both piles
-}

main :: IO ()
main = pure ()

data Operation
  = Drop Int
  | Take Int
  | Move Int
  deriving (Show, Eq)

compress :: [Operation] -> [Operation]
compress [] = []
compress [x] = [x]
compress (Drop x : Drop y : xs) = compress (Drop (x + y) : xs)
compress (Take x : Take y : xs) = compress (Take (x + y) : xs)
compress (x : xs) = x : compress xs

solve :: [Operation] -> [Operation]
solve ops = go (compress ops) 0 0
  where
    go [] _ _ = []
    go (Drop m : xs) c2 c1 = Drop m : go xs (c2 + m) c1
    go (Take m : xs) c2 c1
      | m <= c1 = Take m : go xs c2 (c1 - m)
      | otherwise =
          let need = m - c1
              move = min need c2
           in Move move : Take (m - move) : go xs (c2 - move) 0
    go (Move _ : _) _ _ = error "Unexpected MOVE operation in input"
