%%===================== User Input =================================
disp("Welcome to Final Project 9229_9634");
fs = input("Enter sampling frequency (default 1000): ");
if isempty(fs)
    fs = 1000;
end
t1 = input("Enter start of time axis (default -10): ");
if isempty(t1)
    t1 = -10;
end
t2 = input("Enter end of time axis (default 10): ");
if isempty(t2)
    t2 = 10;
end

nbp = input("Enter Number of breakpoints (default [0,-2,-3]): ");
if ~isempty(nbp)
    bp = zeros(1, nbp);
    for i=1:nbp
        in = input(sprintf("Enter breakpoint %d: ", i));
        if ~isempty(in)
            bp(i) = in;
        else
            bp(i) = 0;
        end
    end
else
    bp = [0 -2 -3];
    nbp = numel(bp);
end

fs,t1,t2,nbp,bp  %test

%%===================== Region Splitting =================================
bp = sort(bp);
t = t1 : 1/fs : t2;

all_points = [t1, bp, t2];
regions = {};

for k = 1:length(all_points)-1
    t_reg = t( t >= all_points(k) & t <= all_points(k+1) );
    regions{k} = t_reg;
end

fprintf("\nRegions created successfully: %d regions\n", numel(regions));


%%========================== Main Menu ====================================

menu = sprintf('%s', ...
"----------- MENU -----------" + newline + ...
"1) DC" + newline + ...
"2) Ramp" + newline + ...
"3) Polynomial" + newline + ...
"4) Exponential" + newline + ...
"5) Sinusoidal" + newline + ...
"6) Gaussian pulse" + newline + ...
"7) Sawtooth wave" + newline + ...
"----------------------------" + newline);

% clear screen and print menu
clc; disp(menu);
choice = input("Choose menu option: ");
i = 0; MAX_ATTEMPTS = 3;
while (isempty(choice) || choice < 1 || choice > 7) && i < MAX_ATTEMPTS
    choice = input("Error! Choose valid menu option: ");
    i = i+1;
end
if i == MAX_ATTEMPTS 
disp("Too many attempts, try again later.");
end

%%===================== Generate the signal based on regions =================================

x = [];

for k = 1:length(regions)
    fprintf("Enter parameters for region %d:\n", k);
    yk = generate_signal(choice, regions{k});  % call new function
    x = [x yk];
end

fprintf("\nSignal generated successfully.\n\n");

%%============================ Operation Menu ================================================

opMenu = sprintf('%s', ...
"----------- MENU -----------" + newline + ...
"1) Amplitude scaling" + newline + ...
"2) Time reversal" + newline + ...
"3) Time shift" + newline + ...
"4) Expansion"+ newline + ...
"5) Compression"+ newline + ...
"6) Addition of random noise"+ newline + ...
"7) Smoothing using moving average" + newline + ...
"8) None" + newline + ...
"----------------------------" + newline);

clc; disp(opMenu);
op_choice = input("Choose menu option: ");
i = 0; MAX_ATTEMPTS = 3;
while (isempty(op_choice) || op_choice < 1 || op_choice > 8) && i < MAX_ATTEMPTS
    op_choice = input("Error! Choose valid menu option: ");
    i = i+1;
end
if i == MAX_ATTEMPTS 
disp("Too many attempts, try again later.");
end

%%===================== Apply operation =================================

[t_new, x_new] = apply_operation(op_choice, t, x);

fprintf("\nOperation applied successfully.\n\n");

%%===================== Generate Signals ================================

%Test case, highlight and press Ctrl+Shift+R
% t = -5:1e-3:5;
% x = t.^2;
% figure
% plot(t,x, 'LineWidth', 1);
% save_figure();

%%===================== Plot and Save =================================
% Make sure vectors have the same length
min_len = min(length(t_new), length(x_new));
t_new = t_new(1:min_len);
x_new = x_new(1:min_len);

figure;
plot(t_new, x_new, 'LineWidth', 1);
xlabel("Time");
ylabel("x(t)");
title("Generated Signal");
grid on;

save_figure();

fprintf("Figure saved successfully!\n");


%%======================== Functions ==================================

function save_figure()
    fig = gcf;

    num  = fig.Number;
    fname = sprintf('Figure%d.png', num);

    % Force light-mode
    set(fig, 'Color', 'white');
    ax = findall(fig, 'Type', 'axes');
    set(ax, 'Color','white', 'XColor','black','YColor','black');

    % Save PNG
    exportgraphics(fig, fname, 'Resolution', 300);
end

