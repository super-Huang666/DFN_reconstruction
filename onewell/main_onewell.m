clc; clear;
Globals % global variable values
tic;%Start timing
D_initial = 2.5;
a_initial = 2.5;
af_initial = 5;
Nt_initial = 50;
[CFI_x_initial, P10_initial] = onewellloadInitialData();
l_ratio = 2; 
n = 5; 
L = 50; 
dim = 3;
lmin = L/2^n; % minimum fracture length
lenPusPos = fracLenCen(l_ratio, D_initial, n, a_initial, af_initial, L, Nt_initial, dim);
bbx = L * [0, 0, 0, 1, 1, 1]; 
pos = L * [1, 1, 1];
fnm = Field_DFN(DFN('dim', dim, 'n', Nt_initial, 'shape', 'e', 'dip', 41, 'ddip', -1.97, 'dir', 167, 'ddir', -0.89, 'bbx', bbx, 'pos', pos, 'lenPusPos', lenPusPos), 'Poly');
linePoints = [25, 25, 50; 25, 25, -5];
T_initial = 1000; % Initial temperature
T_min = 1; % Minimum temperature
alpha = 0.95; % Cooling rate
max_iter = 500; % Maximum iterations

% Call the subroutine
[D_opt, a_opt, af_opt, Nt_opt, objectiveValue,fnm_opt,optCFI_x_new,optP10_new,objective_history, selectedFracIndices_opt] = onewellsimulatedAnnealing(l_ratio, n, L, dim,CFI_x_initial, P10_initial, T_initial, T_min, alpha, max_iter, bbx, pos, linePoints, D_initial, a_initial, af_initial, Nt_initial);
fnm_opt_selected = fnm_opt(selectedFracIndices_opt);
fprintf('D_opt: %.4f\n', D_opt);
fprintf('a_opt: %.4f\n', a_opt);
fprintf('af_opt: %.4f\n', af_opt);
fprintf('Nt_opt: %d\n', Nt_opt);
fprintf('objectiveValue: %.4f\n', objectiveValue);
fprintf('optCFI_x_new: [%s]\n', strjoin(arrayfun(@(x) sprintf('%.4f', x), optCFI_x_new, 'UniformOutput', false), ', '));
fprintf('optP10_new: [%s]\n', strjoin(arrayfun(@(x) sprintf('%.4f', x), optP10_new, 'UniformOutput', false), ', '));
% Create abscissa vector
x1 = 1:length(CFI_x_initial);
x2 = 1:length(optCFI_x_new);
plot(x1, CFI_x_initial, 'b', 'LineWidth', 2);
hold on;
plot(x2, optCFI_x_new, 'r', 'LineWidth', 2);
plot(x1,P10_initial ,'b', 'LineWidth', 2);
hold on
plot(x2,optP10_new, 'r', 'LineWidth', 2);
Draw('poly', fnm);
set(gca, 'ZDir', 'reverse'); % Flip z-axis direction
linePoints = [100, 100, 200; 100, 100, 0];
% set(findobj(gca, 'Type', 'patch'), 'FaceColor', [0.5 0.3 0.1], 'EdgeColor', 'none', 'FaceAlpha', 1); 
set(findobj(gca, 'Type', 'patch'), 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [1 0 0], 'FaceAlpha', 1);
displayLine(linePoints);


% Draw('poly', fnm_opt_selected);
% displayLine(linePoints);
plot(objective_history, 'LineWidth', 1.5);
[iterations, values, final] = displayObjectiveHistory(objective_history);
% disp(objective_history(:));
% === Add timing end and output ===
totalTime = toc; % Stop timing and get total time (seconds)
fprintf('Total running time: %.2f second\n', totalTime);

