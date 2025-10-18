import System.Exit (exitSuccess)
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin LineBuffering
  play 1 1000

play :: Int -> Int -> IO ()
play l h
  | l > h = return ()
  | otherwise = do
      let m = (l + h) `div` 2
      print m
      hFlush stdout
      r <- fmap (takeWhile (/= '\r')) getLine
      case r of
        "correct" -> exitSuccess
        "lower" -> play l (m - 1)
        "higher" -> play (m + 1) h
        _ -> return ()
