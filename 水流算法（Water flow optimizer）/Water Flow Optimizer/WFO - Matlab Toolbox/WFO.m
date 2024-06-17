function [fb,xb,con] = WFO(alg,prob)
% Water Flowing Optimizer
% Reference: 
% Kaiping Luo. Water Flow Optimizer: a nature-inspired evolutionary algorithm for global optimization.
% IEEE Transactions on Cybernetics, 2021.
% 
% Syntax
% [fb,xb,con] = WFO(alg,prob)
% alg.NP:  the number of water particle
% alg.max_nfe: the maximal number of function evaluation
% alg.pl: the laminar probability
% al.pe: the eddying probability
% prob.lb:  a row vector representing the lower bound
% prob.ub:  a row vector representing the upper bound
% prob.fobj:  a function handle representing the objective to be minimized
% prob.dim:  the dimension of the given problem
% fb: the best objective function value found
% xb: the best solution found
% con: convergence
% 
% Edited by: Kaiping Luo, Beihang University, kaipingluo@buaa.edu.cn
% in Matlab R2020a

%% Initialization
dim = prob.dim;
if size(prob.lb,1)>size(prob.lb,2)
    lb = prob.lb';
else
    lb = prob.lb;
end
if size(prob.ub,1)>size(prob.ub,2)
    ub = prob.ub';
else
    ub = prob.ub;
end
NP = alg.NP;
max_nfe = alg.max_nfe;

fb = inf;
con = zeros(max_nfe,1);
X = zeros(NP,dim);
F = zeros(NP,1);
for i = 1:NP
    X(i,:) = lb+rand(1,dim).*(ub-lb);
    F(i) = prob.fobj(X(i,:)');
    if F(i)<fb
        fb = F(i);        
        xb = X(i,:);
    end
    con(i) = fb;
end
nfe = NP;
Y = zeros(NP,dim);
%% Evolution
while nfe < max_nfe    
    if rand < alg.pl %  laminar flow
        d = xb - X(ceil(rand*NP),:);
        for i = 1:NP
            Y(i,:) = X(i,:) + rand*d;
            ind = Y(i,:)>ub | Y(i,:)<lb;
            Y(i,ind) = X(i,ind);
        end
    else % turbulent flow
        for i = 1:NP
            Y(i,:) = X(i,:);
            k = ceil(rand*NP);
            while k==i
                k = ceil(rand*NP);
            end
            j1 = ceil(rand*dim);
            if rand < alg.pe % spiral flow
                theta = (2*rand-1)*pi;
                Y(i,j1) = X(i,j1)+abs(X(k,j1)-X(i,j1))*theta*cos(theta);
                if Y(i,j1)>ub(j1) || Y(i,j1)<lb(j1)
                    Y(i,j1) = X(i,j1);
                end
            else
                j2 = ceil(rand*dim);
                while j2==j1
                    j2 = ceil(rand*dim);
                end
                Y(i,j1) = lb(j1)+(ub(j1)-lb(j1))*(X(k,j2)-lb(j2))/(ub(j2)-lb(j2));
            end
        end
    end
    for i = 1:NP
        f = prob.fobj(Y(i,:)');
        if f<F(i)
            F(i) = f;
            X(i,:) = Y(i,:);
            if f<fb
                fb = F(i);
                xb = X(i,:);
            end
        end
        nfe = nfe+1;
        con(nfe) = fb;
    end
end