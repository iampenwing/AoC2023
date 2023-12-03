# AoC2023

## My Stats

I'm doing this from the UK and so usually getting up several hours after the puzzle goes live so, yeah, I aint scoring points on the global leaderboard.

For up to about Day 10 I am not working so I can get started whenever. Days 11-15 I am in work so might have to prioritise that...

| Day | Part 1 Time | Part 1 Rank | Part 2 Time | Part 2 Rank |
| --- | --- | --- | --- | --- |
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
