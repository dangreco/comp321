{-
Input format:
- arbitrary number of test case
- each test case follows:
    - one line with an integer n (1 <= n <= 1000)
    - one line with n integers (each between -10^6 and 10^6
    - one line with an integer m (1 <= m <= 25)
    - one line with m integers (each between -10^6 and 10^6)
-}

import Data.ByteString.Lazy.Char8 qualified as BS
import Data.List (uncons)
import Data.Maybe (fromJust)

main :: IO ()
main = BS.interact $ BS.unlines . map (BS.pack . show . solve) . parse . BS.lines
  where
    parse :: [BS.ByteString] -> [(Int, [Int], Int, [Int])]
    parse [] = []
    parse (x : xs) =
      let n = fst $ fromJust $ BS.readInt x
          (ns, xs') = splitAt n xs
          ns' = map (fst . fromJust . BS.readInt) ns
          m = fst $ fromJust $ BS.readInt (fst $ fromJust $ uncons xs')
          ms = map (fst . fromJust . BS.readInt) (take m $ drop 1 xs')
          xs'' = drop (m + 1) xs'
       in (n, ns', m, ms) : parse xs''

solve :: (Int, [Int], Int, [Int]) -> [Int]
solve (n, ns, m, ms) = []
