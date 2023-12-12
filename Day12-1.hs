import Data.List

testData = "???.### 1,1,3"

testLine = "???.###"
testCheck = [1,1,3]

makeFillers :: Int -> Int -> String
makeFillers 0 0 = ""
makeFillers working 0 = '.':(makeFillers (working - 1) 0)
makeFillers working broken  = '#':(makeFillers working (broken - 1))

fillLine :: String -> String -> String
fillLine line "" = line
fillLine (l:ls) (x:xs) 
  | l == '?'  = x:(fillLine ls xs)
  | otherwise = fillLine ls (x:xs)

filterDuplicates :: [String] -> [String]
filterDuplicates [] = []
filterDuplicates (x:xs) = x:(filterDuplicates (filter (/= x) xs))

isValidLine :: [Int] -> String -> Bool
isValidLine [0] "" = True
isValidLine (0:xs) (l:ls)
  | l == '#' = False
  | otherwise = isValidLine xs ls
isValidLine (x:xs) (l:ls)
  | l == '.' = isValidLine (x:xs) ls
  | l == '#' = isValidLine ((x-1):xs) ls
  
  
main :: IO ()
main = do
  let workingt = (length testLine) - (sum testCheck)
      workingk = length (filter (\x -> x == '.') testLine)
      unknowns = length (filter (\x -> x == '?'))
      myfill = (makeFillers 1 (workingt-workingk))  
      in  
        putStrLn (show (map (isValidLine testCheck) (map (fillLine testLine) (filterDuplicates (permutations myfill)))))
