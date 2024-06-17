clear all
clc

objFunc='F10';
% Dimension: 30
[fobj, lowerbound, upperbound, globalcost, dimension]=GetBenchmarkFunction(objFunc);
ProblemParams.costFuncName=fobj;
ProblemParams.lb=lowerbound;
ProblemParams.ub=upperbound;
ProblemParams.NPar = dimension;
ProblemParams.gcost=globalcost;
ProblemParams.VarMin =ProblemParams.lb;
ProblemParams.VarMax = ProblemParams.ub;
ProblemParams.VarSize=[1 dimension];


%% Algorithm Parameters
AlgorithmParams.MaxIt=5000;
AlgorithmParams.popSize=25;
AlgorithmParams.landa=1;
AlgorithmParams.delta=2;
AlgorithmParams.R0=2.5;
AlgorithmParams.m=0;
AlgorithmParams.alpha=1;
AlgorithmParams.ralpha=0.98;
AlgorithmParams.quarantineDuration=5;
AlgorithmParams.isolationDuration=10;

if isscalar(ProblemParams.VarMin) && isscalar(ProblemParams.VarMax)
    ProblemParams.dmax = (ProblemParams.VarMax-ProblemParams.VarMin)*sqrt(ProblemParams.NPar);
else
    ProblemParams.dmax = norm(ProblemParams.VarMax-ProblemParams.VarMin);
end

%% Initialization
person.position=[];
person.cost=[];
person.status=[];
recovered=repmat(person,0,1);

bestSolution.cost=inf;

[pop, bestSolution]=initialization(ProblemParams, AlgorithmParams);

list.position=[];
list.cost=[];
list.status=[];
list.fs=[];
list.days=[];
Q=repmat(list,0,1);
R=repmat(list,0,1);
I=repmat(list,0,1);

Bestcost=zeros(AlgorithmParams.MaxIt,1);

%% ACVO main loop
for it=1:AlgorithmParams.MaxIt

    
    AlgorithmParams.it=it;
    
     % Social distancing
    [pop]=socialDistancing(ProblemParams, AlgorithmParams, pop, bestSolution);
    
    %% Quarantine
    [pop,Q, I]=quarantine(ProblemParams, AlgorithmParams, pop, Q, I, bestSolution);    
    
    %% Isoation
    [pop, I]=isolation(ProblemParams, AlgorithmParams, pop,Q, I,bestSolution);
    
    
    pop=[pop; recovered];
    ss=size(pop,1);
    
    [~, SortOrder]=sort([pop.cost]);
    pop=pop(SortOrder);
    pop=pop(1:ss); 
    
    bestSolution=pop(1,:);    
    Bestcost(it)=bestSolution.cost;
    
    fprintf('Iteration %d: Best cost: %6.16f \n', it, Bestcost(it));
    if(abs(Bestcost(it)-ProblemParams.gcost)<=1e-17)
        break;
    end
    AlgorithmParams.alpha = AlgorithmParams.alpha*AlgorithmParams.ralpha;    
end