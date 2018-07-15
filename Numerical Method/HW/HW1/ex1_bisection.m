function p = ex1_bisection(f,a,b)

tol = 1e-5;
if f(a)*f(b)>0 
    error('the root is not in this range!!!\n');
end

while (abs(a-b)>tol & f(a)*f(b) ~= 0)
    m = (a + b)/2;
    if f(a)*f(m)<0 
        b = m;
    else
        a = m;          
    end
    %fprintf('%.4f\n',m);
end
fprintf('%.4f\n',m);