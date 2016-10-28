# parallel_computing_1st  
parallel computing assignments  

O programa principal o "parmul.cu"  
  
* para compilar execute o Makefile  
    $ make all  
    ou para arquiteturas que suportam precisão dupla:  
    $ make alld  
* para executar (lembrando de colocar os argumentos abaixo):  
    $ ./parmul.out nome_arquivo_saida TILE_WIDTH N_LOOP  
    (caso não sejam fornecidos os argumentos, argumentos padrão serão selecionados nome_arquivo_saida=results.dat  TILE_WIDTH=16, N_LOOP=2)  
    
    
        * nome_arquivo_saida =\> arquivo onde serão guardados os tempos de execução da computação.   
        * TILE_WIDTH=\> tamanho do ladrilho utilizado  
        * N_LOOP=\> quantidade de vezes que a multiplicação vai ser efetuada  
   

