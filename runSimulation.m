function runSimulation(handles, x, y, adc)
global stop;

speed=round(get(handles.speedSlider, 'Value'))

img = imread(get(handles.filepath,'String'));
img = imresize(img,[128 128]);
img = double(rgb2gray(img));
imshow(zeros(size(img)),[],'Parent',handles.image_plot);

IMG = fftshift(fft2(img));
IMG_SAMPLED = zeros(size(img));
imshow(zeros(size(img)),[],'Parent',handles.kspace_plot);

sizeX = size(img, 2);
sizeY = size(img, 1);
maxX = sizeX / 2;
maxY = sizeY / 2;

plotMaxY = max(max(y)) + 0.05;
plotMinY = min(min(y)) - 0.05;
plotMaxX = max(max(x)) + 0.05;
plotMinX = min(min(x)) - 0.05;

% The following removes the need to reset YLim and XLim each loop iteration, but
% I don't know how to reset the plot between each TR.
% handles.xgrad_plot.YLim = [-1.1, 1.1];
% handles.xgrad_plot.XLim = [0, 1000];
% hold(handles.xgrad_plot, 'all');
% 
% handles.ygrad_plot.YLim = [-1.1, 1.1];
% handles.ygrad_plot.XLim = [0, 1000];
% hold(handles.ygrad_plot, 'all');
% 
% handles.adc_plot.YLim = [-0.05, 1.05];
% handles.adc_plot.XLim = [0, 1000];
% hold(handles.adc_plot, 'all');

for m = 1:size(x,1) %assume that x y and adc all have same number of trs
    pause('on');
    kxtemp = 0;
    kytemp = 0;
    hold(handles.kspace_plot, 'all');
	for n = 1:size(x,2)
        if stop
            return
        end
%         handle the drawing of gradient waveforms
        if(mod(n,speed) == 0)
            plot(x(m,1:n),'Parent',handles.xgrad_plot);
            handles.xgrad_plot.YLim = [plotMinX, plotMaxX];
            handles.xgrad_plot.XLim = [0, size(x,2)];

            plot(y(m,1:n),'Parent',handles.ygrad_plot);
            handles.ygrad_plot.YLim = [plotMinY, plotMaxY];
            handles.ygrad_plot.XLim = [0, size(x,2)];

            plot(adc(m,1:n),'Parent',handles.adc_plot);
            handles.adc_plot.YLim = [-0.05, 1.05];
            handles.adc_plot.XLim = [0, size(x,2)];
        end
        
%         get corresponding kspace data and plot
        
        kxtemp = kxtemp + x(m,n);
        kytemp = kytemp - y(m,n);
        
%         shift center to zero
        kx = floor(kxtemp + maxX);
        ky = floor(kytemp + maxY);
        
        if kx > sizeX
            kx = size(img,2);
        end
        
        if ky > sizeY
            ky = size(img,1);
        end
        
         if kx < 1
            kx = 1;
        end
        
        if ky < 1
            ky = 1;
        end
        
%         if(mod(n,5) == 0)
%          plot(kx,ky,'r.','MarkerSize',20, 'Parent',handles.kspace_plot)
%         end
        if(adc(m,n) ~= 0)
            IMG_SAMPLED(ky,kx)=IMG(ky,kx);
            if(mod(n,speed) == 0)
                img_sampled = ifft2(fftshift(IMG_SAMPLED));
                imshow(abs(img_sampled),[],'Parent',handles.image_plot);
                imshow(log(abs(IMG_SAMPLED)),[],'Parent',handles.kspace_plot);
            end
        end

        pause(0.00000001);
	end
    img_sampled = ifft2(fftshift(IMG_SAMPLED));
    imshow(abs(img_sampled),[],'Parent',handles.image_plot);
    imshow(log(abs(IMG_SAMPLED)),[],'Parent',handles.kspace_plot);
    plot(x(m,1:n),'Parent',handles.xgrad_plot);
    handles.xgrad_plot.YLim = [plotMinX, plotMaxX];
    handles.xgrad_plot.XLim = [0, size(x,2)];

    plot(y(m,1:n),'Parent',handles.ygrad_plot);
    handles.ygrad_plot.YLim = [plotMinY, plotMaxY];
    handles.ygrad_plot.XLim = [0, size(x,2)];

    plot(adc(m,1:n),'Parent',handles.adc_plot);
    handles.adc_plot.YLim = [-0.05, 1.05];
    handles.adc_plot.XLim = [0, size(x,2)];
end

%             imshow(abs(img_sampled),[],'Parent',handles.image_plot);
%             imshow(log(abs(IMG_SAMPLED)),[],'Parent',handles.kspace_plot);
% time(1:10) = 1;
% plot(x .* time,'Parent',handles.xgrad_plot);
% handles.xgrad_plot.YLim = [-1.1, 1.1];
% pause(5);
% time(1:1000) = 1;
% plot(x .* time,'Parent',handles.xgrad_plot);
% handles.xgrad_plot.YLim = [-1.1, 1.1];

end