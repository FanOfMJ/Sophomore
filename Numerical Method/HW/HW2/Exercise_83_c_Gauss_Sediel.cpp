#include <bits/stdc++.h>
using namespace std;

int main ()
{
	float x, y;
	cout << "please input the starting vector x and y (input form:x y)" << endl;
	cin >> x >> y;
	for (int i = 0; i < 5000; i++)
	{
		x = 0.995 * y;
		y = 0.995 * x;
		cout << x << " " << y << endl;
	}
	return 0;
}