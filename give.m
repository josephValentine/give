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
imshow(img,[],'Parent',handles.image_plot);

IMG = fftshift(fft2(img));
imshow(log(abs(IMG)),[],'Parent',handles.kspace_plot);

load(get(handles.gradient_data,'String'));
plot(y,'Parent',handles.ygrad_plot);
handles.ygrad_plot.YLim = [-1.1, 1.1];
plot(adc,'Parent',handles.adc_plot);
handles.adc_plot.YLim = [-0.05, 1.05];
pause('on');
time = zeros(1,1000);
for n = 1:1000
    time(1:n) = 1;
    plot(x .* time,'Parent',handles.xgrad_plot);
    handles.xgrad_plot.YLim = [-1.1, 1.1];
    pause(0.01);
end
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