function intersectionPoint = findIntersection(linePoints, planePoints)
% 直线由两个点定义 linePoints = [x1, y1, z1; x2, y2, z2]
% 平面由多个点定义 planePoints

% 计算直线的方向向量
directionVector = linePoints(2, :) - linePoints(1, :);

%  计算平面的法向量
normalVector = cross(planePoints(2, :) - planePoints(1, :), planePoints(3, :) - planePoints(1, :));

% 计算直线上的参数 t
t = dot(normalVector, planePoints(1, :) - linePoints(1, :)) / dot(normalVector, directionVector);

% 计算交点
intersectionPoint = linePoints(1, :) + t * directionVector;
end