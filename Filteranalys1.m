% Parametrar
G = 10;          % Förstarkningsfaktor
R = 10400;       % Resistans
C = 1e-6;        % Kapacitans
K = 0.32;        % K-förhållande som ar lika med R2/R3

% Namnare
namnare = [R^2 * C^2, K * G * R * C, G^2];

% Överföringsfunktion H1(s)
% H1(s) = (-G^2) / (R^2 C^2 s^2 + K G R C s + G^2)
taljare_H1 = -G^2;
H1 = tf(taljare_H1, namnare);

% Överföringsfunktion H2(s)
% H2(s) = (-G * R * C * s) / (R^2 C^2 s^2 + K G R C s + G^2)
taljare_H2 = [-G * R * C, 0];  % Representerar -GRC * s
H2 = tf(taljare_H2, namnare);

% Överföringsfunktion H3(s)
% H3(s) = (-R^2 * C^2 * s^2) / (R^2 C^2 s^2 + K G R C s + G^2)
taljare_H3 = [-R^2 * C^2, 0, 0];  % Representerar -R^2 C^2 * s^2
H3 = tf(taljare_H3, namnare);

% Plottar alla tre pol-nollstalle-diagram:
figure;
subplot(3,1,1);
iopzplot(H1);
title('Pol-Nollstalle-Diagram för H1(s)');
grid on;

subplot(3,1,2);
iopzplot(H2);
title('Pol-Nollstalle-Diagram för H2(s)');
grid on;

subplot(3,1,3);
iopzplot(H3);
title('Pol-Nollstalle-Diagram för H3(s)');
grid on;

% Plottar alla impulssvar
figure;
subplot(3,1,1);
impulse(H1);
title('Impulssvar för H1(s)');
grid on;

subplot(3,1,2);
impulse(H2);
title('Impulssvar för H2(s)');
grid on;

subplot(3,1,3);
impulse(H3);
title('Impulssvar för H3(s)');
grid on;

% Plottar Bode-diagram
figure;
subplot(3,1,1);
bode(H1);
title('Bode-Diagram för H1(s)');
grid on;

subplot(3,1,2);
bode(H2);
title('Bode-Diagram för H2(s)');
grid on;

subplot(3,1,3);
bode(H3);
title('Bode-Diagram för H3(s)');
grid on;

% Simulerar filtersvar med kand fyrkantsvåg
t = 0:1e-5:0.1;  % Tidsvektor
f0 = 50;         % Grundfrekvens
x = square(2 * pi * f0 * t); % Fyrkantsvåg

% Utsignal från lågpassfiltret
y = lsim(H1, x, t);

% In- och utsignal
figure;
plot(t, x, 'b', 'DisplayName', 'Ingångssignal');
hold on;
plot(t, y, 'r', 'DisplayName', 'Utsignal');
xlabel('Tid (s)');
ylabel('Amplitud');
title('In- och utsignal för lågpassfiltret H1');
legend;
grid on;

