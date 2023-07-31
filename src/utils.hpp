#pragma once
#define YYSTYPE Node*
#include <vector>
#include <string>
class Node {
   public:
    Node(int type,char * yt):type(type){txt=std::string(yt);};
    int type;
    std::string txt;
    std::vector<Node*> children;
};