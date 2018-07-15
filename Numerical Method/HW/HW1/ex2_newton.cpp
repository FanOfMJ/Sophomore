#include <bits/stdc++.h>
#define tol 1e-6
using namespace std;

float f (float x)
{
	return pow(x-2,3)*pow(x-4,2);	
}

float f_derivative (float x)
{
	return 3*pow(x-2,2)*pow(x-4,2) + 2*pow(x-2,3)*(x-4);	
}

int main ()
{
	float x = 6.0;
	while (abs(f(x)) > tol)
	{
		float xnew = x - f(x)/f_derivative(x);
		x = xnew;
		printf("%.4f\n",x);	
	}
	return 0;
}