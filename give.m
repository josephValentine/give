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

% Last Modified by GUIDE v2.5 10-Apr-2017 18:00:15

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


% --- Executes on button press in runCustom.
function runCustom_Callback(hObject, eventdata, handles)
% hObject    handle to runCustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop = false;
load(get(handles.gradient_data,'String'));
runSimulation(handles, x, y, adc);



function filepath_Callback(hObject, eventdata, handles)
% hObject    handle to filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath as text
%        str2double(get(hObject,'String')) returns contents of filepath as a double



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


% --- Executes on slider movement.
function speedSlider_Callback(hObject, eventdata, handles)
% hObject    handle to speedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function speedSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in runSpiral.
function runSpiral_Callback(hObject, eventdata, handles)
% hObject    handle to runSpiral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = false;

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

runSimulation(handles, x, y, adc);


% --- Executes on button press in run2dpr.
function run2dpr_Callback(hObject, eventdata, handles)
% hObject    handle to run2dpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = false;

numTRs = 32;
gradLength = 64; % This affects how far out in k-space you go

y = zeros(numTRs,gradLength);
x = zeros(numTRs,gradLength);

for n = 1:numTRs
	y(n,:) = sin(2*pi*(n-1)/numTRs);
	x(n,:) = cos(2*pi*(n-1)/numTRs);
end


adc = ones(numTRs,gradLength);

runSimulation(handles, x, y, adc);


% --- Executes on button press in run2dft.
function run2dft_Callback(hObject, eventdata, handles)
% hObject    handle to run2dft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = false;

numTRs = 128;
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

runSimulation(handles, x, y, adc);


% --- Executes on button press in randomUndersample.
function randomUndersample_Callback(hObject, eventdata, handles)
% hObject    handle to randomUndersample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop = false;

indices = zeros(1,128);
indices(60:69) = 0; % Set this to 1 if we want to guarantee that the center of
                    % k-space is sampled
count = 0;
while count < 64 % Set this to 54 if the above is set to 1
    num = floor(normrnd(65, 20));
    if num > 0 && num <= 128 && indices(num) == 0
        indices(num) = 1;
        count = count + 1;
    end
end

indices = strfind(indices, 1);
y = zeros(length(indices), 128+64);
n = 1;
for index = indices
	y(n,1:64) = (index - 1 - 64) / 64;
	n = n + 1;
end

x = zeros(length(indices), 128+64);
x(:,1:64) = -1;
x(:,65:end) = 1;

adc = zeros(length(indices), 128+64);
adc(:,65:end) = 1;

runSimulation(handles, x, y, adc);
    



% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = true;
