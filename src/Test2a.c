#include <test2/Test2a.h>
#include <stdio.h>

int test2()
{
	int x = 0;

	return x;
}

void test3(char* lpzTest, int cbTest) 
{ 
	char x[3];
    memcpy(x, lpzTest, cbTest);
}
