function varargout = BOPSgui(varargin)
% BOPSGUI MATLAB code for BOPSgui.fig
%      BOPSGUI, by itself, creates a new BOPSGUI or raises the existing
%      singleton*.
%
%      H = BOPSGUI returns the handle to a new BOPSGUI or the handle to
%      the existing singleton*.
%
%      BOPSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOPSGUI.M with the given input arguments.
%
%      BOPSGUI('Property','Value',...) creates a new BOPSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BOPSgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BOPSgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BOPSgui

% Last Modified by GUIDE v2.5 24-Aug-2015 15:51:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BOPSgui_OpeningFcn, ...
                   'gui_OutputFcn',  @BOPSgui_OutputFcn, ...
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


% --- Executes just before BOPSgui is made visible.
function BOPSgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BOPSgui (see VARARGIN)

% Choose setDefault command line output for BOPSgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BOPSgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BOPSgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get setDefault command line output from handles structure
varargout{1} = handles.output;



function loadedInputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to loadedInputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loadedInputFolder as text
%        str2double(get(hObject,'String')) returns contents of loadedInputFolder as a double


% --- Executes during object creation, after setting all properties.
function loadedInputFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadedInputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lodedModel_Callback(hObject, eventdata, handles)
% hObject    handle to lodedModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lodedModel as text
%        str2double(get(hObject,'String')) returns contents of lodedModel as a double


% --- Executes during object creation, after setting all properties.
function lodedModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lodedModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectProcessingConfiguration.
function selectProcessingConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to selectProcessingConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[inputDir, model_file]=processingConfiguration();
handles.inputDir=inputDir;
handles.model_file=model_file;
set(handles.loadedInputFolder, 'String', inputDir);
set(handles.lodedModel, 'String', model_file);

% --- Executes on button press in CloseButton.
function CloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(BOPSgui)

% --- Executes on button press in RunButton.
function RunButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in setDefault.
function setDefault_Callback(hObject, eventdata, handles)
% hObject    handle to setDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over runIK.
function runIK_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to runIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in runMA.
function runMA_Callback(hObject, eventdata, handles)
% hObject    handle to runMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runMA


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over runMA.
function runMA_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to runMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on runMA and none of its controls.
function runMA_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to runMA (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on runIK and none of its controls.
function runIK_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to runIK (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over PlotResultsIK.
function PlotResultsIK_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PlotResultsIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on PlotResultsIK and none of its controls.
function PlotResultsIK_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PlotResultsIK (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
