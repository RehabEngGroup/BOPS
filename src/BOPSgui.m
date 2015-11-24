%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 BOPS                                    %
%                    BATCH OPENSIM PROCESSING SCRIPTS                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOPS GUI main file.

% This file is part of Batch OpenSim Processing Scripts (BOPS).
% Copyright (C) 2015 Alice Mantoan, Monica Reggiani
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

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

% Last Modified by GUIDE v2.5 27-Aug-2015 19:08:19

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

% Init handles
set(handles.runIK,'Value',0);
set(handles.PlotResultsIK,'Value',0);
set(handles.PlotResultsIK, 'Enable', 'off')

set(handles.runMA,'Value',0);
set(handles.plotStorageMA,'Value',0);
set(handles.plotStorageMA, 'Enable', 'off')
set(handles.selectTrialsMA,'Value',0);
set(handles.selectXaxisMA,'Value',0);

set(handles.runID,'Value',0);
set(handles.plotResultsID,'Value',0);
set(handles.plotResultsID, 'Enable', 'off')
set(handles.selectTrialsID,'Value',0);
set(handles.selectCoordinatesToPlotID,'Value',0);

set(handles.runSO,'Value',0);
set(handles.plotStorageSO,'Value',0);
set(handles.plotStorageSO, 'Enable', 'off')
set(handles.selectTrialsSO,'Value',0);
set(handles.selectXaxisSO,'Value',0);


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
% check that input dir is in a dynamicElaborations folder, otherwise we
% will not be able to set output paths correctly
ind=strfind(inputDir, [filesep 'dynamicElaborations']);

if isempty(ind)
    h=errordlg(['Input dir ' inputDir ' does not contain a ' filesep 'dynamicElaborations subfolder']);
    uiwait(h);
    return
end
set(handles.loadedInputFolder, 'String', inputDir);
set(handles.lodedModel, 'String', model_file);
guidata(hObject,handles)


% --- Executes on button press in CloseButton.
function CloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)


% --- Executes on button press in RunButton.
function RunButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inputDir = get(handles.loadedInputFolder, 'String');
model_file = get(handles.lodedModel, 'String');
%% IK
if get(handles.runIK , 'Value')== 1
    [IKoutputDir, IKtrialsOutputDir, IKprocessedTrials]=InverseKinematics(inputDir, model_file); 


    % Plotting IK Results
    if get(handles.PlotResultsIK, 'Value') == 1
        IKmotFilename='ik.mot'; %our default name
        set(handles.figure1, 'HandleVisibility', 'off');
        [coordinates,Xaxislabel]=plotResults('IK', IKoutputDir, IKtrialsOutputDir, model_file, IKprocessedTrials, IKmotFilename);
        set(handles.figure1, 'HandleVisibility', 'on');
    end

end

%% MA

if get(handles.runMA, 'Value') == 1
    %when run IK before & want to process the same trials
    if get(handles.runIK, 'Value')==1 && get(handles.selectTrialsMA, 'Value')==0
        [MAoutputDir,MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir, IKprocessedTrials);
    end
    
    %when run IK before, but MA on different trials
    if  get(handles.runIK, 'Value')==1 && get(handles.selectTrialsMA, 'Value')==1
        [MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir);
    end
    
    %if no IK before:
    if  get(handles.runIK, 'Value')==0
        [MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file);
    end


    % Plot Storage (MA)
    if get(handles.plotStorageMA, 'Value')==1
        set(handles.figure1, 'HandleVisibility', 'off');
        if exist('Xaxislabel','var') && get(handles.selectXaxisMA, 'Value')==0
            plotStorage(Xaxislabel)
        else
            plotStorage()

        end
        set(handles.figure1, 'HandleVisibility', 'on');
    end

end

%% ID

if get(handles.runID, 'Value') ==1
    
    %when run IK before & want to process the same trials
    if get(handles.runIK, 'Value')==1 && get(handles.selectTrialsID, 'Value')==0
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir, IKprocessedTrials);
    end
    
    %when run IK before, but ID on different trials
    if get(handles.runIK, 'Value')==1 && get(handles.selectTrialsID, 'Value')==1
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir);
    end
    
    %if no IK before:
    if get(handles.runIK, 'Value')==0
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file);
    end

    % Plotting ID Results
    if get(handles.plotResultsID, 'Value')==1
        IDfilename='inverse_dynamics.sto';
        set(handles.figure1, 'HandleVisibility', 'off');

        if get(handles.runIK, 'Value')==1
            if exist('coordinates','var') && handles.selectCoordinatesToPlotID==0 && exist('Xaxislabel','var') %same X-axis label
                plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates, Xaxislabel);
            else if exist('coordinates','var') && handles.selectCoordinatesToPlotID==0       %same coordinates, different X axis
                    plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates); %add "_moment" to coordinates
                else if handles.selectCoordinatesToPlotID==1
                        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename);
                    end
                end
            end
        else  %if no IK before
            plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename);
        end
        set(handles.figure1, 'HandleVisibility', 'on');
    end
end

%% SO

if handles.runSO==1
    
    %when run IK and ID before & want to process the same trials (of ID)
    if handles.runIK==1 && handles.runID==1 && handles.selectTrialsSO==0
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir, IDprocessedTrials);
    end
    
    %when run IK and ID before, but SO on different trials
    if handles.runIK==1 && handles.runID==1 && handles.selectTrialsSO==1
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir);
    end
       
    %if no IK and ID before:
    if  handles.runIK==0 && handles.runID==0
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file);
    end

    % Plot Storage (SO)
    if handles.plotStorageSO==1
        set(handles.figure1, 'HandleVisibility', 'off');

        if exist('Xaxislabel','var') && handles.selectXaxisSO==0
            plotStorage(Xaxislabel)
        else
            plotStorage()
        end
        set(handles.figure1, 'HandleVisibility', 'on');
    end
