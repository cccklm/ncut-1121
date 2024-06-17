function [pop, Q, I]=quarantine(ProblemParams, AlgorithmParams, pop,Q, I, bestSolution)
list.position=[];
list.cost=[];
list.status=[];
list.fs=[];
list.days=[];

person.position=[];
person.cost=[];
person.status=[];

R=repmat(list,0,1);

pSize=size(pop,1);

q=ceil((1-(1-(AlgorithmParams.landa^2))*AlgorithmParams.m)*AlgorithmParams.R0);
AlgorithmParams.landa=1-(AlgorithmParams.it/AlgorithmParams.MaxIt);
qq=repmat(list,q,1);

[~, SortOrder]=sort([pop.cost]);
pop=pop(SortOrder);
pop=pop(1:pSize);

if(size(pop,1)>q)
    for i=1:q
        qq(i).position=pop(pSize-q+i).position;
        qq(i).cost=pop(pSize-q+i).cost;
        pop(pSize-q+i).status=0;
        qq(i).status=0;
        qq(i).fs=pop(pSize-q+i).cost;
        qq(i).days=0;
    end
else
    qq=[];
end
pop=pop([pop.status]==1);
Q=[Q; qq];

for i=1:numel(Q)
    if((Q(i).status==0) && (Q(i).days<AlgorithmParams.quarantineDuration))
        r1=0.5*rand;
        lq=ceil(r1*ProblemParams.NPar);
        
        varPos=randi(ProblemParams.NPar,1,lq);
        Q(i).position(varPos)= Q(i).position(varPos)+rand*unifrnd(-1,+1,size(varPos));
        Q(i).days=Q(i).days+1;
        
    else
        Q(i).cost=feval(ProblemParams.costFuncName,Q(i).position);
        if(Q(i).cost<=Q(i).fs)
            Q(i).status=1;
            R=[R; Q(i)];
        else
            Q(i).status=-1;
            Q(i).days=0;
            Q(i).fs=Q(i).cost;
            I=[I; Q(i)];
        end
    end
end
Q=Q([Q.status]==0);

recovered=repmat(person,0,1);
if(~isempty(R))
    [recovered(1:numel(R)).position]=R.position;
    [recovered(1:numel(R)).cost]=R.cost;
    [recovered(1:numel(R)).status]=R.status;
end
pop=[pop; recovered];

end