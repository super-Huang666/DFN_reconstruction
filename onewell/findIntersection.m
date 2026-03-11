function intersectionPoint = findIntersection(linePoints, planePoints)
% The line is defined by two points: linePoints = [x1, y1, z1; x2, y2, z2]
% The plane is defined by multiple points: planePoints

% Compute the direction vector of the line
directionVector = linePoints(2, :) - linePoints(1, :);

% Compute the normal vector of the plane
normalVector = cross(planePoints(2, :) - planePoints(1, :), ...
                     planePoints(3, :) - planePoints(1, :));

% Compute the parameter t on the line
t = dot(normalVector, planePoints(1, :) - linePoints(1, :)) / ...
    dot(normalVector, directionVector);

% Compute the intersection point
intersectionPoint = linePoints(1, :) + t * directionVector;
end
