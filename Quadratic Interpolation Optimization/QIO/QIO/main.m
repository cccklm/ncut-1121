
   %%% Quadratic Interpolation Optimization (QIO) for 23 functions %%%
%--------------------------------------------------------------------------%
% Quadratic Interpolation Optimization (QIO)                               %
% Source codes demo version 1.0                                            %
% The code is based on the following paper:                                %
% W. Zhao, L. Wang, Z. Zhang, S. Mirjalili, N. Khodadadi, Q. Ge, Quadratic % 
% Interpolation Optimization (QIO): A new optimization algorithm based on  % 
% generalized quadratic interpolation and its applications to real-world   % 
% engineering problems, Computer Methods in Applied Mechanics and          %
% Engineering (2023) 116446, https://doi.org/10.1016/j.cma.2023.116446.    %
%--------------------------------------------------------------------------%
clc;
clear;

MaxIteration=500;
PopSize=50;

FunIndex=1;
    [BestX,BestF,HisBestF]=QIO(FunIndex,MaxIteration,PopSize);
   
    display(['The best fitness of F',num2str(FunIndex),' is: ', num2str(BestF)]);
   

    if BestF>0
        semilogy(HisBestF,'r','LineWidth',2);
    else
        plot(HisBestF,'r','LineWidth',2);
    end

    xlabel('Iterations');
    ylabel('Fitness');
    title(['F',num2str(FunIndex)]);





    
    

