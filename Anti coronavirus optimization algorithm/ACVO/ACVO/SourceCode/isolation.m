function [pop, I]=isolation(ProblemParams, AlgorithmParams, pop,Q, I, bestSolution)
list.position=[];
list.cost=[];
list.status=[];
list.fs=[];
list.days=[];

R=repmat(list,0,1);
person.position=[];
person.cost=[];
person.status=[];

for i=1:numel(I)
    if((I(i).status==-1) && (I(i).days<=AlgorithmParams.isolationDuration))
        gamma=1-(I(i).days/AlgorithmParams.isolationDuration);
        
        r1=0.5*rand;
        lq=ceil(r1*ProblemParams.NPar);
        varPos=randi(ProblemParams.NPar,1,lq);
        I(i).position(varPos)= gamma.*(I(i).position(varPos)+bestSolution.position(varPos).*AlgorithmParams.alpha);
        I(i).days=I(i).days+1;
        
        I(i).cost=feval(ProblemParams.costFuncName,I(i).position);
    else
        I(i).cost=feval(ProblemParams.costFuncName,I(i).position);
        if(I(i).cost<=I(i).fs)
            I(i).status=1;
            R=[R; I(i)];
        end
    end
end

I=I([I.status]==-1);
recovered=repmat(person,0,1);

if(~isempty(R))
    [recovered(1:numel(R)).position]=R.position;
    [recovered(1:numel(R)).cost]=R.cost;
    [recovered(1:numel(R)).status]=R.status;
end

pop=[pop; recovered];

end