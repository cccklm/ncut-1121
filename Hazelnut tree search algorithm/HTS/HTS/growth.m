function [x] = growth(Population, AlgorithmParams, ProblemParams, alpha, t)
dmax = norm(ProblemParams.VarMax-ProblemParams.VarMin);

maxCost=max(Population(:,end));
sumCost=sum(Population(:,end));

ProblemParams.dmax=dmax;
ProblemParams.maxCost=maxCost;
ProblemParams.sumCost=sumCost;


for i=1:AlgorithmParams.NumOfTrees
    cored=Population(i,:);
    w1=unifrnd(alpha,alpha);
    g=(1-exp(-4*t/AlgorithmParams.NumOfYears)).*w1;
    R=cored(:,1:end-1)+g;
    
    r=rand;
    if r>=0.5
        x(i,:)=R;
    else
        landa=computeLanda(ProblemParams,AlgorithmParams,Population, i);
        x(i,:)=(1/(1+landa)).*R;
    end
    
    x(i,:)=max(x(i,:),ProblemParams.VarMin);
    x(i,:)=min(x(i,:),ProblemParams.VarMax);
end

costs = feval(ProblemParams.CostFuncName,x);
x(:,end+1) = costs;

end

function l=computeLanda(ProblemParams,AlgorithmParams,Population,i)
fi=Population(i,end);
coredTree=Population(i,:);

if ProblemParams.maxCost>0
    nfi = 0.9*(ProblemParams.maxCost-fi)/ProblemParams.sumCost;
else
    nfi = 0.7*max(ProblemParams.maxCost-fi)/ProblemParams.sumCost;
end

zi=round(nfi*(AlgorithmParams.NumOfTrees-1));    % Excluding individual i so the neighbors is selected from N-1 trees
zi=min(zi, AlgorithmParams.NumOfTrees-1);
temp=Population(1:end ~=i, :);       % For deleting individual i
RandomIndex = randperm(AlgorithmParams.NumOfTrees-1);
s=RandomIndex(1:zi);
Ng=temp(s,:);

landa=0;
for j=1:zi
    dij=norm(coredTree(1,end-1)-Ng(j,1:end-1))/ProblemParams.dmax;
    fj=Ng(j,end);
    landa=landa+(fj/fi)*atan(fj/dij);
end
l=landa;
end