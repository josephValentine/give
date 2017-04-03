% This creates gradient waveforms for a spiral trajectory.

numTRs = 16;
gradLength = 200;

y = zeros(numTRs,gradLength);
x = zeros(numTRs,gradLength);


t = 1/gradLength:1/gradLength:1;
f = 5; % This affects how many times you circle around the origin
n = t*5; % This affects how far out in k-space you go

for k = 1:numTRs
	y(k,:) = n .* sin(2*pi*f*t + (k - 1) * pi / (numTRs/2));
	x(k,:) = n .* cos(2*pi*f*t + (k - 1) * pi / (numTRs/2));
end


adc = ones(numTRs,gradLength);

save('gradient_data')