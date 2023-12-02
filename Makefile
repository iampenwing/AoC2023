default: Day-01 Day-02

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
