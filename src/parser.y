%define api.value.type {int}
%parse-param {int *ret}

%code top {
    #include <utils.hpp>
    #include <stdio.h>
    extern int yylex(void);
    extern Node* tree;
    static void yyerror(int *ret, const char* s) {
        fprintf(stderr, "%s\n", s);
    }
}

// Terminals

%token NUMBER PLUS MINUS TIMES UMINUS LPAREN RPAREN
%token LB RB LM RM COMA STRING MARK TRUE_VALUE FALSE_VALUE NULL_VALUE
%token JSONOBJ MAP VALUE MAPPAIRS MAPPAIR ARRAY ARRAYLISTS 

// Precedence and associativity

%left PLUS MINUS
%left TIMES
%left UMINUS

%%

// Grammar rules

start
    : jsonobj {
        *ret = 0;
        tree=$1;
    }
;

jsonobj
    : map {
        $$ = new Node(MAP,"");
        $$->children.push_back($1);
    }
    | array{
        $$ = new Node(ARRAY,"");
        $$->children.push_back($1);
    }
    | value {
        $$ = new Node(VALUE,"");
        $$->children.push_back($1);
    };

map
    : LB mappairs RB{
        $$ = new Node(MAPPAIR,"");
        $$->children.push_back($2);
    };

mappairs
    : mappairs2 COMA mappair{
        $$ = new Node(MAPPAIRS,"");
        $$->children=$1->children;
        $$->children.push_back($3);
    }
    | mappair{
        $$ = new Node(MAPPAIRS,"");
        $$->children.push_back($1);
    };  
    |  
    ;

mappairs2
    : mappairs2 COMA mappair{
        $$ = new Node(MAPPAIRS,"");
        $$->children=$1->children;
        $$->children.push_back($3);
    }
    | mappair{
        $$ = new Node(MAPPAIRS,"");
        $$->children.push_back($1);
    };  

mappair
    : STRING MARK value{
        $$ = new Node(MAPPAIR,"");
        $$->children.push_back($1);
        $$->children.push_back($3);
    };

array
    : LM arraylist RM{
        $$ = new Node(ARRAY,"");
        $$->children.push_back($2);
    };

arraylist
    : arraylist2 COMA value{
        $$ = new Node(ARRAYLISTS,"");
        $$->children=$1->children;
        $$->children.push_back($3);
    }
    | value{
        $$ = new Node(ARRAYLISTS,"");
        $$->children.push_back($1);
    }
    | 
;

arraylist2
    : arraylist2 COMA value{
        $$ = new Node(ARRAYLISTS,"");
        $$->children=$1->children;
        $$->children.push_back($3);
    }
    | value{
        $$ = new Node(ARRAYLISTS,"");
        $$->children.push_back($1);
    }
;

value
    :STRING{
        $$ = $1;
    }
    |TRUE_VALUE{
        $$ = new Node(TRUE_VALUE,"");
    }
    |FALSE_VALUE{
        $$ = new Node(FALSE_VALUE,"");
    }
    |NULL_VALUE{
        $$ = new Node(NULL_VALUE,"");
    }
    |array{
        $$ = $1;
    } 
    |map{
        $$ = $1;
    }
    |NUMBER{
        $$ = $1;
    }
;