function [t, point] = linePlaneIntersection(P0, P1, planePoint, planeNormal)
    % 计算线段P0-P1与平面的交点
    u = P1 - P0;
    w = P0 - planePoint;
    D = dot(planeNormal, u);
    N = -dot(planeNormal, w);
    if abs(D) < 1e-6
        t = Inf;
        point = [];
    else
        t = N / D;
        if t >= 0 && t <= 1
            point = P0 + t * u;
        else
            point = [];
        end
    end
end