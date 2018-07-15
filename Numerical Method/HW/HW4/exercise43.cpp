#include <bits/stdc++.h>
using namespace std;

double FirstError (double x, double h)
{
	double result;
	result = -cosh(x)/90;
	return result;
}

double SecondError (double x, double h)
{
	double result;
	result = -(3*cosh(x))/80;
	return result;
}

int main ()
{
	double x1, x2;
	cin >> x1 >> x2;
	double error1, error2;
	error1 = FirstError(x1,0.1);
	error2 = SecondError(x2,0.1);
	cout << error1 << " " << error2 << endl;
	return 0;
}