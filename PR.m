% This creates gradient waveforms for a 2DPR sequence.

numTRs = 16;
gradLength = 64; % This affects how far out in k-space you go

y = zeros(numTRs,gradLength);
x = zeros(numTRs,gradLength);

for n = 1:numTRs
	y(n,:) = sin(2*pi*(n-1)/numTRs);
	x(n,:) = cos(2*pi*(n-1)/numTRs);
end


adc = ones(numTRs,gradLength);

save('gradient_data')