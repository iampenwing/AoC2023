default: Day-01 Day-02 Day-03 Day-04 Day 05

veryclean: clean
	touch temp.o temp.hi
	rm *.o *.hi
	touch AoCLib/temp.o AoCLib/temp.hi
	rm AoCLib/*.o AoCLib/*.hi
	rm Day-01-1 Day-01-2

clean:
	touch temp~ 
	rm *~
	touch AoCLib/temp~
	rm AoCLib/temp~
	touch Inputs/temp~
	rm Inputs/*~
	touch TestInputs/temp~
	rm TestInputs/*~


Day-01: Day-01-1 Day-01-2

Day-01-1: Day-01-1.hs AoCLib/AoCLib.o
	ghc Day-01-1.hs

Day-01-2: Day-01-2.hs AoCLib/AoCLib.o
	ghc Day-01-2.hs

Day-02: Day-02-1 Day-02-2

Day-02-1: Day-02-1.hs AoCLib/AoCLib.o
	ghc Day-02-1.hs

Day-02-2: Day-02-2.hs AoCLib/AoCLib.o
	ghc Day-02-2.hs

Day-03: Day-03-1 Day-03-2

Day-03-1: Day-03-1.hs AoCLib/AoCLib.o
	ghc Day-03-1.hs

Day-03-2: Day-03-2.hs AoCLib/AoCLib.o
	ghc Day-03-2.hs

Day-04: Day-04-1 Day-04-2

Day-04-1: Day-04-1.hs AoCLib/AoCLib.o
	ghc Day-04-1.hs

Day-04-2: Day-04-2.hs AoCLib/AoCLib.o
	ghc Day-04-2.hs

Day-05: Day-05-1 Day-05-2

Day-05-1: Day-05-1.hs AoClib/AoCLib.o
	ghc Day-05-1.hs

Day-05-2: Day-05-2.hs AocLib/AoCLib.o
	ghc Day-05-2.hs

