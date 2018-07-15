function func = Exercise_47_c (x,y,z); 
tol = 1e-6;
tmp = 1;

while (tmp > tol)
  f = [x-3*y-z^2+3; 2*x^3+y-5*z^2+2; 4*x^2+y+z-7] 
  J = [1 -3 -2*z; 6*x^2 1 -10*z; 8*x 1 1];
  s = (J\f);
  tmp = norm(s);
  x = x-s(1,1);
  y = y-s(2,1);
  z = z-s(3,1);
  v = [x,y,z];
  disp(v);
end

