#include <stdio.h>

int calculate(int a, int b) {
    // Perform multiplication
    int result = a * b + 10;
    return result;
}

int main() {
    int x = 5;
    printf("Result: %d\n", calculate(x, 4));
    return 0;
}
