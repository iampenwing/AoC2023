-- AdventOfCode 2023 Day 7, Puzzle 2
-- Camel Cards
-- https://adventofcode.com/2023/day/7

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import Data.List
import System.Environment
import AoCLib.AoCLib as AoC

makeHand :: String -> ([Int], Int, Int)
makeHand s = ((map rankCard hand), (maximum (map getType (makeWild hand))), (read bid)::Int)
  where (hand:(bid:_)) = splitOn " " s

makeWild :: String -> [String]
makeWild (x:[])
  | x == 'J'  = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"]
  | otherwise = [[x]]
makeWild (x:xs)
  | x == 'J' = (map (\y -> ('2':y)) (makeWild xs)) ++
               (map (\y -> ('3':y)) (makeWild xs)) ++
               (map (\y -> ('4':y)) (makeWild xs)) ++
               (map (\y -> ('5':y)) (makeWild xs)) ++
               (map (\y -> ('6':y)) (makeWild xs)) ++
               (map (\y -> ('7':y)) (makeWild xs)) ++
               (map (\y -> ('8':y)) (makeWild xs)) ++
               (map (\y -> ('9':y)) (makeWild xs)) ++
               (map (\y -> ('T':y)) (makeWild xs)) ++
               (map (\y -> ('Q':y)) (makeWild xs)) ++
               (map (\y -> ('K':y)) (makeWild xs)) ++
               (map (\y -> ('A':y)) (makeWild xs))
  | otherwise = (map (\y -> (x:y)) (makeWild xs))


getType :: String -> Int
getType s
  | isFiveOfAKind ss  = 6
  | isFourOfAKind ss  = 5
  | isFullHouse ss    = 4
  | isThreeOfAKind ss = 3
  | isTwoPair ss      = 2
  | isOnePair ss      = 1
  | otherwise         = 0
  where ss = sort s

isFiveOfAKind :: String -> Bool
isFiveOfAKind (a:(b:(c:(d:(e:_)))))
  | a==b && b==c && c==d && d==e   = True
  | otherwise                      = False

isFourOfAKind :: String -> Bool
isFourOfAKind (a:(b:(c:(d:(e:_)))))
  | a==b && b==c && c==d = True
  | b==c && c==d && d==e = True
  | otherwise            = False

isThreeOfAKind :: String -> Bool
isThreeOfAKind (a:(b:(c:(d:(e:_)))))
  | a==b && b==c = True
  | b==c && c==d = True
  | c==d && d==e = True
  | otherwise    = False

isFullHouse :: String -> Bool
isFullHouse (a:(b:(c:(d:(e:_)))))
  | a==b && b==c && d==e = True
  | a==b && c==d && d==e = True
  | otherwise            = False

isTwoPair :: String -> Bool
isTwoPair (a:(b:(c:(d:(e:_)))))
  | a==b && c==d = True
  | b==c && d==e = True
  | a==b && d==e = True
  | otherwise    = False

isOnePair :: String -> Bool
isOnePair (a:(b:(c:(d:(e:_)))))
  | a==b      = True
  | b==c      = True
  | c==d      = True
  | d==e      = True
  | otherwise = False
  
sortHands :: [([Int], Int, Int)] -> [([Int], Int, Int)] -> [([Int], Int, Int)]
sortHands [] acc = acc
sortHands (x:xs) acc = sortHands xs (insertHand x acc)

insertHand :: ([Int], Int, Int) -> [([Int], Int, Int)] -> [([Int], Int, Int)]
insertHand x [] = [x]
insertHand x (a:acc)
  | lowerHand x a = (x:(a:acc))
  | otherwise     = a:(insertHand x acc)

lowerHand :: ([Int], Int, Int) -> ([Int], Int, Int) -> Bool
lowerHand (testHand, testRank, _) (matchHand, matchRank, _)
  | testRank < matchRank  = True
  | testRank == matchRank = lowerHand_ testHand matchHand
  | otherwise             = False

lowerHand_ :: [Int] -> [Int] -> Bool
lowerHand_ [] _ = False
lowerHand_ (x:xs) (y:ys)
  | x < y     = True
  | x == y    = lowerHand_ xs ys
  | otherwise = False

rankCard :: Char -> Int
rankCard x
  | x == 'A' = 14
  | x == 'K' = 13
  | x == 'Q' = 12
  | x == 'J' = 1
  | x == 'T' = 10
  | x == '9' = 9
  | x == '8' = 8
  | x == '7' = 7
  | x == '6' = 6
  | x == '5' = 5
  | x == '4' = 4
  | x == '3' = 3
  | x == '2' = 2

scoreHands :: [([Int], Int, Int)] -> Int -> Int -> Int
scoreHands [] _ acc = acc
scoreHands ((_, _, bid):hands) rank acc = scoreHands hands (rank + 1) (acc + (bid * rank))

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = scoreHands (sortHands (map makeHand (lines fileContents)) []) 1 0
    in putStrLn (show answer)
