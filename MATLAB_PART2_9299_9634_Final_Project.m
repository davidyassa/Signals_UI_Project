%% User Input
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

bp;
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




%% Main Menu

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



%% Operation Menu

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





%% Generate Signals

%Test case, highlight and press Ctrl+Shift+R
% t = -5:1e-3:5;
% x = t.^2;
% figure
% plot(t,x, 'LineWidth', 1);
% save_figure();









% Functions


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

