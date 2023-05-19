#ifndef __LEXER_HPP__
#define __LEXER_HPP__

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include <string>
using namespace std;

#include "Tokens.hpp"

class Lexer : public yyFlexLexer
{
public:
    Lexer(std::istream *in) : yyFlexLexer(in){    
    }
    ~Lexer() = default;

    using FlexLexer::yylex;
    virtual int yylex();    
    virtual int getLine(); 
    
private:
    int line=1;
};

#endif // !__LEXER_HPP__
