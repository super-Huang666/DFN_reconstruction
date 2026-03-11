% Subfunctions: parameter perturbation
function [D_new, a_new, af_new, Nt_new] = perturbParameters(D, a, af, Nt, T)
    % Define small offset to prevent getting boundary value
    epsilon = 1e-6;  % Accuracy can be adjusted as required
    T_initial = 1000; % Consistent with the initial temperature of the main program

    % D: Fractal dimension (range 2.0~3.0)
    p_D = (T / T_initial) * 0.01; % The disturbance amplitude decreases with decreasing temperature
    D_new = D + (rand() - 0.5)* 2 * p_D;
    D_new = max(2.0+ epsilon , min(3.0 - epsilon, D_new)); % Limit value range

    % a: Length exponent (range 2.0~3.5)
    p_a = (T / T_initial) * 0.01;
    a_new = a + (rand() - 0.5)* 2 * p_a;
    a_new = max(2.0 + epsilon, min(3.5 - epsilon, a_new));

    % af: Normalization constant (range 0-5)
    p_af = (T / T_initial) * 0.1;
    af_new = af + (rand() - 0.5)* 2 * p_af;
    af_new = max(0, min(10, af_new));

    % Nt: The range of crack number and disturbance step are related to temperature
    max_Nt_step = round(20 * (T / T_initial)); % The lower the temperature, the smaller the step size
    Nt_new = Nt + round((rand() - 0.5) * 2 * max_Nt_step);
    Nt_new = max(686, min(6500, Nt_new)); % Range of fracture number
end
