module AoCLib.AoCLib
  (
    myReadInt,
    countLists,
    commonElement,
    splitListInHalf,
    findDuplicate,
    packRucksack,
    findCommon,
    findCommonElement,
    findUniqueSequence,
    getLast,
    getDigits,
    getFirstDigit,
    getLastDigit
  ) where

import qualified Data.Set as Set

myReadInt :: [Char] -> Int
myReadInt ('+':xs) = read xs ::Int
myReadInt x = read x :: Int

countLists :: [String] -> [Int]
countLists [] = []
countLists (x:xs) =
  let (topCount, rest) = (iCountLists 0 (x:xs))
  in (topCount:(countLists rest))

iCountLists :: Int -> [String] -> (Int, [String])
iCountLists count [] = (count, [])
iCountLists count ("":xs) = (count, xs)
iCountLists count (x:xs) = iCountLists (count + (myReadInt x)) xs

commonElement :: [String] -> Char
commonElement ((x:xs):ys) =
  if (commonElementHelper x ys)
  then x
  else commonElement (xs:ys)

commonElementHelper :: Char -> [String] -> Bool
commonElementHelper _ [] = False
commonElementHelper c ([]:ys) = False
commonElementHelper c ((x:xs):[]) =
  if (c == x)
  then True
  else commonElementHelper c (xs:[])
commonElementHelper c ((x:xs):ys) =
  if (c == x)
  then commonElementHelper c ys
  else commonElementHelper c (xs:ys)

splitListInHalf :: String -> (String, String)
splitListInHalf ls = splitAt ((length ls) `div` 2) ls

findDuplicate :: (String, String) -> Char
findDuplicate ((x:xs), y) =
  if (elem x y)
     then x
     else (findDuplicate (xs, y))

packRucksack :: String -> (Set.Set Char, Set.Set Char)
packRucksack ls = let (compartment1, compartment2) = splitAt ((length ls) `div` 2) ls
                      in ((Set.fromList compartment1), (Set.fromList compartment2))

findCommon :: (Set.Set Char, Set.Set Char) -> Char
findCommon (compartment1, compartment2) = (head (Set.toList (Set.intersection compartment1 compartment2)))

findCommonElement :: [String] -> Char
findCommonElement (x:xs) = findCommonElementHelper (Set.fromList x) (map Set.fromList xs)

findCommonElementHelper :: Set.Set Char -> [Set.Set Char] -> Char
findCommonElementHelper c [] = head (Set.toList c)
findCommonElementHelper c (x:xs) = findCommonElementHelper (Set.intersection c x) xs

-- Note - for Day 6, this should return the START of the sequence (as a zero-indexed count), not the end (as a one-indexed count) as required, so add 4 to the results
findUniqueSequence :: Int -> String -> Int
findUniqueSequence lengthOfSequence searchString = findUniqueSequenceHelper 0 lengthOfSequence [] searchString

findUniqueSequenceHelper :: Int -> Int -> String -> String -> Int
findUniqueSequenceHelper startIndex _ _ [] = startIndex
findUniqueSequenceHelper startIndex sequenceLength [] (topOfSequence:restOfSequence) = findUniqueSequenceHelper (startIndex + 1) sequenceLength (topOfSequence:[]) restOfSequence 
findUniqueSequenceHelper startIndex sequenceLength (currentSequenceDrop:currentSequence) (nextChar:remainingSearchString)
  | (sequenceLength == ((length currentSequence) + 1)) 
    && (not uniqueSequence) = findUniqueSequenceHelper (startIndex +1) sequenceLength (currentSequence ++ nextChar:[]) remainingSearchString
  | (sequenceLength == ((length currentSequence) + 1)) 
    && uniqueSequence = startIndex
  | otherwise = findUniqueSequenceHelper (startIndex) sequenceLength ((currentSequenceDrop:currentSequence) ++ (nextChar:[])) remainingSearchString
  where uniqueSequence = isUniqueSequence (currentSequence ++ (nextChar:[]))
  
isUniqueSequence :: String -> Bool
isUniqueSequence [] = True
isUniqueSequence (topChar:restOfSequence) 
  | topChar `elem` restOfSequence = False
  | otherwise                     = isUniqueSequence restOfSequence
  
getLast :: [a] -> a
getLast (x:[]) = x
getLast (_:xs) = getLast xs

