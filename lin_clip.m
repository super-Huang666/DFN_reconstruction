function [y,b]=lin_clip(x,bbx)
    %对Multiplicative cascade生成的线在指定区域内进行裁剪
    [x1,y1,x2,y2] = CData.Deal(bbx);                                    % for convenience
    dx1 = [x1,y1,x2-x1,0];
    dx2 = [x1,y2,x2-x1,0];
    dy1 = [x1,y1,0,y2-y1];
    dy2 = [x2,y1,0,y2-y1];
    out1 = [x(:,1) < x1,x(:,1) > x2,x(:,2) < y1,x(:,2) > y2];
    out2 = [x(:,3) < x1,x(:,3) > x2,x(:,4) < y1,x(:,4) > y2];
    in = (sum(out1 | out2,2) == 0);%不需要修建的线
    inx = find(~(in | (sum(out1 & out2,2) > 0)));%找到需要修剪的线的行号
    y = nan(size(x));
    y(in,:) = x(in,:);%加入不需要修剪的线
    XY1=x(inx,:);%需要截断的直线
    xlimit = [0 x2-x1];%根据实际修改
    ylimit=[0 y2-y1];
    xbox = xlimit([1 1 2 2 1]);
    ybox = ylimit([1 2 2 1 1]);
    for i=1:size(XY1,1)
        xx=XY1(i,[1 3]);
        yy=XY1(i,[2 4]);
        [xi,yi,~] = polyxpoly(xx,yy,xbox,ybox);
        out1 = [XY1(i,1) < x1,XY1(i,1) > x2,XY1(i,2) < y1,XY1(i,2) > y2];
        out2 = [XY1(i,3) < x1,XY1(i,3) > x2,XY1(i,4) < y1,XY1(i,4) > y2];
        if sum(out1)>sum(out1)
            XY1(i,1)=xi;
            XY1(i,2)=yi;
        elseif sum(out1)<sum(out1)
            XY1(i,3)=xi;
            XY1(i,4)=yi;
        else
            XY1(i,[1 3])=xi';
            XY1(i,[2 4])=yi';
        end
        y(inx(i),:)=XY1(i,:);
    end
    b=in;
end


