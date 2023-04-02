All: findMax
LIB=findMaxOf3.o
CC=gcc

findMax: findMax.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o: 
	$(CC) $(@:.o=.s) -g -c -o $@
