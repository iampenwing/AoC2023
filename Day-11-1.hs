-- AdventOfCode 2023 Day X, Puzzle 1
-- TITLE
-- https://adventofcode.com/2023/day/X


-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

expandUniverse :: [String] -> [String]
expandUniverse [] = []
expandUniverse (x:xs)
  | elem '#' x = x:(expandUniverse xs)
  | otherwise  = x:(x:(expandUniverse xs))

findGalaxies :: [String] -> Int -> [(Int, Int)]
findGalaxies [] _ = []
findGalaxies (x:xs) row  = (findGalaxies_ x 0 row) ++ (findGalaxies xs (row + 1))

findGalaxies_ :: String -> Int -> Int -> [(Int, Int)]
findGalaxies_ [] _ _ = []
findGalaxies_ (x:xs) col row
  | x == '#'  = (col, row):(findGalaxies_ xs (col + 1) row)
  | otherwise = findGalaxies_ xs (col + 1) row

makePairs :: [(Int, Int)] -> [(Int, Int)] -> [((Int, Int), (Int, Int))]
makePairs [] _ = []
makePairs _ [] = []
makePairs x y = (map (\a -> ((head x), a)) y) ++ (makePairs (tail x) (tail y))

getManDistance :: ((Int, Int), (Int, Int)) -> Int
getManDistance ((c1, r1), (c2,r2)) = (abs (c2-c1)) + (abs (r2-r1))

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let galaxies = findGalaxies (expandUniverse (rotateGrid (expandUniverse (lines fileContents)))) 0
      pairs = makePairs galaxies (tail galaxies)
      answer = foldr1 (+) (map getManDistance pairs)
         in putStrLn (show answer)
