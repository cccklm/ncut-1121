clear all
clc
%%
SearchAgents_no=30;  % Number of search agents
Max_iteration=1000; % Maximum numbef of iterations最大迭代数
lb=-100;
ub=100;
dim=50;
fhd=str2func('cec13_func');


for i = 1:28
    func_num = i;
    for j = 1:30
        i,j,
        [Best_score1,f1_curve]=GOA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num);  
        [Best_score2,f2_curve]=AO(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num);  
        [Best_score3,f3_curve]=BOA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        [Best_score4,f4_curve]=DE(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 

        [Best_score5,f5_curve]=GSA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        [Best_score6,f6_curve]=HHO(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        [Best_score7,f7_curve]=PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        [Best_score8,f8_curve]=SCA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        [Best_score9,f9_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
%         [Best_score10,f10_curve]=SSA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
%         [Best_score11,f11_curve]=DA(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
%         [Best_score12,f12_curve]=ALO(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
%         [Best_score13,f13_curve]=PEO(SearchAgents_no,Max_iteration,lb,ub,dim,fhd,func_num); 
        
        fbest1(i,j)=Best_score1;
        fbest2(i,j)=Best_score2;
        fbest3(i,j)=Best_score3;
        fbest4(i,j)=Best_score4;

        fbest5(i,j)=Best_score5;
        fbest6(i,j)=Best_score6;
        fbest7(i,j)=Best_score7;
        fbest8(i,j)=Best_score8;
        fbest9(i,j)=Best_score9;
%         fbest10(i,j)=Best_score10;
%         fbest11(i,j)=Best_score11;
%         fbest12(i,j)=Best_score12;
%         fbest13(i,j)=Best_score13;
        
        for t = (Max_iteration/20):(Max_iteration/20):Max_iteration
            a = t/(Max_iteration/20);
            FV1(j,a) =  f1_curve(t);
            FV2(j,a) =  f2_curve(t);
            FV3(j,a) =  f3_curve(t);
            FV4(j,a) =  f4_curve(t);

            FV5(j,a) =  f5_curve(t);
            FV6(j,a) =  f6_curve(t);
            FV7(j,a) =  f7_curve(t);
            FV8(j,a) =  f8_curve(t);
            FV9(j,a) =  f9_curve(t);
%             FV10(j,a) =  f10_curve(t);
%             FV11(j,a) =  f11_curve(t);
%             FV12(j,a) =  f12_curve(t);
%             FV13(j,a) =  f13_curve(t);
            
        end
        fprintf('It is currently iterating to the %d TH time; \n' ,i);
    end
    for g = 1:20
        fv_mean1(i,g) = mean(FV1(:,g));%用此画图
        fv_mean2(i,g) = mean(FV2(:,g));
        fv_mean3(i,g) = mean(FV3(:,g));
        fv_mean4(i,g) = mean(FV4(:,g));

        fv_mean5(i,g) = mean(FV5(:,g));
        fv_mean6(i,g) = mean(FV6(:,g));
        fv_mean7(i,g) = mean(FV7(:,g));
        fv_mean8(i,g) = mean(FV8(:,g));
        fv_mean9(i,g) = mean(FV9(:,g));
%         fv_mean10(i,g) = mean(FV10(:,g));
%         fv_mean11(i,g) = mean(FV11(:,g));
%         fv_mean12(i,g) = mean(FV12(:,g));
%         fv_mean13(i,g) = mean(FV13(:,g));
    end
    %求平均值
    f_mean1(i)=mean(fbest1(i,:));
    f_mean2(i)=mean(fbest2(i,:));
    f_mean3(i)=mean(fbest3(i,:));
    f_mean4(i)=mean(fbest4(i,:));

    f_mean5(i)=mean(fbest5(i,:));
    f_mean6(i)=mean(fbest6(i,:));
    f_mean7(i)=mean(fbest7(i,:));
    f_mean8(i)=mean(fbest8(i,:));
    f_mean9(i)=mean(fbest9(i,:));
%     f_mean10(i)=mean(fbest10(i,:));
%     f_mean11(i)=mean(fbest11(i,:));
%     f_mean12(i)=mean(fbest12(i,:));
%     f_mean13(i)=mean(fbest13(i,:));
    %求标准差
     f_std1(i)=std(fbest1(i,:));
     f_std2(i)=std(fbest2(i,:));
     f_std3(i)=std(fbest3(i,:));
     f_std4(i)=std(fbest4(i,:));
     f_std5(i)=std(fbest5(i,:));

     f_std6(i)=std(fbest6(i,:));
     f_std7(i)=std(fbest7(i,:));
     f_std8(i)=std(fbest8(i,:));
     f_std9(i)=std(fbest9(i,:));
%      f_std10(i)=std(fbest10(i,:));
%      f_std11(i)=std(fbest11(i,:));
%      f_std12(i)=std(fbest12(i,:));
%      f_std13(i)=std(fbest13(i,:));
    %求最好值
     f_min1(i)=min(fbest1(i,:));
     f_min2(i)=min(fbest2(i,:));
     f_min3(i)=min(fbest3(i,:));
     f_min4(i)=min(fbest4(i,:));

     f_min5(i)=min(fbest5(i,:));
     f_min6(i)=min(fbest6(i,:));
     f_min7(i)=min(fbest7(i,:));
     f_min8(i)=min(fbest8(i,:));
     f_min9(i)=min(fbest9(i,:));
%      f_min10(i)=min(fbest10(i,:));
%      f_min11(i)=min(fbest11(i,:));
%      f_min12(i)=min(fbest12(i,:));
%      f_min13(i)=min(fbest13(i,:));


 %求最坏值
     f_max1(i)=max(fbest1(i,:));
     f_max2(i)=max(fbest2(i,:));
     f_max3(i)=max(fbest3(i,:));
     f_max4(i)=max(fbest4(i,:));

     f_max5(i)=max(fbest5(i,:));
     f_max6(i)=max(fbest6(i,:));
     f_max7(i)=max(fbest7(i,:));
     f_max8(i)=max(fbest8(i,:));
     f_max9(i)=max(fbest9(i,:));
end








