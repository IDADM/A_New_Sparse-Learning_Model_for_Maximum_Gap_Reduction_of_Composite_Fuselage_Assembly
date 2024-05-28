function obj = objectiveR3(A,b,xbar)
    obj = norm(A*xbar+b,inf);
end