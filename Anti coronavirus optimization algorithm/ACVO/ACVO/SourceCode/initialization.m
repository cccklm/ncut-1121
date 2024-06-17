function [pop, bestSolution]=initialization(ProblemParams, AlgorithmParams)
person.position=[];
person.cost=[];
person.status=[];

pop=repmat(person,AlgorithmParams.popSize,1);

bestSolution.cost=inf;

for i=1:AlgorithmParams.popSize
    pop(i).position=unifrnd(ProblemParams.VarMin,ProblemParams.VarMax,ProblemParams.VarSize);
    pop(i).cost=feval(ProblemParams.costFuncName,pop(i).position);
    pop(i).status=1;
    if pop(i).cost<=bestSolution.cost
        bestSolution=pop(i);
    end
end

end