-- spelt out digits can overlap
getDigits :: String -> [Int]
getDigits [] = []
getDigits (x:xs)
  | x == '1' = (1:(getDigits xs))
  | x == '2' = (2:(getDigits xs))
  | x == '3' = (3:(getDigits xs))
  | x == '4' = (4:(getDigits xs))
  | x == '5' = (5:(getDigits xs))
  | x == '6' = (6:(getDigits xs))
  | x == '7' = (7:(getDigits xs))
  | x == '8' = (8:(getDigits xs))
  | x == '9' = (9:(getDigits xs))
  | x == '0' = (0:(getDigits xs))
  | (xLen >= 3) && (x == 'o') && ((head xs) == 'n') && ((head (tail xs)) == 'e') = (1:(getDigits (tail xs)))
  | (xLen >= 3) && (x == 't') && ((head xs) == 'w') && ((head (tail xs)) == 'o') = (2:(getDigits (tail xs)))
  | (xLen >= 5) && (x == 't') && ((head xs) == 'h') && ((head (tail xs)) == 'r') && ((head (tail (tail xs))) == 'e') && ((head (tail (tail (tail xs)))) == 'e') = (3:(getDigits (tail (tail (tail xs)))))
  | (xLen >= 4) && (x == 'f') && ((head xs) == 'o') && ((head (tail xs)) == 'u') && ((head (tail (tail xs))) == 'r') = (4:(getDigits (tail (tail xs)))) 
  | (xLen >= 4) && (x == 'f') && ((head xs) == 'i') && ((head (tail xs)) == 'v') && ((head (tail (tail xs))) == 'e') = (5:(getDigits (tail (tail xs))))
  | (xLen >= 3) && (x == 's') && ((head xs) == 'i') && ((head (tail xs)) == 'x') = (6:(getDigits (tail xs)))
  | (xLen >= 5) && (x == 's') && ((head xs) == 'e') && ((head (tail xs)) == 'v') && ((head (tail (tail xs))) == 'e') && ((head (tail (tail (tail xs)))) == 'n') = (7:(getDigits (tail (tail (tail xs)))))
  | (xLen >= 5) && (x == 'e') && ((head xs) == 'i') && ((head (tail xs)) == 'g') && ((head (tail (tail xs))) == 'h') && ((head (tail (tail (tail xs)))) == 't') = (8:(getDigits (tail (tail (tail xs)))))
  | (xLen >= 4) && (x == 'n') && ((head xs) == 'i') && ((head (tail xs)) == 'n') && ((head (tail (tail xs))) == 'e') = (9:(getDigits (tail (tail xs))))
  | otherwise = getDigits xs
  where xLen = length (x:xs)

-- spelt out digits can overlap
getFirstDigit :: String -> Int
getFirstDigit (x:xs)
  | x == '1' = 1
  | x == '2' = 2
  | x == '3' = 3
  | x == '4' = 4
  | x == '5' = 5
  | x == '6' = 6
  | x == '7' = 7
  | x == '8' = 8
  | x == '9' = 9
  | x == '0' = 0
  | (xLen >= 3) && (x == 'o') && ((head xs) == 'n') && ((head (tail xs)) == 'e') = 1
  | (xLen >= 3) && (x == 't') && ((head xs) == 'w') && ((head (tail xs)) == 'o') = 2
  | (xLen >= 5) && (x == 't') && ((head xs) == 'h') && ((head (tail xs)) == 'r') && ((head (tail (tail xs))) == 'e') && ((head (tail (tail (tail xs)))) == 'e') = 3
  | (xLen >= 4) && (x == 'f') && ((head xs) == 'o') && ((head (tail xs)) == 'u') && ((head (tail (tail xs))) == 'r') = 4
  | (xLen >= 4) && (x == 'f') && ((head xs) == 'i') && ((head (tail xs)) == 'v') && ((head (tail (tail xs))) == 'e') = 5
  | (xLen >= 3) && (x == 's') && ((head xs) == 'i') && ((head (tail xs)) == 'x') = 6
  | (xLen >= 5) && (x == 's') && ((head xs) == 'e') && ((head (tail xs)) == 'v') && ((head (tail (tail xs))) == 'e') && ((head (tail (tail (tail xs)))) == 'n') = 7
  | (xLen >= 5) && (x == 'e') && ((head xs) == 'i') && ((head (tail xs)) == 'g') && ((head (tail (tail xs))) == 'h') && ((head (tail (tail (tail xs)))) == 't') = 8
  | (xLen >= 4) && (x == 'n') && ((head xs) == 'i') && ((head (tail xs)) == 'n') && ((head (tail (tail xs))) == 'e') = 9
  | otherwise = getFirstDigit xs
  where xLen = length (x:xs)

-- spelt out digits can overlap
getLastDigit :: String -> Int
getLastDigit x = getLastDigit_ (reverse x)

getLastDigit_ :: String -> Int
getLastDigit_ (x:xs)
  | x == '1' = 1
  | x == '2' = 2
  | x == '3' = 3
  | x == '4' = 4
  | x == '5' = 5
  | x == '6' = 6
  | x == '7' = 7
  | x == '8' = 8
  | x == '9' = 9
  | x == '0' = 0
  | (xLen >= 3) && (x == 'e') && ((head xs) == 'n') && ((head (tail xs)) == 'o') = 1
  | (xLen >= 3) && (x == 'o') && ((head xs) == 'w') && ((head (tail xs)) == 't') = 2
  | (xLen >= 5) && (x == 'e') && ((head xs) == 'e') && ((head (tail xs)) == 'r') && ((head (tail (tail xs))) == 'h') && ((head (tail (tail (tail xs)))) == 't') = 3
  | (xLen >= 4) && (x == 'r') && ((head xs) == 'u') && ((head (tail xs)) == 'o') && ((head (tail (tail xs))) == 'f') = 4
  | (xLen >= 4) && (x == 'e') && ((head xs) == 'v') && ((head (tail xs)) == 'i') && ((head (tail (tail xs))) == 'f') = 5
  | (xLen >= 3) && (x == 'x') && ((head xs) == 'i') && ((head (tail xs)) == 's') = 6
  | (xLen >= 5) && (x == 'n') && ((head xs) == 'e') && ((head (tail xs)) == 'v') && ((head (tail (tail xs))) == 'e') && ((head (tail (tail (tail xs)))) == 's') = 7
  | (xLen >= 5) && (x == 't') && ((head xs) == 'h') && ((head (tail xs)) == 'g') && ((head (tail (tail xs))) == 'i') && ((head (tail (tail (tail xs)))) == 'e') = 8
  | (xLen >= 4) && (x == 'e') && ((head xs) == 'n') && ((head (tail xs)) == 'i') && ((head (tail (tail xs))) == 'n') = 9
  | otherwise = getLastDigit_ xs
  where xLen = length (x:xs)

