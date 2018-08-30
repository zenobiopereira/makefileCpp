# Um exemplo funcional e comentado de Makefile em C++


## **IMPORTANTE: NÃO ESQUECER DE EDITAR OS PATHS DENTRO DO MAKEFILE PARA QUE OS NOMES DE APLICAÇÕES, OBJETOS E TESTES, CORRESPONDAM AO ESPERADO E NÃO A ESTE EXEMPLO**


### Como Utilizar
1. Dê um pull ou faça download do projeto.
2. Extraia o Makefile na pasta do projeto o qual deseja utiliza-lo, após a criação das pastas necessárias listadas abaixo.
    * ./Projeto
        * src (Source Code).
        * include (Headers).
        * application (Functions And General Applications).
        * build (Executable).
        * bin (Objects).
        * test (main_tests.cpp)
3. Abra o terminal, entre na pasta relacionada ao projeto onde o Makefile foi extraído.
4. Mova os arquivos Makefile e a pasta "gtest" para dentro da pasta principal do seu projeto.
    **Considere $ como root**
*   /Desktop/makefileCpp$ _cp -r gtest Projeto_
*   /Desktop/makefileCpp$ _cp Makefile Projeto_
5. **<font color="red"> Abra o Makefile e edite o nome da aplicação (APPNAME), da lib interna que será gerada (LIBNAME) e do (TESTNAME) para o nome do seu arquivo ".cpp" o qual contem todos os testes necessários que se encontra na pasta "Projeto/test", observe bem se dentro dos seus ".cpp" divididos na pasta de "application" e "src" o include corresponde a pasta correta.</font>**
5. Utilize o comando "make" para compilar a aplicação após a criação dos seus arquivos principais tais quais includes, src e app e edição dos paths dentro do Makefile.

# Commands #
* _make_ -> **Cria os ".o" na pasta bin e builda a aplicação na pasta build.**
* _make mrproper_ -> **Deleta todos os arquivos da pasta Bin/Build. (Utilizável ao desejar recompilar a aplicação e ou Objetos)**
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
