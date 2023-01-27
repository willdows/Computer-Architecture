#include <stdio.h>
#include <string.h>

int main() {
    char hex[17];
    long long binary;
    int i = 0, decimal = 0;

    printf("Enter a hexadecimal number: 0x");
    scanf("%s", hex);

    for (i = 0; hex[i] != '\0'; i++) {
        decimal = decimal * 16 + (hex[i] >= '0' && hex[i] <= '9' ? (hex[i] - 48) : (hex[i] - 55));
    }

    i = 1;
    binary = 0;
    while (decimal != 0) {
        binary = binary + (decimal % 2) * i;
        decimal = decimal / 2;
        i = i * 10;
    }

    char binary_str;
    printf("Binary equivalent: %ld", binary);

    return 0;
}

