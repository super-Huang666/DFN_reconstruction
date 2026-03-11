function isInside = isPointInPlane(point, planePoints)
%Judge whether the point is in the plane
    num=length(planePoints);
    m=1;
    for i=1:num-2
        for j=i+1:num-1
            for k=j+1:num
            A = planePoints(i, :);
            B = planePoints(j, :);
            C = planePoints(k, :);
        
            areaABC = 0.5 * norm(cross(B - A, C - A));
        
            areaABP = 0.5 * norm(cross(B - A, point - A));
            areaACP = 0.5 * norm(cross(C - A, point - A));
            areaBCP = 0.5 * norm(cross(C - B, point - B));
        
            if abs(areaABC - (areaABP + areaACP + areaBCP)) < 1e-6
                isIn(m) = true;
            else
                isIn(m) = false;
            end
                m=m+1;
                isInside=max(isIn);
            end
        end
    end
end
