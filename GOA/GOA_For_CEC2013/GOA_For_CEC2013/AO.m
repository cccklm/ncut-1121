function [Best_Score,convergence_curve]= AO(fhd,dim,pop_size,iter_max,lb,ub,varargin);

Best_Score=inf;
convergence_curve=zeros(iter_max,1);

groups=3;
pop_size = pop_size/groups;
group=repmat(struct('X',{},'Pop_Fit',{}),1,groups);

for k=1:groups
    group(k).X=initialization(pop_size,dim,ub,lb);
    for i=1:pop_size
        group(k).Pop_Fit(i)=feval(fhd,group(k).X(i,:)',varargin{:});
        if group(k).Pop_Fit(i)<Best_Score
            Best_Score = group(k).Pop_Fit(i);
            Best_X = group(k).X(i,:);
        end
    end
    [~,group(k).index]=sort(group(k).Pop_Fit);
end
for k=1:groups
    for i=1:pop_size
        group(k).L(group(k).index(i)) = i/dim; %呆毛长度
        group(k).e(i)= rand*0.5;%旋转时的偏心系数
    end
end
for t=1:iter_max
    for k=1:groups
        group(k).m = abs(0.5-0.5*(t/iter_max));
        group(k).a = (100-(70)*t/iter_max)*sin(pi*rand);
        group(k).b = (100-(70)*t/iter_max)*cos(pi/2*rand);
        group(k).W = (2*rand-1)*(Best_X-group(k).X(i,:));
        for i=1:pop_size
            if rand < (0.6)
                group(k).R = (group(k).m*group(k).e(i) + (group(k).L(i)/dim)^2)*unifrnd(-group(k).a,group(k).a,1,dim);  %旋转
                if rand < 0.5
                    group(k).X(i,:) = Best_X + group(k).R + group(k).W;
                else     %进行跳动为主的复合运动
                    group(k).J = group(k).m*unifrnd(-group(k).b,group(k).b,1,dim);
                    group(k).X(i,:) = Best_X + group(k).J + group(k).W;

                end
            else   %合适的位置进行下探
                group(k).S = group(k).m*group(k).L(i)/dim*(2*pi).^0.5.*group(k).W;%费马螺旋线
                group(k).X(i,:) = Best_X + (Best_X-group(k).X(i,:)) + group(k).S  ;

            end
        end
        group(k).X = boundaryCheck(group(k).X, lb, ub);

        for i=1:pop_size
            group(k).Pop_Fit(i)=feval(fhd,group(k).X(i,:)',varargin{:});
            if group(k).Pop_Fit(i)<Best_Score
                Best_Score=group(k).Pop_Fit(i);
                Best_X=group(k).X(i,:);
            end
        end
        [~,group(k).index]=sort(group(k).Pop_Fit);
        for i=1:pop_size
            group(k).L(group(k).index(i)) = i/dim*(1-t/iter_max); %呆毛长度
            group(k).e(i)=rand*0.5;%旋转时的偏心系数
            group(k).X(group(k).index(end),:) = Best_X;
        end
    end

    convergence_curve(t)=Best_Score;
end

end

function [ X ] = boundaryCheck(X, lb, ub)

for i=1:size(X,1)
    FU=X(i,:)>ub;
    FL=X(i,:)<lb;
    X(i,:)=(X(i,:).*(~(FU+FL)))+ub.*FU+lb.*FL;
end
end
