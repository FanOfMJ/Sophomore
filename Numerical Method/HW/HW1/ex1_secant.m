function p = ex1_secant(a,b)
f=inline('2*sin(x)-exp(x)/4-1');
tol=1e-5;
tmp = 10;
while (abs(tmp) > tol)
    c = b-f(b)*((b-a)/(f(b)-f(a)));
    if (f(c)*f(a) < 0) b = c;
    else a = c;
    end
    tmp = f(c);
    %fprintf('%.4f\n',c);
end
fprintf('%.4f\n',c);