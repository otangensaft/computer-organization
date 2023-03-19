All: CtoF Miles2Kilometers KPH InchesToFt
LIB=libConversions.o
CC=gcc

InchesToFt: InchesToFt.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

CtoF: CtoF.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

Miles2Kilometers: Miles2Kilometers.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

KPH: KPH.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o: 
	$(CC) $(@:.o=.s) -g -c -o $@
