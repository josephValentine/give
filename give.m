function varargout = give(varargin)
% GIVE MATLAB code for give.fig
%      GIVE, by itself, creates a new GIVE or raises the existing
%      singleton*.
%
%      H = GIVE returns the handle to a new GIVE or the handle to
%      the existing singleton*.
%
%      GIVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GIVE.M with the given input arguments.
%
%      GIVE('Property','Value',...) creates a new GIVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before give_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to give_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help give

% Last Modified by GUIDE v2.5 27-Mar-2017 14:21:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @give_OpeningFcn, ...
                   'gui_OutputFcn',  @give_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before give is made visible.
function give_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to give (see VARARGIN)

clear handles.image_plot
clear handles.kspace_plot
% Choose default command line output for give
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes give wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = give_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = imread(get(handles.filepath,'String'));
img = double(rgb2gray(img));
imshow(zeros(size(img)),[],'Parent',handles.image_plot);

IMG = fftshift(fft2(img));
IMG_SAMPLED = zeros(size(img));
imshow(zeros(size(img)),[],'Parent',handles.kspace_plot);

load(get(handles.gradient_data,'String'));

sizeX = size(img, 2);
sizeY = size(img, 1);
maxX = sizeX / 2;
maxY = sizeY / 2;

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
	for n = 1:1000
        
%         handle the drawing of gradient waveforms
        plot(x(m,1:n),'Parent',handles.xgrad_plot);
        handles.xgrad_plot.YLim = [-1.1, 1.1];
        handles.xgrad_plot.XLim = [0, 1000];
        
        plot(y(m,1:n),'Parent',handles.ygrad_plot);
        handles.ygrad_plot.YLim = [-1.1, 1.1];
        handles.ygrad_plot.XLim = [0, 1000];
    
        plot(adc(m,1:n),'Parent',handles.adc_plot);
        handles.adc_plot.YLim = [-0.05, 1.05];
        handles.adc_plot.XLim = [0, 1000];
        
%         get corresponding kspace data and plot
        
        kx = sum(x(m,1:n)) * maxX / 100;
        ky = -sum(y(m,1:n)) * maxY / 100;
        
%         shift center to zero
        kx = int32(kx + maxX);
        ky = int32(ky + maxY);
        
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
        
        if(adc(m,n) ~= 0)
%             ky
%             kx
            IMG_SAMPLED(ky,kx)=IMG(ky,kx);
            img_sampled = ifft2(fftshift(IMG_SAMPLED));
            if(mod(n,10) == 0)
                imshow(abs(img_sampled),[],'Parent',handles.image_plot);
                imshow(log(abs(IMG_SAMPLED)),[],'Parent',handles.kspace_plot);
            end
        end

        pause(0.001);
	end
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




function deltax_Callback(hObject, eventdata, handles)
% hObject    handle to deltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltax as text
%        str2double(get(hObject,'String')) returns contents of deltax as a double


% --- Executes during object creation, after setting all properties.
function deltax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deltay_Callback(hObject, eventdata, handles)
% hObject    handle to deltay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltay as text
%        str2double(get(hObject,'String')) returns contents of deltay as a double


% --- Executes during object creation, after setting all properties.
function deltay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deltar_Callback(hObject, eventdata, handles)
% hObject    handle to deltar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltar as text
%        str2double(get(hObject,'String')) returns contents of deltar as a double


% --- Executes during object creation, after setting all properties.
function deltar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function adc_data_Callback(hObject, eventdata, handles)
% hObject    handle to adc_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of adc_data as text
%        str2double(get(hObject,'String')) returns contents of adc_data as a double


% --- Executes during object creation, after setting all properties.
function adc_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adc_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ygrad_data_Callback(hObject, eventdata, handles)
% hObject    handle to ygrad_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ygrad_data as text
%        str2double(get(hObject,'String')) returns contents of ygrad_data as a double


% --- Executes during object creation, after setting all properties.
function ygrad_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ygrad_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xgrad_data_Callback(hObject, eventdata, handles)
% hObject    handle to xgrad_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xgrad_data as text
%        str2double(get(hObject,'String')) returns contents of xgrad_data as a double


% --- Executes during object creation, after setting all properties.
function xgrad_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xgrad_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filepath_Callback(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath as text
%        str2double(get(hObject,'String')) returns contents of filepath as a double
% handles.path = get(hObject, 'String');
% guidata(gcbo,handles);
% disp('hello everyone, in filepath callback')



% --- Executes during object creation, after setting all properties.
function filepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gradient_data_Callback(hObject, eventdata, handles)
% hObject    handle to gradient_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gradient_data as text
%        str2double(get(hObject,'String')) returns contents of gradient_data as a double


% --- Executes during object creation, after setting all properties.
function gradient_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gradient_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
