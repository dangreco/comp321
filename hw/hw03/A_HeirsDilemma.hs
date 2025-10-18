import Control.Monad (guard)
import Data.Foldable (foldl')
import Data.List (permutations)

main :: IO ()
main = interact $ unlines . map (show . length . uncurry valid . parse) . lines
  where
    parse :: String -> (Int, Int)
    parse s =
      let [l, h] = map read (words s) :: [Int]
       in (l, h)

choose :: Int -> [a] -> [[a]]
choose 0 _ = [[]]
choose _ [] = []
choose k (x : xs) = map (x :) (choose (k - 1) xs) ++ choose k xs

digitsToInt :: [Int] -> Int
digitsToInt = foldl' (\ !acc d -> acc * 10 + d) 0

valid :: Int -> Int -> [Int]
valid l h = do
  combo <- choose 6 [1 .. 9]
  let s = sum combo
  guard $ notElem 3 combo || s `mod` 3 == 0
  guard $ notElem 9 combo || s `mod` 9 == 0

  perm <- permutations combo
  let n = digitsToInt perm

  guard $ n >= l && n <= h

  let lastD = last perm
  guard $ notElem 2 combo || even lastD
  guard $ notElem 5 combo || lastD == 5

  guard $ all (\d -> n `mod` d == 0) perm
  return n
