#include <stdio.h>

extern "C" int excercise_7h(char *text);

int main(void)
{
	char text[256];
	int result = 1;
	
	while(result == 1)
	{
		printf("Input string      > ");
		fgets(text, sizeof(text), stdin);
		result = excercise_7h(text);
		if(result == 0)
			printf("Conversion results> %s\n", text);
		else if(result == 1)
			printf("String validation failed.\nExample of a proper string: \"nh:wind on the hill\"\n");
		else{
			printf("Something went wrong! (excercise_7h returned %s)\n", result);
			break;
		}
	}
	return 0;
}
