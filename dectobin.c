/* 
Lab 1, Part 4, Q3, Decimal to Binary converter 
Prepared by: William Lohmann, 000762544
Based on previous code written by the author, updated May 24th 2023
*/

#include <stdio.h>
#include <stdlib.h>

int main()
{

	// Variable initilization
	int decval;
	float decfloat;
	int binval[10];
	int count = 0;
	
	// User input
	printf("\nPlease enter a decimal value < 1024 that you wish to convert: ");
	scanf("%d", &decval);

	// This for loop handles the conversion, iterating through each decimal digit in decval and assinging it to the same location in binval
	for(count = 0; decval > 0; count++)
	{
		binval[count] = decval % 2;
		decval = decval / 2;
		decfloat = decval;
		
		if (decval%2 == 1)
		{
			printf("\n %d/2 is %.2f, There is a remainder,  the #%d integer is: 1", decval, decfloat/2, count+1);
		}
		
		else
		{
			printf("\n %d/2 is %.2f, There is no remainder, the #%d integer is: 0", decval, decfloat/2, count+1);
		}
	}
	
	// Prints out the individual bits one at a time
	printf("\nThe binary value is: ");
	for(count = count - 1; count >= 0; count--)
	{
		printf("%d", binval[count]);
	}
	printf("\n");

	return (0);
}

