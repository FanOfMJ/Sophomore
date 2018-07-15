#include <bits/stdc++.h>
using namespace std;

int main ()
{
	float x, y, old_x;
	cout << "please input the starting vector x and y (input form:x y)" << endl;
	cin >> x >> y;
	for (int i = 0; i < 10000; i++)
	{
		old_x = x;
		x = 0.995 * y;
		y = 0.995 * old_x;
		cout << x << " " << y << endl;
	}
	return 0;
}