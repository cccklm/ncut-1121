clear all
clc;

%% Problem Statement
ProblemParams.CostFuncName = 'F1';    % You should state the name of your cost function here.
func_name=ProblemParams.CostFuncName;

[fobj, lowerbound, upperbound, globalCost, dimension]=GetBenchmarkFunction(ProblemParams.CostFuncName);
ProblemParams.CostFuncName=fobj;
ProblemParams.lb=lowerbound;
ProblemParams.ub=upperbound;
ProblemParams.NPar = dimension;
ProblemParams.gcost=globalCost;

ProblemParams.VarMin =ProblemParams.lb;
ProblemParams.VarMax = ProblemParams.ub;
if numel(ProblemParams.VarMin)==1
    ProblemParams.VarMin=repmat(ProblemParams.VarMin,1,ProblemParams.NPar);
    ProblemParams.VarMax=repmat(ProblemParams.VarMax,1,ProblemParams.NPar);
end
ProblemParams.SearchSpaceSize = ProblemParams.VarMax - ProblemParams.VarMin;

if isscalar(ProblemParams.VarMin) && isscalar(ProblemParams.VarMax)
    ProblemParams.dmax = (ProblemParams.VarMax-ProblemParams.VarMin)*sqrt(ProblemParams.NPar);
else
    ProblemParams.dmax = norm(ProblemParams.VarMax-ProblemParams.VarMin);
end

alpha=0.2;
alpha_damp=0.98;
AlgorithmParams.NumOfTrees = 25;
AlgorithmParams.NumOfYears = 1000;

% Chaotic_map_no=1; %Chebyshev
% Chaotic_map_no=2; %Circle
Chaotic_map_no=3; %Gauss/mouse
% Chaotic_map_no=4; %Iterative
% Chaotic_map_no=5; %Logistic
% Chaotic_map_no=6; %Piecewise
% Chaotic_map_no=7; %Sine
% Chaotic_map_no=8; %Singer
% Chaotic_map_no=9; %Sinusoidal
% Chaotic_map_no=10; %Tent

ChaosVec=zeros(10,AlgorithmParams.NumOfYears);
%Calculate chaos vector
for i=1:10
    ChaosVec(i,:)=chaos(i,AlgorithmParams.NumOfYears,1);
end



%% Main Loop
%% Population Initialization
InitialTrees = CreateForest(AlgorithmParams, ProblemParams);
InitialCost = feval(ProblemParams.CostFuncName,InitialTrees);
InitialTrees(:,end+1) = InitialCost;
Population = InitialTrees;

for year= 1:AlgorithmParams.NumOfYears
    AlgorithmParams.SeedingRate=(0.4).* rand(1) + 0.1;
    AlgorithmParams.year=year;
    
    Costs = Population(:,end);
    MinimumCost(year) = min(Costs);
    
    BestIndex = find(Costs == MinimumCost(year));
    BestIndex = BestIndex(1);
    BestSolution = Population(BestIndex,1:end-1);
    
    [temp] = growth(Population, AlgorithmParams, ProblemParams, alpha, year);
    
    [temp] = fruitScattering(temp,AlgorithmParams, ProblemParams, BestSolution, alpha);
    
    [temp] = rootSpreading(temp,AlgorithmParams, ProblemParams, alpha, ChaosVec(Chaotic_map_no,:));
    
    for i=1:AlgorithmParams.NumOfTrees
        if (temp(i,end)<Population(i,end))
            Population(i,:)=temp(i,:);
        end
    end
    
    alpha = alpha*alpha_damp;
    
    Costs = Population(:,end);
    MinimumCost(year) = min(Costs);
    
    fprintf('Minimum Cost in Iteration %d is %3.16f \n', year,MinimumCost(year));
end