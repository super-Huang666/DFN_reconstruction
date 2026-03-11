function displayLine(linePoints)
    
    % Extract the starting point and end point coordinates of the logging line
    startPoint = linePoints(1, :);
    endPoint = linePoints(2, :);

    % Draw logging line
    hold on; 
    plot3([startPoint(1), endPoint(1)], [startPoint(2), endPoint(2)], [startPoint(3), endPoint(3)], 'LineWidth', 2, 'Color', 'k');
     hold off; 
end
