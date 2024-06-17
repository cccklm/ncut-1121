function demo
% Demostrate how the procedure of the WFO algorithm is invoked

% Please refer to the following paper on more details
% ---------------------------------------------------------------------------------------------
% Kaiping Luo,
% Water Flow Optimizer: A Nature-Inspired Evolutionary Algorithm for Global Optimization.​ IEEE Transactions on Cybernetics. 2021.
% Linkage: https://doi.org/10.1109/TCYB.2021.3049607
% ---------------------------------------------------------------------------------------------
% Written by Kaiping Luo in Matlab R2020b.
% Copyright@2020: Beihang University.

%% Syntax
% fb = WFO(alg,prob);
% [fb,xb,con] = WFO(alg,prob);

% imput:
% alg: a struct for setting the parameters of the ESGHS algorithm.
% alg.NP: a scalar for setting the water particle numbers.
% alg.max_nfe: a scalar for setting the maximal number of function evaluation.
% alg.pl: a scalar between 0 and 1 for setting the laminar probability.
% alg.pe: a scalar between 0 and 1 for setting the eddying probability.

% prob: a struct for setting the parameters of the problem to be solved.
% prob.dim: a scalar for setting the dimensional number of the problem to be solved.
% prob.ub: a horizontal vector for setting the upper bound of the problem to be solved.
% prob.lb: a horizontal vector for setting the lower bound of the problem to be solved.
% prob.fobj: a function handle for setting the objective function to be minized.

% output:
% fb: a scalar for recording the minimal function value found
% xb: a horizontal vector for recording the optimal solution found 
% con: a vertical vector for recording the best objective function value found at each iteration. 

%% 
clear 
clc

%% Example 1: 
disp('Demo 1: Solve the Sphere function using the WFO algorithm.')

prob.dim = 30;
prob.fobj = @(x) sum(x.^2);
prob.lb = -100*ones(1,prob.dim);
prob.ub = 100*ones(1,prob.dim);  

alg.NP = 50;
alg.max_nfe = 10000*prob.dim;
alg.pl = 0.3;
alg.pe = 0.7;
[fb,xb,con] = WFO(alg,prob);
sprintf('The minimal function value found: %e',fb)
figure
plot(con)
title('Convergence: Sphere')
xlabel('Number of function evaluation')
ylabel('Value of objective function')


%% Example 2:  
disp('Demo 2: Solve the benchmark function in the open CEC2017 test suite using the WFO algorithm.')

seq = 29; % the sequence of the CEC2017 benchmark function, 1-30.
prob.dim = 30; % dim = 2,10,30,50,100. 
prob.fobj = @(x) cec17_func(x,seq);
prob.lb = -100*ones(1,prob.dim);
prob.ub = 100*ones(1,prob.dim);

alg.NP = 50;
alg.max_nfe = 10000*prob.dim;
alg.pl = 0.3;
alg.pe = 0.7;
[fb,xb,con] = WFO(alg,prob);
sprintf('The minimal function value found: %e',fb)
figure
plot(con)
title('Convergence')
xlabel('Number of function evaluation')
ylabel('Value of objective function')
    