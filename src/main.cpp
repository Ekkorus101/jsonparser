#include <omp.h>
#include <stdio.h>
#include <utils.hpp>

#include <fcntl.h>
#include <unistd.h>
#include "lexer.hpp"
#include "parser.hpp"
#include <iostream>
Node* tree;

void printnode(Node* p,int level){
    for(int _=0;_<level;_++){
        printf(" ");
    }
    printf("|type:%d value:%s\n",p->type,p->txt.c_str());
    for(int _=0;_<p->children.size();_++){
        printnode(p->children[_],level+1);
    }
}

int main(void) {
    tree = nullptr;
    char buffer[4096];
    int f = open("test.json", O_RDONLY);
    int len = read(f, buffer, 4096);
    buffer[len] = 0;
    YY_BUFFER_STATE state;
    if (!(state = yy_scan_bytes(buffer, len))) {
        exit(1);
    }
    int ret;
    if (yyparse(&ret) == 0) {
        printf("= %d\n", ret);
    }

    printf("%p\n", tree);
    yy_delete_buffer(state);

    printnode(tree,0);

    return 0;
}