%%===================== Generate Signal Function ===========================
function y = generate_signal(choice, t)

    switch choice
        case 1
            A = input("Enter DC amplitude (default 1): "); if isempty(A), A=1; end
            y = A * ones(size(t));

        case 2
            m = input("Enter slope (default 1): "); if isempty(m), m=1; end
            c = input("Enter intercept (default 0): "); if isempty(c), c=0; end
            y = m*t + c;

        case 3
            coeffs = input("Enter polynomial coefficients [a b c] (default [1 0 0]): ");
            if isempty(coeffs), coeffs = [1 0 0]; end
            y = polyval(coeffs, t);

        case 4
            A = input("Enter amplitude (default 1): "); if isempty(A), A=1; end
            a = input("Enter exponent (default -1): "); if isempty(a), a=-1; end
            y = A * exp(a*t);

        case 5
            A = input("Enter amplitude (default 1): "); if isempty(A), A=1; end
            f = input("Enter frequency (default 1): "); if isempty(f), f=1; end
            y = A * sin(2*pi*f*t);

        case 6
            A = input("Enter amplitude (default 1): "); if isempty(A), A=1; end
            mu = input("Enter mean (default 0): "); if isempty(mu), mu=0; end
            s = input("Enter sigma (default 1): "); if isempty(s), s=1; end
            y = A * exp(-((t-mu).^2)/(2*s^2));

        case 7
            A = input("Enter amplitude (default 1): "); if isempty(A), A=1; end
            f = input("Enter frequency (default 1): "); if isempty(f), f=1; end
            y = A * (2*((t*f) - floor(0.5 + t*f)));
    end
end


%%======================= Apply Operation Function ================================
function [t_out, y_out] = apply_operation(op_choice, t, y)

    switch op_choice
        
        case 1
            s = input("Enter scaling factor: ");
            y_out = s*y;
            t_out = t;

        case 2
            t_out = -fliplr(t);
            y_out = fliplr(y);

        case 3
            sh = input("Enter shift amount: ");
            t_out = t + sh;
            y_out = y;

        case 4
            a = input("Enter expansion factor: ");
            t_out = t * a;
            y_out = y;

        case 5
            a = input("Enter compression factor: ");
            t_out = t / a;
            y_out = y;

        case 6
            snr = input("Enter SNR (dB): ");
            y_out = awgn(y, snr, 'measured');
            t_out = t;

        case 7
            w = input("Enter window length: ");
            y_out = movmean(y, w);
            t_out = t;

        case 8
            y_out = y;
            t_out = t;
    end
end

%%======================= AUTO MODE (Generate 10 Random Signals) ============================
fprintf("\nStarting AUTO MODE: Generating 10 random signals...\n");

for k = 1:10

    % Random FS and time axis
    fs_auto = randi([500 2000]);
    t1_auto = -5;
    t2_auto = 5;
    t_auto = t1_auto : 1/fs_auto : t2_auto;

    % Random number of breakpoints (0 to 4)
    nbp_auto = randi([0 4]);

    % Generate random breakpoints
    if nbp_auto > 0
        bp_auto = sort( (t1_auto + (t2_auto - t1_auto) .* rand(1, nbp_auto)) );
    else
        bp_auto = [];
    end

    % Build regions
    all_points_auto = [t1_auto, bp_auto, t2_auto];
    regions_auto = {};

    for j = 1:length(all_points_auto)-1
        t_reg = t_auto(t_auto >= all_points_auto(j) & t_auto <= all_points_auto(j+1));
        regions_auto{j} = t_reg;
    end

    % Generate random type (1 to 7)
    choice_auto = randi([1 7]);

    % Build the signal
    x_auto = [];
    for j = 1:length(regions_auto)
        x_auto = [x_auto generate_signal_auto(choice_auto, regions_auto{j})];
    end

    % Save the figure
    figure;
    plot(t_auto, x_auto, 'LineWidth', 1);
    title(sprintf("AUTO SIGNAL %d", k));
    xlabel("t");
    ylabel("x(t)");
    grid on;

    save_figure();

    fprintf("Saved auto signal %d\n", k);
end

fprintf("\nAUTO MODE completed successfully!\n\n");

%%===================== AUTO Signal Generator Function ==========================
function y = generate_signal_auto(choice, t)

    switch choice
        case 1   % DC
            A = (rand()*4) - 2;   % random amplitude between -2 and 2
            y = A * ones(size(t));

        case 2   % Ramp
            m = (rand()*4) - 2;   % random slope
            c = (rand()*4) - 2;   % random intercept
            y = m*t + c;

        case 3   % Polynomial
            % Random polynomial ax^2 + bx + c
            coeffs = [(rand()*2-1), (rand()*4-2), (rand()*4-2)];
            y = polyval(coeffs, t);

        case 4   % Exponential
            A = rand()*2;        % 0 to 2
            a = (rand()*4) - 2;  % -2 to 2
            y = A * exp(a*t);

        case 5   % Sinusoidal
            A = rand()*2;        % Amplitude 0–2
            f = rand()*5 + 0.5;  % Frequency 0.5–5.5 Hz
            y = A * sin(2*pi*f*t);

        case 6   % Gaussian Pulse
            A = rand()*2;            % amplitude 0–2
            mu = rand()*2 - 1;       % mean between -1 and 1
            s = rand()*0.9 + 0.1;    % sigma between 0.1 and 1
            y = A * exp(-((t-mu).^2)/(2*s^2));

        case 7   % Sawtooth
            A = rand()*2;
            f = rand()*5 + 0.5;
            y = A * (2*((t*f) - floor(0.5 + t*f)));
    end
end
