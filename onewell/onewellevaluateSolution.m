% 子函数：评估参数解
function [objective, fnm, CFI_x, P10, selected] = onewellevaluateSolution(D, a, af, Nt, l_ratio, n, L, dim, CFI_x_initial, P10_initial,  bbx, pos, linePoints)
    lenPusPos = fracLenCen(l_ratio, D, n, a, af , L, Nt, dim);
    fnm = Field_DFN(DFN('dim', dim, 'n', Nt, 'shape', 'e', 'dip', 41, 'ddip', -1.97, 'dir', 167, 'ddir', -0.89, 'bbx', bbx, 'pos', pos, 'lenPusPos', lenPusPos), 'Poly');
    [CFI_x, P10, selected] = CFI(L, linePoints, fnm);
    
    % 检查CFI长度是否匹配
    if numel(CFI_x) ~= numel(CFI_x_initial)
%     if numel(P10) ~= numel(P10_initial)
        objective = Inf; % 无效解
        return;
    end
    
    objective = mean((CFI_x - CFI_x_initial).^2);
%     objective = mean((P10 - P10_initial).^2);
end