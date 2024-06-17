%%  闲鱼：深度学习与智能算法
%%  唯一官方店铺：https://mbd.pub/o/autDCSr-aWWbm3BtZw==
%%  微信公众号：强盛机器学习，关注公众号获得更多免费代码！
% =============================================================================================================================================================================
% Differentiated Creative Search (DCS)

% CITATION:
% Duankhan P., Sunat K., Chiewchanwattana S., and Nasa-ngium P. "The Differentiated Creative Search (DCS): Leveraging Differentiated Knowledge-acquisition and Creative Realism
% to Address Complex Optimization Problems". (Accepted for publication in Expert Systems with Applications)
% =============================================================================================================================================================================

function [feasible_solution] = FeasibleFunction(input_solution, problem_options)

row_dim = size(input_solution,1);
col_dim = size(input_solution,2);

% If the solution is column vector then convert it to row vector
if col_dim < row_dim
    x_input_solution = input_solution';
else
    x_input_solution = input_solution;
end

% Store the input solution
tmp_feasible_solution(1,:) = x_input_solution(1,:);

% Make sure the solution is an integer between the allowable values
for j = 1:problem_options.dim
    tmp_feasible_solution(1,j) = max(tmp_feasible_solution(1,j), problem_options.lb(j));
    tmp_feasible_solution(1,j) = min(tmp_feasible_solution(1,j), problem_options.ub(j));
end

% Return the feasible solution
feasible_solution = tmp_feasible_solution(1,1:problem_options.dim);

end

%%  闲鱼：深度学习与智能算法
%%  唯一官方店铺：https://mbd.pub/o/autDCSr-aWWbm3BtZw==
%%  微信公众号：强盛机器学习，关注公众号获得更多免费代码！
