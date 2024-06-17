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
function [X]=initialization(N,dim,up,down)

if size(up,1)==1
    X=rand(N,dim).*(up-down)+down;
end
if size(up,1)>1
    for i=1:dim
        high=up(i);low=down(i);
        X(:,i)=rand(1,N).*(high-low)+low;
    end
end
end