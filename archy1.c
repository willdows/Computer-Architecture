/*
William Lohmann
000762544
ITSC 204 Lab 1 - Q3
Decimal to Binary Converter
*/

#include <stdio.h>
#include <stdlib.h>

int main()
{

	int decval;
	float decfloat;
	int binval[10];
	int count = 0;
	


	printf("\nPlease enter a decimal value < 1024 that you wish to convert: ");
	scanf("%d", &decval);

	for(count = 0; decval > 0; count++)
	{
		binval[count] = decval % 2;
		decval = decval / 2;
		decfloat = decval;
		
		if (decval%2 == 1)
		{
			printf("\n %d/2 is %.3f,	this division has a remainder,  the #%d integer is: 1", decval, decfloat/2, count+1);
		}
		
		else
		{
			printf("\n %d/2 is %.3f,	this division has no remainder, the #%d integer is: 0", decval, decfloat/2, count+1);
		}
		
		
	}
	
	printf("\nThe binary value is: ");
	
	for(count = count - 1; count >= 0; count--)
	{
		printf("%d", binval[count]);
	}

	printf("\n");

	return (0);
}

