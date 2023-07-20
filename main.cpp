#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
 
int main(int argc, char* argv[])
{
    // Beginning of parallel region
    #pragma omp parallel for num_threads(8)
    for(int i=0;i<20;i++){
        uint8_t* t=(uint8_t* )malloc(20);
    }
    // Ending of parallel region
}