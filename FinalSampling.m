fs = 24000; % Choosing the maximum sampeling frequency by the AD
%Creating the signal
f_signal = 5000;        % Using a signal in the allowed range
A_signal = 1;           % We want the amplitude to be 1
f_interference = 12000; % Choosing a interference frecuency
A_interference = 1;     % And the same amplitude
% Here the time prameters are chosen
t_end = 0.1;                        % This is the total time for the simulation 
oversampling_factor = 100;          % Use a larger oversampling in order for the simulation to be smooth
t_res = 1/(oversampling_factor*fs); % This is for setting the resolution for the simulation
t = 0:t_res:t_end;                  % Using the tips ofor a good time vector
% Generating the interference signal
desired_signal = A_signal * sin(2*pi*f_signal*t);  % The signal wanted for the task
interference_signal = A_interference * sin(2*pi*f_interference*t); % Interference signal
%Mesurement siggnal
signal = desired_signal + interference_signal;
%Defining the filter to fit the specification
Rp = 3;          % passband ripple in dB
Rs = 66;         % stopband attenuation in dB
Fp = 8000;       % passband edge frequency (Hz)
Fs_stop = 11000; % stopband edge frequency (Hz)
Wp = 2*pi*Fp;    % passband edge frequency in rad/s
Ws = 2*pi*Fs_stop; % stopband edge frequency in rad/s
% Butterworth filter
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's'); % calculating the order for the filter
[b, a] = butter(n, Wn, 's');            % finding the coefficeints
anti_aliasing_filter = tf(b, a);        % make the transfer function
%Simulate with lsim
[filtered_signal, ~] = lsim(anti_aliasing_filter, signal, t);
% Sampeling, tip: pick out every 'oversampling_factor'-th sample
sampled_indices = 1:oversampling_factor:length(t); % store sampling times
t_sampled = t(sampled_indices);                    % sampling times
sampled_signal = filtered_signal(sampled_indices); % sampled signal
% Use fft for analysis
N = length(sampled_signal);       % number of samles
X = fft(sampled_signal);          % use fft function
X_magnitude = abs(X)/N;           % normalise using the tip
fvector = (0:N-1)/N * fs;         % frecuency vector
% Plot one big figure
figure;

subplot(3,1,1);
plot(t, signal, 'b', t, filtered_signal, 'r');
title('Original vs Filtered signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');
legend('Original Signal', 'Filtered Signal');
grid on;

subplot(3,1,2);
stem(t_sampled, sampled_signal, 'filled');
title('Sampled Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(3,1,3);
plot(fvector(1:floor(N/2))/1000, X_magnitude(1:floor(N/2))); % Plot up to fs/2 and convert Hz to kHz, floor is used for uneven index length.
title('FFT of the Sampled Signal');
xlabel('Frequency (kHz)');
ylabel('Normalized Amplitude');
xlim([0 fs/2000]); % tip to limit the x-axis to 0 to fs/2 in kHz
grid on;
