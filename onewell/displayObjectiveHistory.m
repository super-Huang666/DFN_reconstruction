function [first_occur_iter, unique_vals, final_value] = displayObjectiveHistory(objective_history)
% DISPLAYOBJECTIVEHISTORY 显示目标函数优化历史
%   输入参数:
%       objective_history - 目标函数值历史记录向量
%
%   输出参数:
%       first_occur_iter - 唯一值首次出现的迭代次数
%       unique_vals      - 对应的唯一目标值
%       final_value      - 最终优化结果值

    % 检查输入是否为空
    if isempty(objective_history)
        disp('目标函数历史为空');
        first_occur_iter = [];
        unique_vals = [];
        final_value = [];
        return;
    end
    
    % 找出所有目标值首次出现的位置
    [unique_vals, first_occur_indices] = unique(objective_history, 'first');
    
    % 按迭代顺序排序
    [sorted_indices, sort_order] = sort(first_occur_indices);
    sorted_vals = unique_vals(sort_order);
    
    % 设置输出参数
    first_occur_iter = sorted_indices;
    unique_vals = sorted_vals;
    final_value = objective_history(end);
    
    % 显示结果 - 优化为Excel友好格式
    disp('复制以下数据到Excel:');
    disp('迭代次数 | 目标函数值');
    disp('---------------------');
    
    % 创建表格数据字符串
    data_str = '';
    for i = 1:length(sorted_indices)
        % 创建制表符分隔的行
        row_str = sprintf('%d\t%.6f\n', sorted_indices(i), sorted_vals(i));
        fprintf(row_str);  % 显示在命令窗口
        data_str = [data_str, row_str];  % 添加到完整数据字符串
    end
    
    % 添加最终结果行
    final_row = sprintf('\n最终结果\t%.6f\t(迭代 %d)\n', final_value, length(objective_history));
    fprintf(final_row);
    data_str = [data_str, final_row];
end