%%  闲鱼：深度学习与智能算法
%%  唯一官方店铺：https://mbd.pub/o/autDCSr-aWWbm3BtZw==
%%  微信公众号：强盛机器学习，关注公众号获得更多免费代码！
clear
clc
close all

%%  参数设置
SearchAgents = 30;                        % population members 
Max_iterations = 1000;                    % maximum number of iteration
number = 'F13';                           % 选定优化函数，自行替换:F1~F23
[lb,ub,dim,fobj] = CEC2005(number);       % [lb,ub,D,y]：下界、上界、维度、目标函数表达式

%%  调用算法
[PSO_pos,PSO_score,PSO_curve]=PSO(SearchAgents,Max_iterations,ub,lb,dim,fobj);        % 调用PSO算法
[DCS_pos,DCS_score,DCS_Convergence_curve]=DCS(SearchAgents,Max_iterations,ub,lb,dim,fobj); % 调用DCS算法

%% Figure
figure1 = figure('Color',[1 1 1]);
G1=subplot(1,2,1,'Parent',figure1);
func_plot(number)
title(number)
xlabel('x')
ylabel('y')
zlabel('z')
subplot(1,2,2)
G2=subplot(1,2,2,'Parent',figure1);
CNT=20;
k=round(linspace(1,Max_iterations,CNT)); %随机选CNT个点
% 注意：如果收敛曲线画出来的点很少，随机点很稀疏，说明点取少了，这时应增加取点的数量，100、200、300等，逐渐增加
% 相反，如果收敛曲线上的随机点非常密集，说明点取多了，此时要减少取点数量
iter=1:1:Max_iterations;
if ~strcmp(number,'F16')&&~strcmp(number,'F9')&&~strcmp(number,'F11')  %这里是因为这几个函数收敛太快，不适用于semilogy，直接plot
    semilogy(iter(k),PSO_curve(k),'m-*','linewidth',1);
    hold on
    semilogy(iter(k),DCS_Convergence_curve(k),'r->','linewidth',1);
else
    plot(iter(k),PSO_curve(k),'m-*','linewidth',1);
    hold on
    plot(iter(k),DCS_Convergence_curve(k),'r->','linewidth',1);
end
grid on;
title('收敛曲线')
xlabel('迭代次数');
ylabel('适应度值');
box on
legend('PSO','DCS')
set (gcf,'position', [300,300,800,330])

