function [first_occur_iter, unique_vals, final_value] = displayObjectiveHistory(objective_history)
% DISPLAYOBJECTIVEHISTORY Display objective function optimization history
%   Input:
%       objective_history - Vector of objective function value history
%
%   Output:
%       first_occur_iter - Iteration numbers where unique values first appear
%       unique_vals      - Corresponding unique objective values
%       final_value      - Final optimized objective value

    % Check if the input is empty
    if isempty(objective_history)
        disp('Objective function history is empty');
        first_occur_iter = [];
        unique_vals = [];
        final_value = [];
        return;
    end
    
    % Find the first occurrence positions of all objective values
    [unique_vals, first_occur_indices] = unique(objective_history, 'first');
    
    % Sort according to iteration order
    [sorted_indices, sort_order] = sort(first_occur_indices);
    sorted_vals = unique_vals(sort_order);
    
    % Set output variables
    first_occur_iter = sorted_indices;
    unique_vals = sorted_vals;
    final_value = objective_history(end);
    
    % Display results - optimized for Excel-friendly format
    disp('Copy the following data to Excel:');
    disp('Iteration | Objective Value');
    disp('---------------------------');
    
    % Create table data string
    data_str = '';
    for i = 1:length(sorted_indices)
        % Create tab-separated row
        row_str = sprintf('%d\t%.6f\n', sorted_indices(i), sorted_vals(i));
        fprintf(row_str);  % Display in command window
        data_str = [data_str, row_str];  % Append to full data string
    end
    
    % Add final result row
    final_row = sprintf('\nFinal Result\t%.6f\t(Iteration %d)\n', final_value, length(objective_history));
    fprintf(final_row);
    data_str = [data_str, final_row];
end
