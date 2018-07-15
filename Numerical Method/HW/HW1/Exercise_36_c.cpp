#include <bits/stdc++.h>
using namespace std;

float func (float x)
{
	return log(2*x*x);
}

int main ()
{
	int N = 100;
	float x1 = 2.5, x2 = 2.7;
	while (N--){
		x1 = func(x1);
		x2 = func(x2);
		printf("%.4f\t%.4f\n",x1,x2);
	}
	
	return 0;
}