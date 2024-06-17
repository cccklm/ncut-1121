%_________________________________________________________________________
% Main paper:
% Liver Cancer Algorithm: A novel bio-inspired optimizer
% Essam H. Houssein , Diego Oliva, Nagwan Abdelsamee, Noha F. Mahmoud, Marwa M. Emam
% Computers in Biology and Medicine, 
% DOI: 10.1016/j.compbiomed.2023.107389
% _____________________________________________________

%  
%  E-mails: essam.halim@mu.edu.eg           (Essam H. Houssein)
%           diego.oliva@cucei.udg.mx        (Diego Oliva)
%           nmabdelsamee@pnu.edu.sa         (Nagwan Abdelsamee) 
%           Nfmahmoud@pnu.edu.sa            (Noha F. Mahmoud)
%           marwa.khalef@mu.edu.eg          (Marwa M. Emam)
%________________________________________________________________________


function [Tumor_Energy,Tumor_Location,CNVG]=LCA(N,T,lb,ub,dim,fobj)

disp('LCA is now tackling your problem')
tic

% initialize the location and Energy of the tumor
Tumor_Location=zeros(1,dim);
Tumor_Energy=inf;

%Initialize the locations of tumor
X=initialization(N,dim,ub,lb);

CNVG=zeros(1,T);

t=0; % Loop counter

while t<T
    for i=1:size(X,1)
        % Check boundries
        FU=X(i,:)>ub;FL=X(i,:)<lb;X(i,:)=(X(i,:).*(~(FU+FL)))+ub.*FU+lb.*FL;
        % fitness of locations
        fitness=fobj(X(i,:));
        % Update the location of tumor
        if fitness<Tumor_Energy
            Tumor_Energy=fitness;
            Tumor_Location=X(i,:);
        end
    end


    r=rand();

v=r*t;
   
    % Update the location of tumor
    for i=1:size(X,1)
             f=1;
l=rand();
 w=rand();
        w=rand(); 
        
         if abs( v)<=5
           
             q=rand();
            rand_Hawk_index = floor(N*rand()+1);
            X_rand = X(rand_Hawk_index, :);
%tumor calculation             f=(1.5*l)/(l*w)^1.5;

         q=3.14/6*(l*w)^1.5;
%             f=(1.5*l)/(l*w)^1.5;
         q=3.14/6*(l*w)^1.5;
             if q<2
                % perch based on other family members
%                 X(i,:)=X_rand-rand()*abs(X_rand-2*rand()*X(i,:));
                 X(i,:)=(Tumor_Location(1,:)-mean(X))-rand()*((ub-lb)*rand+lb);
             elseif q<=2
                % perch on a random tall tree (random site inside group's home range)
                X(i,:)=(Tumor_Location(1,:)-mean(X))-rand()*((ub-lb)*rand+lb);
            end
            
       elseif q>=2&&q<5
           
            p = 2/3; %growth of tumor
                Jump_strength=v^p; % random jump strength of the tumor
                X(i,:)=(Tumor_Location-X(i,:))- v*abs(Jump_strength*Tumor_Location-X(i,:));
            
         
                
              %  Jump_strength=v^q;
                X1=Tumor_Location- v*abs(Jump_strength*Tumor_Location-X(i,:));
                   X1=MutationU(dim,T,Tumor_Location,t);
            
           
                 X1=Tumor_Location- v*abs(Jump_strength*Tumor_Location-X(i,:));
                   X1=MutationU(dim,T,Tumor_Location,t);
                  
                if fobj (X1(i,:)')<fobj (X(i,:)');  % improved move?
                    X(i,:)=X1;
                else 
                    X2=Tumor_Location- v*abs(Jump_strength*Tumor_Location-X(i,:))+rand(1,dim).*Levy(dim);
                     X2=MutationU(dim,T,Rabbit_Location,t);
                    if fobj(X2(i,:)')<fobj(X(i,:)');  % improved move?
                        X(i,:)=X2;
                    end
                     X3=rand.*X2+(1-rand).*X1; 
                      if fobj(X3(i,:)')<fobj(X(i,:)');  % improved move?
                        X(i,:)=X3;
                     end
                end
            end
        
        end
    t=t+1;
    CNVG(t)=Tumor_Energy;
end
toc
display(['At speed ', num2str(toc), ' the best speed is ', num2str(toc)]);
end

% ___________________________________
function o=Levy(d)
beta=1.5;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;v=randn(1,d);step=u./abs(v).^(1/beta);
o=step;
end
