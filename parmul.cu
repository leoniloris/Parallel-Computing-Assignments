#include <stdio.h>
#include <stdlib.h>
#include <time.h>
# include <omp.h>
//#define TILE_WIDTH 10
//#define N_LOOP 1
#define MAX_MATRIX_SIZE 1024
int MATRIX_SIZE,TILE_WIDTH,N_LOOP;

__host__ double compare(double * A,double * B,int MATRIX_SIZE){
double err=0;
double er=0;
	for (int i=0;i<MATRIX_SIZE*MATRIX_SIZE;i++)
		{  er = (A[i]-B[i])*(A[i]-B[i]);
		//printf("%f\n",er);
			if(er<0.1);
			else err=+er;}
		return err;
}
// parallel multiplication aqui!!!!!
__global__ void matrixMultiplyPar(double * A, double * B, double * C,
  		       int numARows, int numAColumns,
			       int numBRows, int numBColumns,
			       int numCRows, int numCColumns,int TILE_WIDTH) {
	 //for(int a=0;a<numBColumns*numBColumns;a++) C[a]=0.0;
    extern __shared__ double ds_MN[];
    int bx = blockIdx.x, by = blockIdx.y,
       tx = threadIdx.x, ty = threadIdx.y,
       Row = by * TILE_WIDTH + ty,
       Col = bx * TILE_WIDTH + tx;
    double Pvalue = 0.0;
    for (int m = 0; m < (numAColumns-1)/TILE_WIDTH+1; ++m) {
       if (Row < numARows && m*TILE_WIDTH+tx < numAColumns) ds_MN[ty*TILE_WIDTH+tx]= A[Row*numAColumns + m*TILE_WIDTH+tx];  //ds_M[ty*TILE_WIDTH+tx] = A[Row*numAColumns + m*TILE_WIDTH+tx];
       else  ds_MN[ty*TILE_WIDTH+tx] = 0.0;
       if (Col < numBColumns && m*TILE_WIDTH+ty < numBRows) ds_MN[TILE_WIDTH*TILE_WIDTH+ty*TILE_WIDTH+tx] = B[(m*TILE_WIDTH+ty)*numBColumns+Col];//ds_N[ty*TILE_WIDTH+tx] = B[(m*TILE_WIDTH+ty)*numBColumns+Col];
       else ds_MN[TILE_WIDTH*TILE_WIDTH+ty*TILE_WIDTH+tx]= 0.0;
       __syncthreads();
       for (int k = 0; k < TILE_WIDTH; ++k)
          Pvalue += ds_MN[ty*TILE_WIDTH+k] * ds_MN[TILE_WIDTH*TILE_WIDTH+k*TILE_WIDTH+tx];
       __syncthreads();
    }
    if (Row < numCRows && Col < numCColumns)
       C[Row*numCColumns+Col] = Pvalue;
       
}
// blocked sequencial multiplication aqui!!!!! (tileado)
__host__ void matrixMultiply(double * A, double * B, double * C,int numARows, int numAColumns,int numBRows, int numBColumns){
	for(int a=0;a<numBColumns*numBColumns;a++) C[a]=0.0;
	for ( int i=0; i<numAColumns; i+=TILE_WIDTH )
        for (int  j=0; j<numAColumns; j+=TILE_WIDTH )
            for (int k=0; k<numAColumns; k+=TILE_WIDTH )
                for (int y=i; y<min(i+TILE_WIDTH,numAColumns); y++ )
                    for (int x=j; x<min(j+TILE_WIDTH,numAColumns); x++ )
                        for (int z=k; z<min(k+TILE_WIDTH,numAColumns); z++ )
                            C[y*numAColumns+x] += A[y*numAColumns+z]*B[z*numAColumns+x];
                            
                            
                            
}
void Rand_matrix(double * M, int rows,int cols){	
	srand(time(NULL));
#pragma omp parallel for 
	for(int i=0;i<rows*cols;i++)
		M[i]=((double)(rand()%101)/100.00) - 0.5;
}
int main(int argc, char ** argv) {
	FILE *fp; // write results in a file
	if(argc<4){ // caso nao venha com argumentos
		printf(" Argumentos padrao selecionados\n resultados em 'results.dat'\n TILE_WIDTH=16\n cada multiplicaçao é executada apenas 2 vezes \n"); 
		fp = fopen("results.dat", "w+");
		TILE_WIDTH=16;
		N_LOOP=2;
	}
	else {
	fp = fopen(argv[1], "w+");
	TILE_WIDTH=atoi(argv[2]);
	N_LOOP=atoi(argv[3]);
	}
	cudaEvent_t start, stop;// so I can save performance information
	
	double *hostA, *hostB, *hostC,*deviceA,*deviceB,*deviceC,*hostC_seq;


	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	int numARows, numAColumns, numBRows, numBColumns, numCRows, numCColumns;	
	
	
	for (MATRIX_SIZE=8;MATRIX_SIZE<=MAX_MATRIX_SIZE ;MATRIX_SIZE*=2){
		float ms=0;
		numARows=numAColumns=numBRows=numBColumns=numCRows=numCColumns=MATRIX_SIZE;
		hostB=(double *)malloc(sizeof(double)*numBRows*numBColumns);
		hostA=(double *)malloc(sizeof(double)*numARows*numAColumns);
		hostC = (double *)malloc(sizeof(double) * numARows * numBColumns);
		hostC_seq = (double *)malloc(sizeof(double) * numARows * numBColumns);
		Rand_matrix(hostA, numARows, numAColumns);
		Rand_matrix(hostB, numARows, numAColumns);
		cudaMalloc(&deviceA, sizeof(double) * numARows * numAColumns);
		cudaMalloc(&deviceB, sizeof(double) * numBRows * numBColumns);
		cudaMalloc(&deviceC, sizeof(double) * numCRows * numCColumns);
		cudaMemcpy(deviceA, hostA, sizeof(double) * numARows * numAColumns, cudaMemcpyHostToDevice);
		cudaMemcpy(deviceB, hostB, sizeof(double) * numBRows * numBColumns, cudaMemcpyHostToDevice);
		dim3 dimGrid((numCColumns-1)/TILE_WIDTH+1, (numCRows-1)/TILE_WIDTH+1, 1);
		dim3 dimBlock(TILE_WIDTH, TILE_WIDTH, 1);

		
		// esta parte eu s`o vou executar qdo eu encontrar os valores `otimos
		cudaEventRecord(start);
		#pragma omp parallel for firstprivate (hostA,hostB,hostC_seq)
		for(int vez=1;vez<=N_LOOP;vez++){
		#pragma omp critical
			matrixMultiply(hostA,hostB,hostC_seq,numARows, numAColumns, numBRows, numBColumns);
//for(int az=0;az<numCRows*numCRows;az++) printf("%f\n",hostC_seq[az]);
			}
		#pragma omp barrier	
		cudaEventRecord(stop);cudaEventSynchronize(stop);cudaEventElapsedTime(&ms, start, stop);
		fprintf(fp,"%f ",ms/1000.0);
		
		/* @@@@@@@@@@@@@@@@@  parallel multiplication @@@@@@@@@@@@@@@@@ */
		cudaEventRecord(start);
		#pragma omp parallel for firstprivate ( deviceA,deviceB,deviceC)
		for(int vez=1;vez<=N_LOOP;vez++){
		#pragma omp critical
			matrixMultiplyPar<<<dimGrid, dimBlock,2*TILE_WIDTH*TILE_WIDTH*sizeof(double)>>>( deviceA,deviceB,deviceC,numARows,numAColumns,numBRows,numBColumns,numCRows,numCColumns,TILE_WIDTH);
			cudaThreadSynchronize();
		}
		#pragma omp barrier
		cudaEventRecord(stop);cudaEventSynchronize(stop);cudaEventElapsedTime(&ms, start, stop);
		cudaMemcpy(hostC, deviceC, sizeof(double) * numCRows * numCColumns, cudaMemcpyDeviceToHost);
		//for(int az=0;az<numCRows*numCRows;az++) printf("%f\n",hostC[az]);
		fprintf(fp,"%f\n",ms/1000.0);
		
		printf("erro acumulado %f\n",compare(hostC_seq,hostC,MATRIX_SIZE));
		
//for(int az=0;az<numCRows*numCRows;az++) printf("%f %f\n",hostC_seq[az],hostC[az]);
		free(hostA);
		free(hostB);
		free(hostC);
		free(hostC_seq);
		cudaFree(deviceA);	
		cudaFree(deviceB);	
		cudaFree(deviceC);	
		printf("%d out of %d \n",MATRIX_SIZE,MAX_MATRIX_SIZE );
	}	
	

	fclose(fp);
	return 0;	



}

