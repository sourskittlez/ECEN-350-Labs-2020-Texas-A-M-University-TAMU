#include <stdio.h>

extern long long int test(long long int a, long long int b);
extern long long int lab03b();
extern long long int lab03c();

int main(void) {
    long long int b = lab03b();
    printf("Lab3b ouput: %d\n", b);
    
    long long int c = lab03c();
    printf("Lab3c ouput: %d\n", c);
    
    return 0;
}
