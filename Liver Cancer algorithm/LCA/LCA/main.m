% Developed in MATLAB R2013b
% _____________________________________________________
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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all %#ok<CLALL>
close all
clc

N=30; % Number of search agents

Func_name='F1'; % Name of the test function 

T=500; % Maximum number of iterations


[lb,ub,dim,fobj]=Get_Functions_details(Func_name);
 tic;
[Best_score,Best_pos,CNVG]=LCA(N,T,lb,ub,dim,fobj);


%Draw objective space
figure,
hold on
semilogy(CNVG,'Color','b','LineWidth',4);
title('Convergence curve')
xlabel('Iteration');
ylabel('Best fitness obtained so far');
axis tight
grid off
box on
legend('LCA')

display(['The best location of LCA is: ', num2str(Best_pos)]);
display(['The best fitness of LCA is: ', num2str(Best_score)]);
time1=toc;



     
