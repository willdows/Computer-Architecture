/* 
Lab 1, Part 4, Q4,Two's complement 
Prepared by: William Lohmann, 000762544
*/

#include <stdio.h>
#include <stdlib.h>


// Function that returns the twos complement of a decimal
int twosComplement(int num) {
	return (~num) + 1;
}

// Function that converts decimal value to a binary
void decimaltoBinary(int decimal, char binary[]){
	int i;
	for(i=7; i>=0; i--) {
		binary[i] = (decimal & 1) + '0';
		decimal >>= 1;
		}
}

// Flips bits
int bitflip(int bits){
	return (~bits);
}

int main() {
	char binary[9];
	char bin[9];
	int decimal, complement, flip;
	
	printf("Enter 8-bit binary value: ");
	scanf("%8s", binary);
	
	decimal = strtol(binary,NULL,2); // Converts string to long int
	
	// Flips the bits of decimal without the +1 to show the intermediary step
	flip = bitflip(decimal);
	decimaltoBinary(flip,bin);
	printf("Flipped bits: %s\n",bin);
	
	// Calculates twos complement
	complement = twosComplement(decimal);
	decimaltoBinary(complement, binary);
	printf("Two's complement: %s\n", binary);
	
	return 0;
	
}
