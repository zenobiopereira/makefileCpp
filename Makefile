# Tipo do arquivo executável de saída ##
###	TYPE =.exe ###
# Alocar o lugar onde está o seu projeto ##
# Adicionar "$(prefix)/" antes de cada uma das varíaveis que referenciam uma pasta interna do Projeto ##
###	prefix =C/Users/Administrador/Desktop/Projeto ###
# Nome que o executável receberá ##
APPNAME =twoPlusThree
# Pasta include onde estão os cabeçalhos ".h" ##
INCDIR =include
#CC=gcc
 # Compilador que será utilizado (g++ caso c++) ##
CXX=g++
 #std=c++11# # Flags que serão utilizada ao compilar, com -I para a inclusão do diretório contendo os cabeçalhos. ##
CPPFLAGS=-Wall -pedantic -std=c++11 -I $(INCDIR)
 # Pasta source onde estão as funções. ##
SRCDIR =src
 # Pasta application ##
APPDIR =application
# Pasta bin onde ficará o executável após o fim da compilação ##
BINDIR =bin
 # Pasta build onde ficarão todos os pontos ".o" advindos dos vários ".c" ##
OBJDIR=build
# Pasta test onde ficarão todos os testes relacionados as funções da aplicação ##
TESTDIR=test
# Pasta local lib onde ficarão todas as bibliotecas relacionadas à aplicação e ao google test ##
LIBDIR=lib
# Lugar onde vai ser criado o executavel e seu nome ##
BUILD =$(OBJDIR)/$(APPNAME)#$(TYPE)
# Comando para gerar a lib a partir do ".o" na pasta bin ##
ARR=ar rs
# Libs internas do Google Test ###
GTLIB =$(wildcard $(GTEST_DIR)/*.a)
# Flags relacionadas ao Google Test já com a inserção da biblioteca interna do Google Testes ###
GTEST_CFLAGS +=-g -Wall -Wextra -pthread
GTEST_DIR =gtest
GTESTCPPFLAGS +=-isystem $(GTEST_DIR)/include
GTEST_HEADERS =$(wildcard $(GTEST_DIR)/include/gtest/*.h) $(wildcard $(GTEST_DIR)/include/gtest/Internal/*.h)
GTEST_SRCS_ =$(wildcard $(GTEST_DIR)/src/*.cc) $(wildcard $(GTEST_DIR)/src/*.h) $(GTEST_HEADERS)

# Referência à todos os .a existentes na LIBDIR aka, lib interna ##
LIB =$(wildcard $(LIBDIR)/*.a)
# Referência à todos os .cpp da pasta APPDIR (Application) ##
APP =$(wildcard $(APPDIR)/*.cpp)
# Referência à todos os .cpp do diretório SRCDIR (Source) ##
SRC =$(wildcard $(SRCDIR)/*.cpp)
# Referência à todos os .cpp do diretório TESTDIR (Test) ##
TST =$(wildcard $(TESTDIR)/*.cpp)
#Fala que OBJS vai receber arquivos .cpp vindos do path SRCDIR, os .o advindos de BINDIR e todos os .c contidos em SRCDIR (BINDIR tem arquivos.o e SRC declarado acima.) ##
OBJS =$(patsubst $(SRCDIR)/%.cpp,$(BINDIR)/%.o,$(SRC))
#Fala que APPOBJ vai receber os arquivos .cpp vindos do path APPDIR, os .o advindos de BINIR e todos os .c contidos em APPDIR. (BINDIR tem arquivos.o e APP declarado acima) ##
APPOBJ =$(patsubst $(APPDIR)/%.cpp,$(BINDIR)/%.o,$(APP))


# O executavel ~teste~ sera criado no diretorio build utilizando os .o advindos de APPDIR e SRCDIR que estao armazenados na pasta referente ao BINDIR ##
$(BUILD): $(OBJS) $(APPOBJ)
# Codigo aplicado ao terminal criando o executavel ##
### Exemplo retirado de uma compilação teste: g++ -o build/testando bin/testando.o bin/soma.o -Wall -pedantic -std=c++11 -I include #
### Retirar o "@" do início para ver o código escrito no terminal ###
	@echo '------------------------Compilling files--------------------------'
	@$(CXX) -o $(BUILD) $(APPOBJ) $(OBJS) $(CPPFLAGS)
	@echo '-----------------Type:' ./$(BUILD) 'to run the file-----------------'

# Transforma .cpp em .o levando para o diretorio de Obj ##
### Exemplo retirado de uma compilação teste: g++ -Wall -pedantic -std=c++11 -I include -o bin/testando.o -c application/testando.cpp ###
$(BINDIR)/%.o: $(APPDIR)/%.cpp
# $@ refere-se a regra definida acima (%.o) e $< refere-se a primeira dependência (%.cpp) ##
# Retirar o "@" do início para ver o código escrito no terminal ###
	@$(CXX) $(CPPFLAGS) -o $@ -c $< 

# Transforma .cpp em .o levando para o diretorio de Obj ##
### Exemplo retirado de uma compilação teste: g++ -Wall -pedantic -std=c++11 -I include -o bin/soma.o -c src/soma.cpp ###
$(BINDIR)/%.o: $(SRCDIR)/%.cpp
# $@ refere-se a regra definida acima (%.o) e $< refere-se a primeira dependência (%.cpp) ##
# Retirar o "@" do início para ver o código escrito no terminal ###
	@$(CXX) $(CPPFLAGS) -o $@ -c $< 

.PHONY: clean mrproper lib app test
### Função que deleta todos os objetos tanto da Bin quanto o executável da parta Build para re-compilação ###
clean:
	@echo '----Erased all files from Build and Bin directories, Erased run_test from $(TESTDIR) and the libs/obj from main project ----'
	@rm -f $(BINDIR)/*.o $(OBJDIR)/* $(LIBDIR)/$(APPNAME).a $(TESTDIR)/run_test *.o *.a
### Segunda que deleta todos os objetos tanto da Bin quanto o executável da parta Build porém também deleta a biblioteca gerada pelo make lib###
mrproper:
	@echo '-----------------Erased all files from Build and Bin directories and the run_test from $(TESTDIR)-----------------'
	@rm -f $(BINDIR)/*.o $(OBJDIR)/* $(LIBDIR)/$(APPNAME).a $(TESTDIR)/run_test
### Funcão que testa se a Lib local da aplicação já existe ou se ela precisa ser gerada ###
lib:
ifeq ($(wildcard $(LIBDIR)/*.a), $(LIBDIR)/$(APPNAME).a)
	@echo '----------------- Internal Lib already exists -----------------'
	@ls $(LIBDIR)
else 
	@$(CXX) -c $(APP) -I $(INCDIR) -o $(BINDIR)/$(APPNAME)_lib.o
	@$(ARR) $(LIBDIR)/$(APPNAME).a $(BINDIR)/$(APPNAME)_lib.o
	@echo '----------------- Local application lib created -----------------'
endif
 # Função que cria os testes relacionados a aplicação como um todo caso a Lib já exista, caso não, ele primeiro irá criar a lib interna ###
 # para então criar o executável de tests  ###
#test:
#ifeq ($(wildcard $(LIBDIR)/*.a), $(LIBDIR)/$(APPNAME).a)
#	@$(CXX) $(TST) $(GTLIB) $(LIB) $(GTEST_CFLAGS) -o $(TESTDIR)/run_test
#else
#	@make lib
#	@$(CXX) $(TST) $(wildcard $(GTEST_DIR)/*.a) $(GTEST_CFLAGS) -o $(TESTDIR)/run_test
#	@echo '----------------- run_test is now ready to run -----------------'
#endif
gtest-all.o : $(GTEST_SRCS_)
	@$(CXX) $(GTESTCPPFLAGS) -I$(GTEST_DIR) $(GTEST_CFLAGS) -c \
	 $(GTEST_DIR)/src/gtest-all.cc
#
gtest_main.o : $(GTEST_SRCS_)
	@$(CXX) $(GTESTCPPFLAGS) -I$(GTEST_DIR) $(GTEST_CFLAGS) -c \
	 $(GTEST_DIR)/src/gtest_main.cc
#
gtest.a : gtest-all.o
	@$(ARR) $@ $^
#
gtest_main.a : gtest-all.o gtest_main.o
	@$(ARR) $@ $^
testLib:
	-@make gtest-all.o
	-@make gtest_main.o
	-@make gtest.a
	-@make gtest_main.a
	@echo "------------------- Libs and Objs created at main -------------------"
	@ls *.a *.o
	@echo "------------------- Exec run_test on $(TESTDIR)  -------------------"
	@ls ./test
#gtest:
#	@git submodule add https://github.com/google/googletest.git
#	@git submodule init
#	@git submodule update
teste.o : $(wildcard $(TESTDIR)/*.cpp) $(wildcard $(INCDIR)/*.h) $(GTEST_HEADERS)
	@$(CXX) $(GTESTCPPFLAGS) $(GTEST_CFLAGS) -c $(TESTDIR)/test.cpp

run_test : test.o gtest_main.a
	@$(CXX) $(GTESTCPPFLAGS) $(GTEST_CFLAGS) -lpthread $^ -o $@
test:
ifeq ($(wildcard $(LIBDIR)/*.a), $(LIBDIR)/$(APPNAME).a)
	-@make teste.o
	-@make run_test
	-@rm test.o
	-@mv run_test ./test
else
	-@make lib
	-@make teste.o
	-@make run_test
	-@rm test.o
	-@mv run_test ./test
endif
	@echo "------------------- Your run_test is ready -------------------"