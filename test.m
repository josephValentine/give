% img = imread('j:/Documents/knee_mri.jpg');
% img = double(rgb2gray(img));
% imshow(img,[]);

%tr=1000; %arbitrary time units
y=zeros(1,1000);
y(1:100)=-1;

x=zeros(1,1000);
x(1:100)=-1;
x(101:300)=1;

adc=zeros(1,1000);
adc(101:300)=1;

save('gradient_data')