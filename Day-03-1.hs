-- AdventOfCode 2023 Day 3, Puzzle 1
-- Gear Ratios
-- https://adventofcode.com/2023/day/3


-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

findNumbersAndSymbols :: [String] -> [(String, Int)]
findNumbersAndSymbols plan = findNumbersAndSymbols_ plan (0, 0) ((length (head plan)), (length plan))

findNumbersAndSymbols_ :: [String] -> (Int, Int) -> (Int, Int) -> [(String, Int)]
findNumbersAndSymbols_ [] _ _ = []
findNumbersAndSymbols_ plan (cx, cy) (mx, my)
  | cy >= my = []
  | cx >= mx = findNumbersAndSymbols_ plan (0, (cy+1)) (mx, my)
  | sym == '1' || sym == '2' || sym == '3' || sym == '4' || sym == '5' || sym == '6' || sym == '7' || sym =='8' || sym == '9' || sym == '0' =
      let (num, len) = (getNumber 0 0 (drop cx (plan!!cy)))
      in (((getSymbols plan (cx, cy) (mx, my) len), num):(findNumbersAndSymbols_ plan ((cx+len), cy) (mx,my)))
  | otherwise = findNumbersAndSymbols_ plan ((cx+1), cy) (mx, my) 
  where sym = (plan!!cy)!!cx

getNumber :: Int -> Int -> String -> (Int, Int)
getNumber n l [] = (n, l)
getNumber n l (y:ys)
  | y == '1' = getNumber ((n*10)+1) (l+1) ys
  | y == '2' = getNumber ((n*10)+2) (l+1) ys
  | y == '3' = getNumber ((n*10)+3) (l+1) ys
  | y == '4' = getNumber ((n*10)+4) (l+1) ys
  | y == '5' = getNumber ((n*10)+5) (l+1) ys
  | y == '6' = getNumber ((n*10)+6) (l+1) ys
  | y == '7' = getNumber ((n*10)+7) (l+1) ys
  | y == '8' = getNumber ((n*10)+8) (l+1) ys
  | y == '9' = getNumber ((n*10)+9) (l+1) ys
  | y == '0' = getNumber ((n*10)+0) (l+1) ys
  | otherwise = (n, l)

--             plan         start         size       length   symbols
getSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> String
getSymbols plan (cx, cy) (mx, my) l
  = stripDots ((getTopSymbols plan (cx, cy) (mx, my) l) ++
    (getLeftSymbols plan (cx, cy) (mx, my) l) ++
    (getRightSymbols plan (cx, cy) (mx, my) l) ++
    (getBottomSymbols plan (cx, cy) (mx, my) l))

getTopSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> String
getTopSymbols plan (cx, cy) (mx, my) l = if (cy == 0)
                                            then ""
                                            else take (l + 2) (drop (max (cx-1) 0) (plan!!(cy-1)))



getLeftSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> String
getLeftSymbols plan (cx, cy) (mx, my) l = if (cx == 0)
                                          then ""
                                          else [((plan!!cy)!!(cx-1))]


getRightSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> String
getRightSymbols plan (cx, cy) (mx, my) l = if (cx+l) >= mx
                                           then ""
                                           else [((plan!!cy)!!(cx+l))]
  
getBottomSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> String
getBottomSymbols plan (cx, cy) (mx, my) l = if (cy == (my-1))
                                            then ""
                                            else take (l + 2) (drop (max (cx-1) 0) (plan!!(cy+1)))

stripDots :: String -> String
stripDots [] = []
stripDots (x:xs)
  | x == '.' = stripDots xs
  | otherwise = (x:(stripDots xs))

getPartNumbers :: [(String, Int)] -> [Int]
getPartNumbers [] = []
getPartNumbers (([], _):xs) = getPartNumbers xs
getPartNumbers ((s, n):xs) = n:(getPartNumbers xs)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (getPartNumbers (findNumbersAndSymbols (lines fileContents)))
         in putStrLn (show answer)
