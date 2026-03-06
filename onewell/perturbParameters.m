% 子函数：参数扰动
function [D_new, a_new, af_new, Nt_new] = perturbParameters(D, a, af, Nt, T)
    % 定义微小偏移量防止取到边界值
    epsilon = 1e-6;  % 可根据需求调整精度
    T_initial = 1000; % 与主程序初始温度一致

    % D: 分形维数（范围 2.0~3.0）
    p_D = (T / T_initial) * 0.01; % 扰动幅度随温度降低缩小
    D_new = D + (rand() - 0.5)* 2 * p_D;
    D_new = max(2.0+ epsilon , min(3.0 - epsilon, D_new)); % 限制取值范围

    % a: 长度指数（范围 2.0~3.5）
    p_a = (T / T_initial) * 0.01;
    a_new = a + (rand() - 0.5)* 2 * p_a;
    a_new = max(2.0 + epsilon, min(3.5 - epsilon, a_new));

    % af: 归一化常数（范围 0~5）
    p_af = (T / T_initial) * 0.1;
    af_new = af + (rand() - 0.5)* 2 * p_af;
    af_new = max(0, min(10, af_new));

    % Nt: 裂缝数量范围，扰动步长与温度相关）
    max_Nt_step = round(20 * (T / T_initial)); % 温度越低，步长越小
    Nt_new = Nt + round((rand() - 0.5) * 2 * max_Nt_step);
    Nt_new = max(20, min(80, Nt_new)); % 范围
end