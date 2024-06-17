
function [Best_Score,convergence_curve]=GOA(pop_size,max_iter,lb,ub,dim,fhd,varargin)
% initialize
Best_X=[];
Best_Score=inf;
%Initialize the first random population
X=initialization(pop_size,dim,ub,lb);
convergence_curve=zeros(max_iter,1);

for i=1:pop_size
    Pop_Fit(i)=feval(fhd,X(i,:)',varargin{:});
    if Pop_Fit(i)<Best_Score
        Best_Score=Pop_Fit(i);
        Best_X=X(i,:);
    end
end
%MX is an intermediate variable that stores the evolved X value, and assigns the value to X if MX is better than X after calculation.MX=X(:,:);
MX=X(:,:);

%%Main loop
for It=1:max_iter
    
    t=1-It/max_iter;
    t2=1+It/max_iter;
    a=2*cos(2*pi*rand)*t;          %U
    b=2*Vshape(2*pi*rand)*t;     %V
    A=(2*rand-1)*a;
    B=(2*rand-1)*b;
    %% Exploration:
    if rand>0.5
        for i=1:pop_size
            if rand>=0.5
                u1= unifrnd(-a,a,1,dim);
                u2=A*(X(i,:)-X(randperm(pop_size,1),:));
                MX(i,:)=X(i,:)+u1+u2;
            else
                v1= unifrnd(-b,b,1,dim);
                v2=B*(X(i,:)-mean(X));
                MX(i,:)=X(i,:)+v1+v2;
            end
        end
        
        MX = boundaryCheck(MX, lb, ub);
        for i=1:pop_size
            New_Fit=feval(fhd,MX(i,:)',varargin{:});
            if New_Fit<Pop_Fit(i)
                Pop_Fit(i)=New_Fit;
                X(i,:)=MX(i,:);
            end
            if New_Fit<Best_Score
                Best_Score=New_Fit;
                Best_X=MX(i,:);
            end
        end
        
        %% Exploitation:
    else
        vel=1.5;
        M=2.5;
        L=0.2 + (2-0.2) * rand();
        r=M*vel^2/L;
        Captureability=1/(r*t2);
        u=0.15;%0.2
        
        for i=1:pop_size
            if Captureability> u
                delta=Captureability.*abs(X(i,:)-Best_X);
                MX(i,:)=t*delta.*(X(i,:)-Best_X)+X(i,:);
            else
                P=Levy(dim);
                MX(i,:)=Best_X-(Best_X-X(i,:)).*P*t;
            end
        end
        
        MX = boundaryCheck(MX, lb, ub);
        for i=1:pop_size
            New_Fit=feval(fhd,MX(i,:)',varargin{:});
            if New_Fit<Pop_Fit(i)
                Pop_Fit(i)=New_Fit;
                X(i,:)=MX(i,:);
            end
            if New_Fit<Best_Score
                Best_Score=New_Fit;
                Best_X=MX(i,:);
            end
        end
    end

    convergence_curve(It)=Best_Score;
end
end

%%
function o=Levy(d)
beta=1.5;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;
v=randn(1,d);
step=u./abs(v).^(1/beta);
o=step;
end


%%
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); 
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;  
end
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;  
    end
end
end

%%
function [ X ] = boundaryCheck(X, lb, ub)

for i=1:size(X,1)
    FU=X(i,:)>ub;
    FL=X(i,:)<lb;
    X(i,:)=(X(i,:).*(~(FU+FL)))+ub.*FU+lb.*FL;
end
end

%%
function m=Vshape(t)
m=((-1/pi)*t+1).*(t>0 & t<pi)+((1/pi)*t-1).*(t>=pi & t<2*pi);
end
