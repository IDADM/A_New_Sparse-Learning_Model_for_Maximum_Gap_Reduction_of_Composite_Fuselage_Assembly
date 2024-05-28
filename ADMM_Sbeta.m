%% ADMM distributed optimization 
% This function is used to solve
% norm(Ax+b,inf)+lambda*norm(x,1)
function [x2,history]=ADMM_Sbeta(lambda,A,b)

[m,n]=size(A);
z1= zeros(m,1);
z2= zeros(n,1);
z=[z1;z2];
u1= zeros(m,1);
u2= zeros(n,1);
u=[u1;u2];
QUIET  = 1;
ABSTOL = 1e-6;%1e-3;
RELTOL = 1e-5;%1e-3;%1e-2;
Atu=[eye(m),-A];
btu=b;
prox4 = @(x) prox_l1(x, lambda);

max_iter=10000;
for k=1:max_iter
    u1=u(1:m);
    z1=z(1:m);
    x1=prox_linf(z1-u1,1); 
    u2=u((1+m):m+n);
    z2=z((1+m):m+n);
    x2=prox4(z2-u2);
    x=[x1;x2];
    u=[u1;u2];
    zold=[z1;z2];
    z=proj_affine_set_A(x+u,Atu,btu);
    u=u+x-z;
    %% check
    history.objval(k)=objectiveR2(lambda,A,b,x2);
    history.r_norm(k)  = norm(x-z); % primal residual signal
    history.s_norm(k)  = norm(zold-z); % dual residual signal
    p=length(x);
    history.eps_pri(k) = sqrt(p)*ABSTOL + RELTOL*max([norm(x),norm(-z)]);
    history.eps_dual(k)= sqrt(p)*ABSTOL + RELTOL*norm(u);

    if ~QUIET
        fprintf('%3d\t%10.4f\t%10.4f\t%10.4f\t%10.4f\t%10.2f\n', k, ...
            history.r_norm(k), history.eps_pri(k), ...
            history.s_norm(k), history.eps_dual(k), history.objval(k));
    end

    if (history.r_norm(k) < history.eps_pri(k) && ...
       history.s_norm(k) < history.eps_dual(k))
         break;
    end
end
end

