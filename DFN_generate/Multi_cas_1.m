    function [p_total,CumP]=Multi_cas_1(l_ratio,D,n,dim)
        %使用Multiplicative Cascade Process方法计算裂隙中心点的密度概率
        %l_ratio是子域与父域的长度的比值，在这里只计算了2的情况
        %D是裂隙终点的分形维数
        %n是迭代次数,实际迭代次数需要加1
        %p是密度概率
        %Cump是累积概率
        m=(1/l_ratio)^D;
%         syms p0 a b
%          p_sym=solve(p0^2-a*p0+(a^2-b)/2==0,'p0');%matlab 2017b
%         equ=p0^2-a*p0+(a^2-b)/2==0;%matlab 2021a
%         p_sym=solve(equ,p0);%matlab 2021a
        p=Multi_1(m,dim);
        switch dim
            case 2 %in two dimensions
                p_init=reshape(p,2,2);
                p_init_fix=p_init;
                for i=1:n
                    op=repelem(p_init_fix,2^i,2^i);%parent domain
                    for j=1:4
                        sw{j}=p_init(randperm(numel(p_init)));
                        p_random{j}=reshape(sw{j},size(p_init,1),size(p_init,2));
                    end
                    od=[p_random{1} p_random{2};...
                        p_random{3} p_random{4}];
                    p=od.*op;
                    clear p_random od op
                    p_init=p;      
                end
                p_total=p(:);
                CumP=cumsum(p_total);
            case 3 %in three dimensions
                p_init=reshape(p,2,2,2);
                p_init_fix=p_init;
                for i=1:n
                    op=repelem(p_init_fix,2^i,2^i,2^i);%parent domain
                    for j=1:8
                        sw{j}=p_init(randperm(numel(p_init)));
                        p_random{j}=reshape(sw{j},size(p_init,1),size(p_init,2),2^i);
                    end
                    od1=[p_random{1} p_random{2};p_random{3} p_random{4}];
                    od2=[p_random{5} p_random{6};p_random{7} p_random{8}];
                    od=cat(3,od1,od2);
                    p=od.*op;
                    clear p_random od op
                    p_init=p; 
                end
                p_total=p(:);
                CumP=cumsum(p_total);
        end
    end

    
    