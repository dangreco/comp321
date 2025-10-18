import Control.Monad (replicateM)
import Data.Bits (shiftL, testBit)

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine :: IO [Int]
  pairs <- map ((\[a, b] -> (a - 1, b - 1)) . map read . words) <$> replicateM m getLine :: IO [(Int, Int)]
  print $ count n pairs

count :: Int -> [(Int, Int)] -> Int
count n bad =
  let limit = 1 `shiftL` n :: Int
      valid mask = all (\(a, b) -> not (testBit mask a && testBit mask b)) bad
   in length [mask | mask <- [0 .. limit - 1], valid mask]
