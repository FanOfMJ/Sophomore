#include <bits/stdc++.h>
using namespace std;

float func (float x)
{
	return -sqrt(exp(x)/2);
}

int main ()
{
	int N = 100;
	float x = 0.0;
	while (N--){
		x = func(x);
		printf("%.4f\n",x);
	}
	
	return 0;
}