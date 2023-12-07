# AoC2023

## My Stats

I'm doing this from the UK and so usually getting up several hours after the puzzle goes live so, yeah, I aint scoring points on the global leaderboard.

For up to about Day 10 I am not working so I can get started whenever. Days 11-15 I am in work so might have to prioritise that...

| Day | Part 1 Time | Part 1 Rank | Part 2 Time | Part 2 Rank |
| --- | --- | --- | --- | --- |
| 7 | 06:24:39 | 26888 | 06:48:13 | 21900 |
| 6 | 04:13:12 | 28274 | 04:23:11 | 27360 |
| 5 | 05:24:32 | 26711 | 09:41:50 | 18894 |
| 4 | 06:17:54 | 43931 | 06:42:04 | 34739 |
| 3 | 05:36:15 | 26554 | 06:55:39 | 25373 |
| 2 | 05:01:33 | 32533 | 08:42:10 | 48827 |
| 1 | 04:01:33 | 34750 | 06:38:35 | 33121 |

## Day 1 Notes
Part 1 is simple enough - find the digits and make number from the first and last digits

Part 2 adds the idea that digits can be spelt out. 
<details>
  <summary>What is not made clear - and is necessary for the right result - </summary>
  
  is that spelt out "digits" can overlap - so `eightwo` is actually `82`, not `8wo` (or `eigh2` if your matching in reverse)

  I added the `AoCLib.getDigits` function to do this including the overlapping (which I hate). Basically rather than skipping to the character after the end of the spelled out digit, it skips to the last character when continuing the search for digits. 

  I could also look at `getFirstDigit` and `getLastDigit` (based on a reversed list and backwards spelt digits) functions rather than finding all the digits then getting first and last...
</details>


I also think I got composing functions right so I can map with `calibrate . AoC.getDigits` rather than  mapping with each separately.

## Day 2 Notes
Well, this is definitely a puzzle where parsing the input into usable data structures was the biggest part of the challenge. I use a lot of shortcuts because of the simplicity of the data and there is no error checking. 

## Day 3 Notes
Eugh - I hate these grid ones...The parsing I did for Part 1 was insufficient for Part 2, but at least it was enough scaffolding to add some additional data to what I was pulling out and then refactor into a different format to use in Part 2. 

Why do I keep doing this to myself?!?

## Day 4 Notes
I finally got round to adding an `ints` style function to AoCLib (`getInts :: String -> [Int]`) - this is a function which extracts all Integers from a string. At the moment, it doesn't handle negative numbers - minus signs are just discarded as "rubbish"

## Day 5 Notes
Yeah, I knew simply making a list of all the seeds and running through for Part 2 was not going to work, but eugh the debugging on this one once I settled on the splitting ranges solution...

## Day 6 Notes
Recognised early onthat it was probably better to use the quadratic equation stuff to calculate this rather than testing each possible game.

Part 2 required escalating up the data types for the necessary precision (I was off by 1 because of precision issues first time I ran with `Ìnt`s and `Float`s rather than `Integer`s and `Double`s. 

## Day 7 Notes
Urghh... This would not have taken two and a half hours if I hadn't had a complete brainfart on Insertion Sorting - that took most of my debugging... **hint** you need the helper function to insert into the accumulator.
