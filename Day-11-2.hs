-- AdventOfCode 2023 Day X, Puzzle 1
-- TITLE
-- https://adventofcode.com/2023/day/X


-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

testData = ["...#......",".......#..","#.........","..........","......#...",".#........",".........#","..........",".......#..","#...#....."]

expandUniverse :: [String] -> Integer -> [Integer]
expandUniverse [] _ = []
expandUniverse (x:xs) row
  | elem '#' x = (expandUniverse xs (row + 1))
  | otherwise  = row:(expandUniverse xs (row + 1))

findGalaxies :: [String] -> Integer -> [(Integer, Integer)]
findGalaxies [] _ = []
findGalaxies (x:xs) row  = (findGalaxies_ x 0 row) ++ (findGalaxies xs (row + 1))

findGalaxies_ :: String -> Integer -> Integer -> [(Integer, Integer)]
findGalaxies_ [] _ _ = []
findGalaxies_ (x:xs) col row
  | x == '#'  = (col, row):(findGalaxies_ xs (col + 1) row)
  | otherwise = findGalaxies_ xs (col + 1) row

makePairs :: [(Integer, Integer)] -> [(Integer, Integer)] -> [((Integer, Integer), (Integer, Integer))]
makePairs [] _ = []
makePairs _ [] = []
makePairs x y = (map (\a -> ((head x), a)) y) ++ (makePairs (tail x) (tail y))

getManDistance :: ((Integer, Integer), (Integer, Integer)) -> [Integer] -> [Integer] -> Integer
getManDistance ((c1, r1), (c2,r2)) eCols eRows = (getAcross (min c1 c2) (max c1 c2) eCols) + (getAcross (min r1 r2) (max r1 r2) eRows)

getAcross :: Integer -> Integer -> [Integer] -> Integer
getAcross start finish exp
  | start == finish = 0
  | elem start exp  = 1000000 + (getAcross (start + 1) finish exp)
  | otherwise       = 1 + (getAcross (start + 1) finish exp)


main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let universe = (lines fileContents)
      galaxies = findGalaxies universe 0
      expandedRows = expandUniverse universe 0
      expandedCols = expandUniverse (rotateGrid universe) 0
      pairs = makePairs galaxies (tail galaxies)
      answer = foldr1 (+) (map (\x -> getManDistance x expandedCols expandedRows) pairs)
         in putStrLn (show answer)
