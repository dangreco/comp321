dominoes :: Int -> Int
dominoes n = d n
  where
    d 0 = 1
    d 1 = 2
    d 2 = 3
    d n = d (n - 2) + 2 * a (n - 1)

    a 0 = 1
    a 1 = 2
    a 2 = 3
    a n = d (n - 1) + a (n - 2)
