% img = imread('/Users/Josephvalentine/Documents/code/give/knee_mri.jpg');
% img = double(rgb2gray(img));
% imshow(img,[]);

%tr=1000; %arbitrary time units
y=zeros(128,128+64);
for m=1:128
    y(m,1:64)=(m-65)/64;
end


x=zeros(128,128+64);
x(:,1:64)=-1;
x(:,65:128+64)=1;

adc=zeros(128,128+64);
adc(:,65:128+64)=1;

save('gradient_data')