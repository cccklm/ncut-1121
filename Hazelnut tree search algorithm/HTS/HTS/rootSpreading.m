function [Population] = rootSpreading(Population, AlgorithmParams, ProblemParams,alpha,ChaosVec)
temp=nan;
temp=Population(:,1:end-1);

ProblemParams.VarMin;
ProblemParams.VarMax;

% r=exp(-AlgorithmParams.year/AlgorithmParams.NumOfYears);
r=alpha;
ch=ChaosVec(AlgorithmParams.year);

costs=Population(:,end);
[costs,sortInd] = sort(costs);
Population = Population(sortInd,:);
temp=Population(1,1:end-1);
bestCost=Population(1,end);


for i=1:ProblemParams.NPar
    temp(:,i)= temp(:,i)+r.*(ProblemParams.VarMax(:,i)-ProblemParams.VarMin(:,i))*(ch-0.5);
    temp(:,i)=max(temp(:,i),ProblemParams.VarMin(:,i));
    temp(:,i)=min(temp(:,i),ProblemParams.VarMax(:,i));    
    newCost = feval(ProblemParams.CostFuncName,temp);
          
    if (newCost<bestCost)
        Population(1,1:end-1)=temp;
        Population(1,end)=newCost;
        bestCost=newCost;
    end
    
end
end