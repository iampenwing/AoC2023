-- AdventOfCode 2023 Day 8, Puzzle 1
-- Haunted Wasteland
-- https://adventofcode.com/2023/day/8
-- Tidying up calibration information that an over-enthuisiastic elf has
-- prettified beyond easy usefulness

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

parse :: [String] -> (String, [(String, String, String)])
parse (instructions:(_:(mappings))) = (instructions, (map parseMapping mappings))

parseMapping :: String -> (String, String, String)
parseMapping (a:(b:(c:(_:(_:(_:(_:(d:(e:(f:(_:(_:(g:(h:(i:(_))))))))))))))))
  = ((a:(b:(c:[]))), (d:(e:(f:[]))), (g:(h:(i:[]))))

followMap :: (String, [(String, String, String)]) -> Int
followMap (instructions, mappings) = followMap_ instructions instructions mappings "AAA" 0

followMap_ :: String -> String -> [(String, String, String)] -> String -> Int -> Int
followMap_ [] instructions mappings current n = followMap_ instructions instructions mappings current n
followMap_ _ _ _ "ZZZ" n = n
followMap_ (instruction:instructions) full mappings currentPlace n = followMap_ instructions full mappings newPlace (n+1)
  where newPlace = findNewPlace mappings currentPlace instruction

findNewPlace :: [(String, String, String)] -> String -> Char -> String
findNewPlace ((c, l, r):ms) current instruction
  | c == current && instruction == 'L' = l
  | c == current && instruction == 'R' = r
  | otherwise                          = findNewPlace ms current instruction

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = followMap (parse (lines fileContents))
         in putStrLn (show answer)
