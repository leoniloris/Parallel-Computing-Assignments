CC=nvcc
CFLAGS= -Xcompiler -fopenmp #-O3 -arch sm_30
DEB= -G -g 
DPREC= -arch=sm_32
LIB= -lgomp -lcudart -lcuda 
SOURCES= $(wildcard *.cu)
EXECNAME= $(SOURCES:.cu=.out)
alld:
	$(CC) -o $(EXECNAME) $(SOURCES) $(DPREC) $(LIB) $(CFLAGS)
dbg: 
	$(CC) -o $(EXECNAME) $(SOURCES) $(LIB) $(CFLAGS) $(DEB)
all: 
	$(CC) -o $(EXECNAME) $(SOURCES) $(LIB) $(CFLAGS)
clean:
	rm *.o *.linkinfo *.out *~ *.data
