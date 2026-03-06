function displayLine(linePoints)
    
    % 提取测井线的起始点和终点坐标
    startPoint = linePoints(1, :);
    endPoint = linePoints(2, :);

    % 绘制测井线
    hold on; % 保持当前图形，以便在上面添加新的图形元素
    plot3([startPoint(1), endPoint(1)], [startPoint(2), endPoint(2)], [startPoint(3), endPoint(3)], 'LineWidth', 2, 'Color', 'k');
     hold off; % 恢复默认的绘图模式
end