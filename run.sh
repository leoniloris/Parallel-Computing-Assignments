
set -x
make all
for N_LOOP in 1 10 100 1000
do
	for ((TILE_WIDTH=4; TILE_WIDTH <= 32 ; TILE_WIDTH*=2))
	do
	./parmul.out fl_$TILE_WIDTH-$N_LOOP $TILE_WIDTH $N_LOOP 
	done
done
make clean
echo 
echo EXECUTANDO PARA UMA ARQUITETURA QUE SUPORTA DOUBLE!!!
make alld
for N_LOOP in 1 10 100 1000
do
	for ((TILE_WIDTH=4; TILE_WIDTH <= 32 ; TILE_WIDTH*=2))
	do
	./parmul.out db_$TILE_WIDTH-$N_LOOP $TILE_WIDTH $N_LOOP 
	done
done
