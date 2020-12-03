#include <stdio.h>

extern long long int lab04b(long long int n);

int main(void) {
    long long int n = lab04b(3);
    printf("Result of lab04b(3) = %ld\n", n);
    
    n = lab04b(5);
    printf("Result of lab04b(5) = %ld\n", n);
    return 0;
}
