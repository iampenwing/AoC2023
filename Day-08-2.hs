-- AdventOfCode 2023 Day 8, Puzzle 2
-- Haunted Wasteland
-- https://adventofcode.com/2023/day/8

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

followMap :: (String, [(String, String, String)]) -> [Int]
followMap (instructions, mappings) = map (followMap_ instructions instructions mappings 0) (findStartNodes mappings)

findStartNodes :: [(String, String, String)] -> [String]
findStartNodes [] = []
findStartNodes (((a:(b:(c:_))), _, _):ms)
  | c == 'A' = (a:(b:(c:[]))):(findStartNodes ms)
  | otherwise = findStartNodes ms

followMap_ :: String -> String -> [(String, String, String)] -> Int -> String -> Int
followMap_ [] instructions mappings n current = followMap_ instructions instructions mappings n current 
followMap_ (instruction:instructions) full mappings n currentNode 
  | atEnd currentNode = n
  | otherwise         = followMap_ instructions full mappings (n+1) (findNewPlace mappings currentNode instruction) 
        
atEnd :: String -> Bool
atEnd [] = True
atEnd (a:(b:(c:_)))
  | c =='Z'   = True 
  | otherwise = False

findNewPlace :: [(String, String, String)] -> String -> Char -> String
findNewPlace ((c, l, r):ms) current instruction
  | c == current && instruction == 'L' = l
  | c == current && instruction == 'R' = r
  | otherwise                          = findNewPlace ms current instruction

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldl1 (lcm) (followMap (parse (lines fileContents)))
         in putStrLn (show answer)
