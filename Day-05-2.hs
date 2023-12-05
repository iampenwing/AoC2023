-- AdventOfCode 2023 Day 5, Puzzle 2
-- If you give a seed a fertilizer
-- https://adventofcode.com/2023/day/5

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

parse :: [String] -> ([(Int, Int)], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))])
parse (x:(_:xs)) = ((makePairs (reverse (AoC.getInts x))), toSoil, toFertilizer, toWater, toLight, toTemp, toHumidity, toLocation)
  where (toSoil:(toFertilizer:(toWater:(toLight:(toTemp:(toHumidity:(toLocation:_))))))) = map (\x -> sortMap x []) (map makeMap (splitOnBlank xs))

makePairs :: [Int] -> [(Int, Int)]
makePairs [] = []
makePairs (x:(y:ys)) = (x, y):(makePairs ys)

splitOnBlank :: [String] -> [[String]]
splitOnBlank [] = []
splitOnBlank xs = (new:(splitOnBlank rest))
  where (new, rest) = grabFirst xs []

grabFirst :: [String] -> [String] -> ([String], [String])
grabFirst [] acc = (reverse acc, [])
grabFirst ("":xs) acc = ((reverse acc), xs)
grabFirst (x:xs) acc = grabFirst xs (x:acc)

-- makes a list of (sourceStart, sourceEnd), (destStart, destEnd)
makeMap :: [String] -> [((Int, Int), (Int, Int))]
makeMap [] = []
makeMap ("":_) = []
makeMap (x:xs)
  | f == 's' || f == 'f' || f == 'w' || f == 'l' || f == 't' || f == 'h' = makeMap xs
  | otherwise = (makeTuple (AoC.getInts x)):(makeMap xs)
  where
    f = head x
    makeTuple (a:(b:(c:_))) = ((b, (b+a-1)), (c, (c+a-1)))

sortMap :: [((Int, Int), (Int, Int))] -> [((Int, Int), (Int, Int))] -> [((Int, Int), (Int, Int))]
sortMap [] acc = acc
sortMap (x:xs) acc = sortMap xs (insertMap x acc)

insertMap :: ((Int, Int), (Int, Int)) -> [((Int, Int), (Int, Int))] -> [((Int, Int), (Int, Int))]
insertMap x [] = [x]
insertMap ((sourceStart, sourceEnd), (destStart, destEnd)) (((sS, sE), (dS, dE)):ys)
  | sourceStart < sS = ((sourceStart, sourceEnd), (destStart, destEnd)):(((sS, sE), (dS, dE)):ys)
  | otherwise = ((sS, sE), (dS, dE)):(insertMap ((sourceStart, sourceEnd), (destStart, destEnd)) ys)

followMaps :: ([(Int, Int)], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))], [((Int, Int), (Int, Int))]) -> [(Int, Int)]
followMaps (seeds, toSoil, toFertilizer, toWater, toLight, toTemp, toHumidity, toLocation) = flatten (map (followMap toLocation) (flatten (map (followMap toHumidity) (flatten (map (followMap toTemp) (flatten (map (followMap toLight) (flatten (map (followMap toWater) (flatten (map (followMap toFertilizer) (flatten (map (followMap toSoil) (makeSeeds seeds))))))))))))))

flatten :: [[(Int, Int)]] -> [(Int, Int)]
flatten [] = []
flatten (x:xs) = x ++ (flatten xs)

makeSeeds :: [(Int, Int)] -> [(Int, Int)]
makeSeeds [] = []
makeSeeds ((start, range):xs) = (start, (start+range-1)):(makeSeeds xs)

followMap :: [((Int, Int), (Int, Int))] -> (Int, Int) -> [(Int, Int)]
followMap [] x = [x]
followMap (((sourceStart, sourceEnd), (destStart, destEnd)):xs) (start, end)
  | end < sourceStart = (start, end):[]
  | start > sourceEnd = followMap xs (start, end)
  | start < sourceStart && end <= sourceEnd = ((start, (sourceStart-1)):((destStart, (destStart + (end-sourceStart))):[]))
  | start >= sourceStart && end > sourceEnd = ((start + conv), destEnd):(followMap xs ((sourceEnd + 1), end))
  | start >= sourceStart && end <= sourceEnd = ((destStart + depth), (end + conv)):[]
  | start < sourceStart && end > sourceEnd = ((start, (sourceStart - 1)):((destStart, destEnd):(followMap xs ((sourceEnd+1), end))))
  where conv = destStart - sourceStart
        depth = start - sourceStart


main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = minimum (map fst (followMaps (parse (lines fileContents))))
         in putStrLn (show answer)
