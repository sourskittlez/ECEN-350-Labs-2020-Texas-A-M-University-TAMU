#include <stdio.h>

extern long long int my_mul(long long int a, long long int b);

int main(void) {
    long long int n = my_mul(5, 3);
    printf("Result of lab04b(3, 5) = %ld\n", n);
    return 0;
}
