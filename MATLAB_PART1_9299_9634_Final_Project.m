%% Question 1

% Parameters
dt = 1e-3;
t = -10:dt:10;             % time domain
fs = 1/dt;

% (a) time-domain signal
% f(t) = e^{-2t} u(t) t<2; cos(4πt) e^{-0.5t} t>=2;
f = exp(-2*t) .* double(t >= 0 & t < 2) + cos(4*pi*t) .* exp(-0.5*t) .* double(t>=2);

Nf = 2^18;                        
F = fft(f, Nf) * dt;    % continuous-FT approximation
F = fftshift(F);        % center graph

% Frequency domain
df = fs / Nf;
f_axis = (-Nf/2 : Nf/2 - 1) * df;   % Hz
w = 2*pi * f_axis;                  % rad/s

figure("Name", "Q1", "NumberTitle","off");
subplot(3,1,1);
plot(t,f, 'LineWidth', 1);
title("x(t)");
xlabel("t"); ylabel("x");
xlim([-10 10]);
ylim([-0.3 1.1]);

subplot(3,1,2);
plot(w,abs(F), 'LineWidth', 1);
title("|X(\omega)|");
xlabel("\omega (rad/s)"); ylabel("X");
xlim([-20 20]);

subplot(3,1,3);
plot(w, unwrap(angle(F)));
title('Phase of X(\omega)');
xlabel('\omega (rad/s)'); ylabel("\phi")
xlim([-20 20]);
%% Question 2

% Parameters
dt = 1e-3;
t = -10:dt:10;             % time domain
fs = 1/dt;

% (a) time-domain signal
% x1(t) = sin2t * cos(3πt)
% x2(t) = rect(t/4) * cos(3πt)

x1 = sinc(2*t) .* cos(3*pi* t);

rect = double(t >= -2) .* double(t <= 2); % -2 -> 2
x2 = rect .* cos(3*pi* t);


Nf = 2^18;                        
X1 = fft(x1, Nf) * dt; X2 = fft(x2, Nf) * dt;    % continuous-FT approximation
X1 = fftshift(X1); X2 = fftshift(X2);        % center graph

% Frequency domain
df = fs / Nf;
f_axis = (-Nf/2 : Nf/2 - 1) * df;   % Hz
w = 2*pi * f_axis;                  % rad/s

figure("Name", "Q2 x1", "NumberTitle","off");
subplot(3,1,1);
plot(t,x1, 'LineWidth', 1);
title("x1(t)");
xlabel("t"); ylabel("x1");

subplot(3,1,2);
plot(w,abs(X1), 'LineWidth', 1);
title("|X1(\omega)|");
xlabel("\omega (rad/s)"); ylabel("X1");
xlim([-20 20]);

subplot(3,1,3);
plot(w, unwrap(angle(X1)), 'LineWidth', 1);
title('Phase of X1(\omega)');
xlabel('\omega (rad/s)'); ylabel("\phi")
xlim([-20 20]);

figure("Name", "Q2 x2", "NumberTitle","off");

subplot(3,1,1)
plot(t,x2, "LineWidth",1);
title("x2(t)");
xlabel("t"); ylabel("x2");
xlim([-2.5 2.5]);

subplot(3,1,2);
plot(w,abs(X2), 'LineWidth', 1);
title("|X2(\omega)|");
xlabel("\omega (rad/s)"); ylabel("X2");
xlim([-20 20]);

subplot(3,1,3);
plot(w, unwrap(angle(X2)), 'LineWidth', 1);
title('Phase of X2(\omega)');
xlabel('\omega (rad/s)'); ylabel("\phi")
xlim([-20 20]);

%% Question 3 

n = -15:15;
Dn = ((-1).^(n+1))./(1j*n*pi) - ((-1).^n - 1)./(n * pi).^2;
Dn(n==0) = 3/2;

figure("Name", "Q3 Magnitude and Phase", "NumberTitle","off");
subplot(2,1,1); 
stem(n, abs(Dn), 'filled'); 
title('|D_n|');
xlabel('n'); ylabel('|D_n|');

subplot(2,1,2);
stem(n, unwrap(angle(Dn)), 'filled'); 
title('Phase of D_n');
xlabel('n'); ylabel('\phi');

dt = 1e-3;
t = -4:dt:4;
% x(t) = (t+2) -2<t<0; 2 0<t<2;
x = (t+2).*double(-2<=t & t<0) + 2*double(0<=t & t<2);
x_recon = zeros(size(t));

for k=-15:15
    if k==0
        Dk=3/2;
    else
        Dk = ((-1)^(k+1))/(1j*k*pi) - ((-1)^k - 1)/(k^2*pi^2);
    end
    x_recon = x_recon + Dk*exp(1j*k*pi/2*t);
end
figure("Name", "Q3 Reconstructed vs Original", "NumberTitle","off");
hold on; grid on;
plot(t, real(x_recon)); plot(t, x); 
title('Reconstructed vs Original'); legend('Reconstructed','Original');