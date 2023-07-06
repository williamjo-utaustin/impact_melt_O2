load("melt_complete.mat")
x = linspace(0,4500,4500)';
y = tot_melt_per_mya;

% Plot the data in the semilogy scale
figure;
semilogy(x,y);

% Compute the FFT of the signal
N = length(y);
Y = fft(y);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = 1/N*(0:N/2);

figure;
loglog(f,P1);
xlabel('Frequency (Hz)');
ylabel('Amplitude');


% Apply a low-pass filter to the FFT
cutoff_freq = 0.1; % Hz
filter = ones(size(f));
filter(f > cutoff_freq) = 0;
filtered_Y = Y .* filter;
filtered_y = ifft(filtered_Y);

figure(20);
% Plot the original and filtered data in a logarithmic scale
semilogy(x, abs(filtered_y));
hold on