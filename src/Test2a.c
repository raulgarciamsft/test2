#include <test2/Test2a.h>
#include <stdio.h>

int test2()
{
	int x = 0;

	return x;
}

void test3(char* lpzTest, int cbTest) 
{ 
	char[3] x;
    memcpy(x, lpzTest, cbTest);
}