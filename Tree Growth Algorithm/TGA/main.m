%_________________________________________________________________________________
%_________________________________________________________________________________
clear all 
clc

SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 
Max_iteration=500; % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best_score,Best_pos,cg_curve]=TGA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

display(['The best solution obtained by OPTIMIZER is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective function found by OPTIMIZER is : ', num2str(Best_score)]);

%Draw objective space
figure,
subplot(1,2,1);
func_plot(Function_name);
title([Function_name])
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])
set(gca,'color','none')
grid off

subplot(1,2,2);
semilogy(cg_curve,'Color','b','LineWidth',4);
title('Convergence curve')
xlabel('Iteration');
ylabel('Best fitness obtained so far');
axis tight
grid off
box on
legend('TGA')