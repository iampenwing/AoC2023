# AoC2023

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
