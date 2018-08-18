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
# Lugar onde vai ser criado o executavel e seu nome ##
BIN =$(BINDIR)/$(APPNAME)#$(TYPE)


# Referencia à todos os .cpp da pasta APPDIR (Application) ##
APP =$(wildcard $(APPDIR)/*.cpp)
# Referencia à todos os .cpp do diretório SRCDIR (Source) ##
SRC =$(wildcard $(SRCDIR)/*.cpp)
#Fala que OBJS vai receber arquivos .cpp vindos do path SRCDIR, os .o advindos de OBJDIR e todos os .c contidos em SRCDIR (OBJDIR tem arquivos.o e SRC declarado acima.) ##
OBJS =$(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(SRC))
#Fala que APPOBJ vai receber os arquivos .cpp vindos do path APPDIR, os .o advindos de OBJDIR e todos os .c contidos em APPDIR. (OBJDIR tem arquivos.o e APP declarado acima) ##
APPOBJ =$(patsubst $(APPDIR)/%.cpp,$(OBJDIR)/%.o,$(APP))


# O executavel ~teste~ sera criado no diretorio bin utilizando os .o advindos de APPDIR e SRCDIR que estao armazenados na pasta referente ao OBJDIR ##
$(BIN): $(OBJS) $(APPOBJ)
	@echo '------------------------Compilling files--------------------------'
	@echo '-----------------Type:' ./$(BIN) 'to run the file-----------------'
# Codigo aplicado ao terminal criando o executavel ##
### Exemplo retirado de uma compilação teste: g++ -o bin/testando build/testando.o build/soma.o -Wall -pedantic -std=c++11 -I include #
### Retirar o "@" do início para ver o código escrito no terminal ###
	@$(CXX) -o $(BIN) $(APPOBJ) $(OBJS) $(CPPFLAGS)


# Transforma .cpp em .o levando para o diretorio de Obj ##
### Exemplo retirado de uma compilação teste: g++ -Wall -pedantic -std=c++11 -I include -o build/testando.o -c application/testando.cpp ###
$(OBJDIR)/%.o: $(APPDIR)/%.cpp
# $@ refere-se a regra definida acima (%.o) e $< refere-se a primeira dependência (%.cpp) ##
# Retirar o "@" do início para ver o código escrito no terminal ###
	@$(CXX) $(CPPFLAGS) -o $@ -c $< 

# Transforma .cpp em .o levando para o diretorio de Obj ##
### Exemplo retirado de uma compilação teste: g++ -Wall -pedantic -std=c++11 -I include -o build/soma.o -c src/soma.cpp ###
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
# $@ refere-se a regra definida acima (%.o) e $< refere-se a primeira dependência (%.cpp) ##
# Retirar o "@" do início para ver o código escrito no terminal ###
	@$(CXX) $(CPPFLAGS) -o $@ -c $< 


.PHONY: clean mrproper
### Função que deleta todos os objetos tanto da Build quanto o executável da parta Bin para re-compilação ###
clean:
	@echo '-----------------Erased all files from Build and Bin directories-----------------'
	@rm -f $(OBJDIR)/*.o $(BINDIR)/*
mrproper: clean
	@rm -f $(OBJDIR)/*.o $(BINDIR)/*
