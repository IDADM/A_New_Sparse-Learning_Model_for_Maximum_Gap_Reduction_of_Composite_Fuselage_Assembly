function obj = objectiveR2(lambda,A,b,xbar)
    obj = norm(A*xbar+b,inf)+lambda*norm(xbar,1);
end