% This creates gradient waveforms for a non-uniform spiral trajectory.

numTRs = 8; % Number of TRs in scan
gradLength = 200; % Number of data points in waveforms

x = zeros(numTRs,gradLength); % Initialize x and y
y = zeros(numTRs,gradLength);

t = 1/gradLength:1/gradLength:1; % Create vector of time points
f = 5; % Set the frequency of the sinusoidal waveforms
       % This affects how many times you circle around the origin
A = t*5; % Set the amplitude of the sinusoidal waveforms as a function of t
         % This affects how far out in k-space you go

% Change the initial phase of the sinusoidal waveforms each TR
% This creates different interleaves
for k = 1:numTRs
	y(k,:) = A .* sin(2*pi*f*t + (k - 1) * pi / (numTRs/2));
	x(k,:) = A .* sin(2*pi*f*t + (k - 1) * pi / (numTRs/2) + pi/4);
end

adc = ones(numTRs,gradLength); % Set the ADC to always be on

save('custom', 'x', 'y', 'adc') % Save x, y, and adc to a .mat file