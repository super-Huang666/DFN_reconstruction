function p=Multi_1(m,dim)  
%sole the equation
switch dim
    case 2
        while 1
            p_n=rand(2,1);
            a=1-sum(p_n);
            b=m-sum(p_n.*p_n);
            if a<=0 || b<=0 || a>=sqrt(2*b)
                continue
            end
%             p3=eval(p_sym);
%             p4=a-p3;
            p3=a/2 - (- a^2 + 2*b)^(1/2)/2;
            p4=a-p3;
            break;
        end
        p=[p_n' p3 p4];
    case 3
        while 1
            p_n=rand(6,1);
            a=1-sum(p_n);
            b=m-sum(p_n.*p_n);
            if a<0 || b<0 || a<sqrt(b)||(- a^2 + 2*b)<0
                continue
            end
%             p7=eval(p_sym);
%             p8=a-p7;
            p7=a/2 - (- a^2 + 2*b)^(1/2)/2;
            p8=a-p7;
            p=[p_n' p7 p8];
            break;
        end
end