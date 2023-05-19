%{
#include <iostream>
#include <string>
using namespace std;

#include "Lexer.hpp"

#undef YY_DECL
#define YY_DECL int Lexer::yylex()

%}

%option c++
%option outfile="Lexer.cpp"
%option yyclass="Lexer"
%option yylineno


proto "proto"
var "var"
constante "constante"
ent "ent"
dec32 "dec32"
dec64 "dec64"
logico "logico"
sin "sin"
estructura "estructura"
funcion "funcion"
imprimir "imprimir"
leer "leer"
si "si"
sino "sino"
segun "segun"
caso "caso"
predeterminado "predeterminado"
para "para"
devolver "devolver"
detener "detener"
continuar "continuar"
verdadero "verdadero"
falso "falso"
digito [0-9]
entero (digito)([_]?digito+)*
notacion [Ee]([+-])?entero
flotante ((entero.entero?|.entero)(notacion)?|enteronotacion)[FfDd]
letra [a-zA-ZáÁéÉíÍóÓúÚüÜñÑ]
runa '(letra|\[abntvr'\])'
id [letra_$][letra_$digito]*
cadena \"[^\n]*\"


%%

<INITIAL>{
  /* Ignorar espacios en blanco y saltos de línea */
  [ \t\n\r]+  {/* No hacer nada */}

  
  "/*"       { BEGIN(comentario); }
   <comentario>{
         "\n"      { cout << "Error: Comentario nunca se cierra en la línea " << yylineno << endl; return 0; }
        [^\n]+    {/* No hacer nada */}
        "*/"        { BEGIN(INITIAL); }
         .           { report_error("Carácter no válido"); }
}



  {runa}      { cout << "Runa" << yytext << endl; }
  {proto}     { cout << "Proto" << yytext << endl; }
  {var}       { cout << "Var" << yytext << endl; }
  {constante} { cout << "Constante" << yytext << endl; }
  {ent}       { cout << "Ent" << yytext << endl; }
  {dec32}     { cout << "Dec32" << yytext << endl; }
  {dec64}     { cout << "Dec64" << yytext << endl; }
  {logico}    { cout << "Lógico" << yytext << endl; }
  {sin}       { cout << "Sin" << yytext << endl; }
  {estructura} { cout << "Estructura" << yytext << endl; }
  {funcion}   { cout << "Función" << yytext << endl; }
  {imprimir}  { cout << "Imprimir" << yytext << endl; }
  {leer}      { cout << "Leer" << yytext << endl; }
  {si}        { cout << "Si" << yytext << endl; }
  {sino}      { cout << "Sino" << yytext << endl; }
  {segun}     { cout << "Según" << yytext << endl; }
  {caso}      { cout << "Caso" << yytext << endl; }
  {predeterminado} { cout << "Predeterminado" << yytext << endl; }
  {para}      { cout << "Para" << yytext << endl; }
  {devolver}  { cout << "Devolver" << yytext << endl; }
  {detener}   { cout << "Detener" << yytext << endl; }
  {continuar} { cout << "Continuar" << yytext << endl; }
  {verdadero} { cout << "Verdadero" << yytext << endl; }
  {falso}     { cout << "Falso" << yytext << endl; }
  {id}        { cout << "Identificador" << yytext << endl; }
  {entero}    { cout << "Entero" << yytext << endl; }
  {flotante}  { cout << "Flotante" << yytext << endl; }
  {cadena}    { cout << "Cadena" << yytext << endl; }
  

  .         { cout << "Error en la línea " << lexer.getLine() << "Caracter Invalido" << endl; }
}


%%

/*Sección de código de usuario*/
int yyFlexLexer::yywrap() {
  return 1;
}

int Lexer::getLine() {
  return yylineno;
}

int main() {
  Lexer lexer;
  int numErrors = 0;
  int token;
  
  while ((token = lexer.yylex()) != 0) {
    
    if (token != 0) {
      
      cout << "Token: " << lexer.YYText() << endl;
    } else {
      // Incrementar el contador de errores
      numErrors++;

      // Imprimir el error
      cout << "Error en la línea " << lexer.getLine() << "Caracter Invalido" << endl;
      
      // Detener la ejecución del programa si se alcanza el límite de errores
      if (numErrors == 5) {
        cout << "Se han encontrado 5 errores. Deteniendo la ejecución." << endl;
        break;
      }
    }
  }

  return 0;
}

