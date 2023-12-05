-- AdventOfCode 2023 Day 5, Puzzle 1
-- If you give a seed a fertilizer
-- https://adventofcode.com/2023/day/5

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

parse :: [String] -> ([(Int, Int)], [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)])
parse (x:(_:xs)) = ((AoC.getInts x), toSoil, toFertilizer, toWater, toLight, toTemp, toHumidity, toLocation)
  where (toSoil:(toFertilizer:(toWater:(toLight:(toTemp:(toHumidity:(toLocation:_))))))) = map makeRange (splitOnBlank xs)

splitOnBlank :: [String] -> [[String]]
splitOnBlank [] = []
splitOnBlank xs = (new:(splitOnBlank rest))
  where (new, rest) = grabFirst xs []

grabFirst :: [String] -> [String] -> ([String], [String])
grabFirst [] acc = (reverse acc, [])
grabFirst ("":xs) acc = ((reverse acc), xs)
grabFirst (x:xs) acc = grabFirst xs (x:acc)
                       
makeRange :: [String] -> [(Int, Int, Int)]
makeRange [] = []
makeRange ("":_) = []
makeRange (x:xs)
  | f == 's' || f == 'f' || f == 'w' || f == 'l' || f == 't' || f == 'h' = makeRange xs
  | otherwise = (makeTuple (AoC.getInts x)):(makeRange xs)
  where
    f = head x
    makeTuple (a:(b:(c:_))) = (c ,b ,a)

followMaps :: ([Int], [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)],  [(Int, Int, Int)]) -> [Int]
followMaps (seeds, toSoil, toFertilizer, toWater, toLight, toTemp, toHumidity, toLocation) = map ((followMap toLocation) . (followMap toHumidity) . (followMap toTemp) . (followMap toLight) . (followMap toWater) . (followMap toFertilizer) . (followMap toSoil)) seeds

followMap :: [(Int, Int, Int)] -> Int -> Int
followMap [] x = x
followMap ((dest, source, len):ys) x
  | x >= source && x <= (source + len) = x + (dest - source)
  | otherwise = followMap ys x
  
main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = minimum (followMaps (parse (lines fileContents)))
         in putStrLn (show answer)
