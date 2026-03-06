function [D_opt, a_opt, af_opt, Nt_opt, objectiveValue,fnm_opt,optCFI_x_new,optP10_new,objective_history,selectedFracIndices_opt] = onewellsimulatedAnnealing(l_ratio, n, L, dim,CFI_x_initial, P10_initial, T_initial, T_min, alpha, max_iter, bbx, pos, linePoints, D_initial, a_initial, af_initial, Nt_initial)
    % Current parameters
    current_D = D_initial; 
    current_a = a_initial; 
    current_af = af_initial; 
    current_Nt = Nt_initial;
    [current_objective, current_fnm, current_CFI, current_P10, current_selected] = onewellevaluateSolution(current_D, current_a, current_af, current_Nt, l_ratio, n, L, dim, CFI_x_initial, P10_initial, bbx, pos, linePoints);
    % 初始化最佳解
    best_objective = current_objective;
    best_params = [current_D, current_a, current_af, current_Nt];
    best_fnm = current_fnm;
    best_CFI = current_CFI;
    best_P10 = current_P10;
    best_selected = current_selected;
    objective_history = [current_objective];
    T = T_initial;
    while T > T_min
        for iter = 1:max_iter
            % Randomly perturb parameters
            [D_new, a_new, af_new, Nt_new] = perturbParameters(current_D, current_a, current_af, current_Nt, T);
            fprintf('Iter %d: D_new=%.4f, a_new=%.4f, af_new=%.4f, Nt_new=%d\n', ...
                iter, D_new, a_new, af_new, Nt_new);

            % 计算新解的目标函数
            [objective_new, fnm_new, CFI_new, P10_new, selected_new] = onewellevaluateSolution(D_new, a_new, af_new, Nt_new, l_ratio, n, L, dim, CFI_x_initial, P10_initial, bbx, pos, linePoints);
            fprintf('  CFI_x length = %d\n', length(CFI_new));
            % 接受准则
            delta = objective_new - current_objective;
            accept = false;
            if delta < 0
                accept = true; % 接受更优解
            else
                prob = exp(-delta / T);
                if rand() < prob
                    accept = true; % 以一定概率接受较差解
                end
            end
            if accept
                % 接受新解作为当前解
                current_D = D_new;
                current_a = a_new;
                current_af = af_new;
                current_Nt = Nt_new;
                current_objective = objective_new;
                current_fnm = fnm_new;
                current_CFI = CFI_new;
                current_P10 = P10_new;
                current_selected = selected_new;
                
                % 更新全局最优解
                if current_objective < best_objective
                    best_objective = current_objective;
                    best_params = [current_D, current_a, current_af, current_Nt];
                    best_fnm = current_fnm;
                    best_CFI = current_CFI;
                    best_P10 = current_P10;
                    best_selected = current_selected;
                end
            end
            % 记录目标函数历史
            objective_history(end+1) = current_objective;
            
            % 输出日志
            fprintf('Iteration %d: T=%.2f, Current Objective=%.4f, Best Objective=%.4f\n', iter, T, current_objective, best_objective);
        end
        % Reduce temperature
        T = T * alpha;
    end

        % 返回最优解
    D_opt = best_params(1);
    a_opt = best_params(2);
    af_opt = best_params(3);
    Nt_opt = best_params(4);
    objectiveValue = best_objective;
    fnm_opt = best_fnm;
    optCFI_x_new = best_CFI;
    optP10_new = best_P10;
    selectedFracIndices_opt = best_selected;
end