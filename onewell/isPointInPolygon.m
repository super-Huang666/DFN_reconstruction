function inside = isPointInPolygon(point, polygon)
    % 判断点是否在平面多边形内（使用射线法）
    x = point(1); y = point(2); 
    polyX = polygon(:,1); polyY = polygon(:,2);
    n = length(polyX);
    inside = false;
    j = n;
    for i = 1:n
        if ((polyY(i) > y) ~= (polyY(j) > y)) && ...
           (x < (polyX(j) - polyX(i)) * (y - polyY(i)) / (polyY(j) - polyY(i)) + polyX(i))
            inside = ~inside;
        end
        j = i;
    end
end