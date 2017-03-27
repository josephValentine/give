img = imread('/Users/Josephvalentine/Documents/code/give/knee_mri.jpg');
img = double(rgb2gray(img));
imshow(img,[]);

%tr=1000; %arbitrary time units
y=zeros(10,1000);
y(1,1:100)=-1;
y(2,1:100)=-0.8;
y(3,1:100)=-0.6;
y(4,1:100)=-0.4;
y(5,1:100)=-0.2;
y(6,1:100)=-0;
y(7,1:100)=.2;
y(8,1:100)=.4;
y(9,1:100)=.6;
y(10,1:100)=.8;
y = y/10;


x=zeros(10,1000);
x(:,1:100)=-1;
x(:,101:300)=1;

adc=zeros(10,1000);
adc(:,101:300)=1;

save('gradient_data')