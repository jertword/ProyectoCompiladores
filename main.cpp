#include <iostream>
#include <fstream>
using namespace std;

#include "Lexer.hpp"


int main(int argc, char *argv[])
{
	if(argc <2){
		cout <<"Faltan argumentos"<<endl;
		exit(EXIT_FAILURE);
	}
	filebuf fb;
	fb.open(string(argv[1]), ios::in);
	if(!fb.is_open()){
		cout<<"Error al abrir el archivo"<<argv[1]<<endl;
		exit(EXIT_FAILURE);
	}

	istream is(&fb);
	Lexer lexer(&is);
	lexer.yylex();
	//Colocar el código para realizar el análisis léxico de un arhivo completo
	fb.close();
	return 0;
}
