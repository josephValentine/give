% This creates gradient waveforms for a 2DFT sequence.

numTRs = 16;
gradLength = 128 + 64;

y = zeros(numTRs, gradLength);
for n = 1:numTRs
	y(n,1:64) = (n - 1 - numTRs/2) / (numTRs/2);
end

x = zeros(numTRs, gradLength);
x(:,1:64) = -1;
x(:,65:end) = 1;

adc = zeros(numTRs, gradLength);
adc(:,65:end) = 1;

save('gradient_data')