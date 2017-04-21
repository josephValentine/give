#GIVE
##Gradient Intuition VisualizEr
###A Matlab tool to help new MR physicists understand the relationships between pulse sequences, K-space, and image space

GIVE offers the ability to use custom gradient waveforms and to see how they affect the k-space trajectory. The user can indicate the file path to a .mat file containing the gradient data. GIVE expects to find 3 variables: x, y, and adc. If these 3 variables do not exist an error will occur. x represents the x-gradient data, y represents the y-gradient data, and adc represents when the ADC is turned on (when k-space is actually being sampled). Each of the 3 variables must be a 2D matrix of the same size. The number of rows corresponds to the number of TRs the scan consists of, and the number of columns corresponds to the number of data points for each gradient/ADC during each TR. The integer Integral of the gradients represents 1 pixel in k-space. In other words If you have a y gradient of magnitude 10 that is on for 8 samples, you will end up 80 pixels above the origin in your k-space image. The data points for the adc variable should be 0 (for off) or 1 (for on). 

see sampleTrajectoryCode.m for an example


