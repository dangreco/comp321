import Data.List (concatMap)
import System.IO (isEOF)

main :: IO ()
main = do
  s <- getLine
  let n = read s :: Int
  print $ supply n

supply :: Int -> Integer
supply n
  | n <= 0 = 0
  | n == 1 = 9
  | otherwise = go 2 (map fromIntegral [1 .. 9])
  where
    go :: Int -> [Integer] -> Integer
    go k prefixes
      | k > n = fromIntegral (length prefixes)
      | null prefixes = 0
      | otherwise =
          let k' = fromIntegral k :: Integer
              extend :: Integer -> [Integer]
              extend p =
                let base = p * 10
                 in [base + d | d <- [0 .. 9], (base + d) `mod` k' == 0]
              next = concatMap extend prefixes
           in go (k + 1) next
