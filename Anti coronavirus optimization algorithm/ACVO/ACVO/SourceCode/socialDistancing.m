function [pop]=socialDistancing(ProblemParams, AlgorithmParams, pop,bestSolution)
AlgorithmParams.m=AlgorithmParams.it/AlgorithmParams.MaxIt;
if(AlgorithmParams.m<0.5)
    AlgorithmParams.m=0.5;
else
    AlgorithmParams.m=AlgorithmParams.it/AlgorithmParams.MaxIt;
end
pSize=ceil(AlgorithmParams.m*AlgorithmParams.popSize);


person.position=[];
person.cost=[];
person.status=[];
newpop=repmat(person,AlgorithmParams.popSize,1);

for i=1:pSize
    newpop(i).cost = inf;
    for j=i+1:pSize
        dij=norm(pop(i).position-pop(j).position)/ProblemParams.dmax;
        if(dij~=0 & (dij<=AlgorithmParams.delta))
            sd=AlgorithmParams.delta-dij;     % Eq. ()
            impact=exp(-dij/AlgorithmParams.delta);
            Delta1=sd*impact*AlgorithmParams.alpha*unifrnd(-1,+1,ProblemParams.VarSize);   % Eq. ()
            
            sij=norm(pop(i).position-bestSolution.position)/ProblemParams.dmax;
            beta=2*exp(-(sij));
            %Delta2=beta.*rand(ProblemParams.VarSize).*(bestSolution.position-pop(i).position);
            L=Levy(ProblemParams.NPar);
            Delta2=beta.*L.*(bestSolution.position-pop(i).position);
            
            
            newsol.position = pop(i).position+ Delta1+Delta2;
            
            newsol.position=max(newsol.position,ProblemParams.VarMin);
            newsol.position=min(newsol.position,ProblemParams.VarMax);
            
            newsol.cost=feval(ProblemParams.costFuncName,newsol.position);
            newsol.status=1;
            
            if newsol.cost <= newpop(i).cost
                newpop(i) = newsol;
            end
            
        end
    end
end

pop=[pop; newpop];

[~, SortOrder]=sort([pop.cost]);
pop=pop(SortOrder);

pop=pop(1:AlgorithmParams.popSize);
bestSolution=pop(1,:);
end

function L=Levy(d)
landa=1.5;
sigma=(gamma(1+landa)*sin(pi*landa/2)/(gamma((1+landa)/2)*landa*2^((landa-1)/2)))^(1/landa);
u=randn(1,d)*sigma;
v=randn(1,d);
step=u./abs(v).^(1/landa);
L=0.1*step;
end