end

save_to_base(1)

% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.runIK,'Value',0);
set(handles.PlotResultsIK,'Value',0);
set(handles.PlotResultsIK, 'Enable', 'off')

set(handles.runMA,'Value',0);
set(handles.plotStorageMA,'Value',0);
set(handles.plotStorageMA, 'Enable', 'off')
set(handles.selectTrialsMA,'Value',0);
set(handles.selectXaxisMA,'Value',0);

set(handles.runID,'Value',0);
set(handles.plotResultsID,'Value',0);
set(handles.plotResultsID, 'Enable', 'off')
set(handles.selectTrialsID,'Value',0);
set(handles.selectCoordinatesToPlotID,'Value',0);

set(handles.runSO,'Value',0);
set(handles.plotStorageSO,'Value',0);
set(handles.plotStorageSO, 'Enable', 'off')
set(handles.selectTrialsSO,'Value',0);
set(handles.selectXaxisSO,'Value',0);

guidata(hObject,handles)

% --- Executes on button press in setDefault.
function setDefault_Callback(hObject, eventdata, handles)
% hObject    handle to setDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.runIK,'Value',1);
set(handles.PlotResultsIK, 'Enable', 'on')
set(handles.PlotResultsIK,'Value',1);

set(handles.runMA,'Value',1);
set(handles.plotStorageMA, 'Enable', 'on')
set(handles.plotStorageMA,'Value',1);

set(handles.runID,'Value',1);
set(handles.plotResultsID, 'Enable', 'on')
set(handles.plotResultsID,'Value',1);
set(handles.selectTrialsID,'Value',1);

set(handles.runSO,'Value',1);
set(handles.plotStorageSO, 'Enable', 'on')
set(handles.plotStorageSO,'Value',1);

guidata(hObject,handles)

% --- Executes on button press in runIK.
function runIK_Callback(hObject, eventdata, handles)
% hObject    handle to runIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runIK

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.PlotResultsIK, 'Enable', 'on')
else
    set(handles.PlotResultsIK, 'Enable', 'off')
end

guidata(hObject,handles)

% --- Executes on button press in PlotResultsIK.
function PlotResultsIK_Callback(hObject, eventdata, handles)
% hObject    handle to PlotResultsIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotResultsIK

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.PlotResultsIK, 'Value', 1)
else
    set(handles.PlotResultsIK, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in runMA.
function runMA_Callback(hObject, eventdata, handles)
% hObject    handle to runMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runMA
    
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotStorageMA, 'Enable', 'on')
else
    set(handles.plotStorageMA, 'Enable', 'off')
end

guidata(hObject,handles)

% --- Executes on button press in plotStorageMA.
function plotStorageMA_Callback(hObject, eventdata, handles)
% hObject    handle to plotStorageMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStorageMA

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotStorageMA, 'Value', 1)
else
    set(handles.plotStorageMA, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in runID.
function runID_Callback(hObject, eventdata, handles)
% hObject    handle to runID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runID

if (get(hObject,'Value') == get(hObject,'Max'))

    set(handles.plotResultsID, 'Enable', 'on')
else
    set(handles.plotResultsID, 'Enable', 'off')
end

guidata(hObject,handles)

% --- Executes on button press in plotResultsID.
function plotResultsID_Callback(hObject, eventdata, handles)
% hObject    handle to plotResultsID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotResultsID
if (get(hObject,'Value') == get(hObject,'Max'))

    set(handles.plotResultsID, 'Value', 1)
else
    set(handles.plotResultsID,'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in runSO.
function runSO_Callback(hObject, eventdata, handles)
% hObject    handle to runSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runSO

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotStorageSO, 'Enable', 'on')
else
    set(handles.plotStorageSO, 'Enable', 'off')
end

guidata(hObject,handles)

% --- Executes on button press in plotStorageSO.
function plotStorageSO_Callback(hObject, eventdata, handles)
% hObject    handle to plotStorageSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStorageSO

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotStorageSO, 'Value', 1)
else
    set(handles.plotStorageSO, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectTrialsMA.
function selectTrialsMA_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsMA

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectTrialsMA, 'Value', 1)
else
    set(handles.selectTrialsMA, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectXaxisMA.
function selectXaxisMA_Callback(hObject, eventdata, handles)
% hObject    handle to selectXaxisMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectXaxisMA

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectXaxisMA, 'Value', 1)
else
	set(handles.selectXaxisMA, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectTrialsID.
function selectTrialsID_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsID

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectTrialsID, 'Value', 1)
else
	set(handles.selectTrialsID, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectCoordinatesToPlotID.
function selectCoordinatesToPlotID_Callback(hObject, eventdata, handles)
% hObject    handle to selectCoordinatesToPlotID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectCoordinatesToPlotID


if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectCoordinatesToPlotID, 'Value', 1)
else
	set(handles.selectCoordinatesToPlotID, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectTrialsSO.
function selectTrialsSO_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsSO

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectTrialsSO, 'Value', 1)
else
	set(handles.selectTrialsSO, 'Value', 0)
end

guidata(hObject,handles)

% --- Executes on button press in selectXaxisSO.
function selectXaxisSO_Callback(hObject, eventdata, handles)
% hObject    handle to selectXaxisSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectXaxisSO

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.selectXaxisSO, 'Value', 1)
else
	set(handles.selectXaxisSO, 'Value', 0)
end

guidata(hObject,handles)
