function [temp] = fruitScattering(Population, AlgorithmParams, ProblemParams, bestSolution,alpha)
temp=nan;

S=round(AlgorithmParams.SeedingRate*AlgorithmParams.NumOfTrees);

costs=Population(:,end);
[costs,sortInd] = sort(costs);
Population = Population(sortInd,:);
temp=Population(:,1:end-1);

for i=1:S
    L=Levy(ProblemParams.NPar);
    %             temp(i,:)=temp(i,:)+rand([1 ProblemParams.NPar]).*L.*(temp(i,:)-bestSolution(1,1:end-1));
    temp(i,:)=temp(i,:)+L.*(temp(i,:)-bestSolution(1,:));
    temp(i,:)=max(temp(i,:),ProblemParams.VarMin);
    temp(i,:)=min(temp(i,:),ProblemParams.VarMax);
end


costs = feval(ProblemParams.CostFuncName,temp);
temp(:,end+1) = costs;

for i=1:AlgorithmParams.NumOfTrees
    if (temp(i,end)<Population(i,end))
        Population(i,:)=temp(i,:);
    end
end
end


function L=Levy(d)
landa=1.5;
sigma=(gamma(1+landa)*sin(pi*landa/2)/(gamma((1+landa)/2)*landa*2^((landa-1)/2)))^(1/landa);
u=randn(1,d)*sigma;
v=randn(1,d);
step=u./abs(v).^(1/landa);
L=0.1*step;
end