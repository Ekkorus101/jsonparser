%option noyywrap


%top {
    #include <utils.hpp>
    #include "parser.hpp"
}

INTEGER [0-9]+
STRING \"[a-z,A-Z,0-9]+\"

%%

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { 
return LB;}
"}" { return RB;}
"[" { return LM;}
"]" { return RM;}
"," { return COMA;}
":" { return MARK;}
"true" {return TRUE_VALUE;}
"false" {return FALSE_VALUE;}
"null" {return NULL_VALUE;}


{INTEGER} {
    yylval =new Node(NUMBER,yytext);
    return NUMBER;
}
{STRING} {
    yylval =new Node(STRING,yytext);
    return STRING;
}

