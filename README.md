# AoC2023

## Day 1 Notes
Part 1 is simple enough - find the digits and make number from the first and last digits

Part 2 adds the idea that digits can be spelt out. 
<details>
  <summary>What is not made clear - and is necessary for the right result - </summary>
  
  is that spelt out "digits" can overlap - so `eightwo` is actually `82`, not `8wo` (or `eigh2` if your matching in reverse)

</details>

I added the `AoCLib.getDigits` function to do this including the overlapping (which I hate)

I also think I got composing functions right so I can map with `calibrate . AoC.getDigits` rather than  mapping with each separately.
