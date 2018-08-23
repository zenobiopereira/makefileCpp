# Um exemplo funcional e comentado de Makefile em C++


### Como Utilizar
1. Dê um pull ou faça download do projeto.
2. Extraia o Makefile na pasta do projeto o qual deseja utiliza-lo, após a criação das pastas necessárias listadas abaixo.
    * ./Projeto
        * src (Source Code).
        * include (Headers).
        * application (Functions And General Applications).
        * build (Objects).
        * bin (Executable).
3. Abra o terminal, entre na pasta relacionada ao projeto onde o Makefile foi extraído.
4. Mova os arquivos Makefile e a pasta "gtest" para dentro da pasta principal do seu projeto.
    **Considere $ como usuário root**
*   $/Desktop/makefileCpp cp -r gtest Projeto
*   $/Desktop/makefileCpp cp Makefile Projeto
5. Utilize o comando "make" para compilar o projeto após a criação dos seus arquivos principais tais quais includes, src e app.

# Commands #
* _make_ -> **Cria os ".o" na pasta bin e builda a aplicação na pasta build.**
* _make clean_ -> **Deleta todos os arquivos da pasta Bin/Build. o teste executável e os objetos/libs da pasta de projeto principal**
* _make testLib_ -> **Cria as libs e os ".o" necessários para compilação do run_tests.**
* _make lib_ -> **Cria a Lib interna do projeto.**
* _make test_ -> **Cria um teste único executável que recebe todos os testes da aplicação**




<!--
### How to use 
1. Get the full file.
2. Extract Makefile to your project after have created all the folders needed.
    *./Project
    *./Project/src (Source Code).
    *./Project/include (Headers).
    *./Project/application (Functions).
    *./Project/build (Objects).
    *./Project/bin (Executable).
3. Use the command "make" to build your application.
4. If Needed use "make clean" or "make mrproper" to clean the Build and Bin folders.
 -->
