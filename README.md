# Trabalho 1, Tópicos Especiais em Arquitetura de Computadores I
 
parallel computing first assignment 



##### 1 - Usando o programa principal ("parmul.cu")  
##### 2 - Usando o script principal ("run.sh" )  
## 1 - Usando o programa principal ("parmul.cu")  
* para compilar execute o Makefile  
    $ make all  
    ou para arquiteturas que suportam precisão dupla:  
    $ make alld  
* para executar (lembrando de colocar os argumentos abaixo):  
    $ ./parmul.out nome_arquivo_saida TILE_WIDTH N_LOOP  
    (caso não sejam fornecidos os argumentos, argumentos padrão serão selecionados nome_arquivo_saida=results.dat  TILE_WIDTH=16, N_LOOP=2)  
    
    
1 nome_arquivo_saida =\> arquivo onde serão guardados os tempos de execução da computação.   
2 TILE_WIDTH=\> tamanho do ladrilho utilizado  
3 N_LOOP=\> quantidade de vezes que a multiplicação vai ser efetuada  
     
o programa faz multiplicações com diversos tamanhos de matrizes, começando em matrizes 8x8, dobrando de tamanho até 1024x1024  
ao ser executado, ele mostra os passos (tamanhos das matrizes [8 out of 1024, 16 out of 1024 ...]) e mostra o erro acumulado entre a multiplicação sequencial ladrilhada e esta mesma paralela, também ladrilhada.
  
## 2 - Usando o script principal ("run.sh" )  
No script principal, o programa principal é iterado em 2 loops,  
um para o tamanho do ladrilho,  
e outro para a quantidade de vezes que a multiplicação serà executada (os 2 argumentos do parmul.out)   
  
os arquivos de saìda tem o padrão: (float ou double)_(TILE_WIDTH)-(N_LOOP)  
  
os gràficos foram gerados com o matlab.

