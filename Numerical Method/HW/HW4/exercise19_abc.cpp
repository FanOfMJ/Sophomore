#include <iostream>
#include <cmath>
#define h 0.2
using namespace std;

double X[7] = {0.3,0.5,0.7,0.9,1.1,1.3,1.5};
double f[7] = { 0.3985, 0.6598, 0.9147, 1.1611, 1.3971, 1.6212, 1.8325 };
double first[6] = {0.2613,0.2549,0.2464,0.2360,0.2241,0.2113};
double second[5] = {-0.0064,-0.0086,-0.0104,-0.0118,-0.0128};
double third[4] = {-0.0022,-0.0018,-0.0014,-0.0010};
double forth[3] = {0.0003,0.0004,0.0005};

double func(int idx, int i, double x)
{
	double result = 0.0;
	if (idx >= 1)
		result += first[i];
	if (idx >= 2)
		result += second[i] * ((x - X[i]) + (x - X[i + 1]));
	if (idx >= 3)
		result += third[i] * ((x - X[i])*(x - X[i + 1]) + (x - X[i + 1])*(x - X[i + 2]) + (x - X[i + 2])*(x - X[i]));
	if (idx >= 4)
		result += forth[i] * ((x - X[i])*(x - X[i+1])*(x - X[i+2]) + (x - X[i])*(x - X[i+1])*(x - X[i+3]) + (x - X[i])*(x - X[i+2])*(x - X[i+3]) + (x - X[i+1])*(x - X[i+2])*(x - X[i+3]));
	return result;
}

int main()
{
	int idx; //看是要準確到到第幾層
	double x, real_root, eva_value;
	cin >> idx;
	cin >> x;

	//convert to divided-difference table
	for (int i = 0; i < 6; i++)
		first[i] /= h;
	for (int i = 0; i < 5; i++)
		second[i] /= (2*pow(h,2));
	for (int i = 0; i < 4; i++)
		third[i] /= (6*pow(h,3));
	for (int i = 0; i < 3; i++)
		forth[i] /= (24*pow(h,4));
	//

	real_root = 1 + cos(x)/3; //真正的解
	cout << "real_root: " << real_root << endl;
	for (int i = 0; i <= (6 - idx); i++)
	{
		eva_value = func(idx, i, x);
		cout << "evaluate root: " << i << "--- " << eva_value << endl;
		cout << "the difference is between the root and the evaluate value is " << abs(real_root - eva_value) << endl;
	}
	system("pause");
	return 0;
}