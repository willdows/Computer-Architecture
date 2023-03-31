#include<stdio.h>
#include<stdlib.h>
#include<math.h>

//Source: https://www.factmonster.com/math-science/mathematics/prime-numbers-facts-examples-table-of-all-up-to-1000
//gcc prime.c -o prime -lm
int max = 100;

int checkPrime(int num, int squr) {
//	printf("Checking %d; executing %d times\n ",num, squr);
	for (int j = 2; j < squr; j += 1) {
		if (!(num % j)) //NOT PRIME
			return 0;
	}
	return num;
}

int main() {
	int num;
//	int numbers[10] = {1,2,3,4,5,6,7,8,9,10};
//	size_t length = sizeof(numbers) / sizeof(int);
	for (int num = 3; num < max; num++) {
		int half = num / 2;
		if (checkPrime(num, half))
			printf("%d is a prime\n",num);
	}

	return 0;
}
