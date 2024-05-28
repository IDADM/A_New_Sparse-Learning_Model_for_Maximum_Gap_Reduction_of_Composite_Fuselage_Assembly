%% Simulation Study for the paper "A New Sparse-Learning Model for Maximum
%  Gap Reduction of Composite Fuselage Assembly"
% -------------------------------------------------------------------------
clc;clear;close all;
addpath(genpath('.\fom'));
%% Simulation data generation 
% CASE IV 
n=364;
p=36;
S=18; 
mu_X=zeros(1,p);
Sigma_X = eye(p); R = chol(Sigma_X);
rng('default'); % set up the same seed (random number generation) for reproducibility 
XX = repmat(mu_X,n,1) + randn(n,p)*R;
signe_XX= randi([0 2],size(XX));
signe_XX(signe_XX==2)=0;
XX=XX.*signe_XX;
X = normalize(XX,'norm');
signe= randi([0 1],S,1);
signe(signe==0)=-1;
a = randn(S,1);
beta0=signe.*(1+abs(a));
betas=[beta0;zeros(p-S,1)];
sigma2=(1/9)*(S/n); %with a larger sigma
Epsion=sqrt(sigma2).*randn(n,1);
Y=X*betas+Epsion;
%% ADMM for solution  
mu1_max=max(max(abs(X)));
mu1_min=0;
i=0;
while 1   
    i=i+1;
    mu1=0.5*(mu1_max+mu1_min);
    [betaE,history]=ADMM_Sbeta(mu1,-X,Y); % ADMM solution 
    qindex=find(betaE~=0);
    if length(qindex)==S
        count=1;
        break
    end
    if mu1_max-mu1_min<0.0001
        count=0;
        break
    end
    if length(qindex)<S
        mu1_max=mu1;
    elseif length(qindex)>S
        mu1_min=mu1;
    end
    mu1
end
%% Evaluation index caculation 
rho1=norm(betas-betaE)/(sqrt(sigma2*S*log(p)/n))
%% Re-estimate given the support location
XR=X(:,qindex);
[betaER,historyR]=ADMM_SbetaR(-XR,Y);
betaES=betaE;
betaES(qindex)=betaER;
%% Evaluation index caculation 
rho1R=norm(betas-betaES)/(sqrt(sigma2*S*log(p)/n))
%% The result is saved in 'SimulationMain2_2R.mat'
%% visualization 
figure;imagesc([betas betaE betaES])
colorbar
ES=qindex;
BS=find(betas~=0);
figure;
imagesc([BS ES]);colorbar
figure;subplot(1,2,1)
imagesc(BS)
colorbar
subplot(1,2,2)
imagesc(ES)
colorbar