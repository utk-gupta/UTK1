clc;
clear all;
close all;

%% Defining the Sine wave parameters
f1 = 10;                %Hertz
f2 = 30;                %Hertz

w1 =    2 * pi * f1;    %Rad/sec
w2 =    2 * pi * f2;    %Rad/sec

t = 0:1/1000:0.999;
Fs = 1000;              %Sampling Frequency

%% Plotting the two waves

Signal1 = sin(w1*t);
Signal2 = sin(w2*t);
Noise = randn(size(t,2),1);
Superimpose = Signal1 + Signal2;

figure(1)
plot(t, Signal1, 'r', 'LineWidth', 1);
figure(2)
plot(t, Signal2, 'g', 'LineWidth', 1);
figure(3)
plot(t, Superimpose, 'b', 'LineWidth', 1);
figure(4)
plot(t, Noise, 'y', 'LineWidth', 1);


xlabel('Time in Seconds');
ylabel('Amplitude');
legend('10Hz', '30Hz', 'Superimposed','Noise');

%% Frequency Domain Conditions

Superimpose_f = Signal1 + Signal2;

%% Freq Domain Variables
Superimpose_dft = fft(Superimpose_f);
Signal1_dft = fft(Signal1);
Signal2_dft = fft(Signal2);
Noise_dft = fft(Noise);

figure(8)
Superimpose_dft = Superimpose_dft(1:length(Superimpose_f));
freq1 = 0:Fs/length(Superimpose_f):(Fs-1);
plot(freq1,abs(Superimpose_dft));
figure(5)
Signal1_dft = Signal1_dft(1:length(Signal1));
freq2 = 0:Fs/length(Signal1):(Fs-1);
plot(freq2,abs(Signal1_dft));
figure(6)
Signal2_dft = Signal2_dft(1:length(Signal2));
freq3 = 0:Fs/length(Signal2):(Fs-1);
plot(freq3,abs(Signal2_dft));
figure(7)
Noise_dft = Noise_dft(1:length(Noise));
freq4 = 0:Fs/length(Noise):(Fs-1);
plot(freq4,abs(Noise_dft));


xlabel('Frequency');
ylabel('Amplitude');

inverse = ifft(Signal1_dft);

