function p = ex1_newton(x)
tol = 1e-5;
f = inline('2*sin(x)-exp(x)/4-1');

while (abs(f(x))>tol)
    f_derivative = inline('2*cos(x)-exp(x)/4');
    xnew = x-f(x)/f_derivative(x);
    x = xnew;
    %fprintf('%.4f\n',x);
end

fprintf('%.4f\n',x);