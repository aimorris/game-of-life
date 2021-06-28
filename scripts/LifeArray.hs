{-# OPTIONS_GHC -Wall #-}

-- Converts plaintext from Life Lexicon to an array

fileToArray :: FilePath -> IO [[Int]]
fileToArray x = stringToArray <$> readFile x

stringToArray :: String -> [[Int]]
stringToArray = map convertLine . lines . filter (/= '\t')
  where convertLine = map (\j -> if j == '.' then 0 else 1)