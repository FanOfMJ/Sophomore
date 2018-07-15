function chol = Bonus_Cholesky(A,n)
L = zeros(n,n);
if ~isequal(A,A')
    disp('A should be a symmetric matrix!!!');
    return;
end
tmp = 0;
for i = 1:n
    for j = 1:i
        tmp = 0;
        for k = 1:j
            tmp = tmp + L(i,k)*L(j,k);
        end
        if(i == j)
            L(i,j) = sqrt(A(i,i)-tmp);
        else
            L(i,j) = (A(i,j)-tmp)/L(j,j);
        end        
    end
end
disp(L);