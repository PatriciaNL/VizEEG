%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script cleans raw EEG data : baselinecorrection and filtering 
% and saves the cleaned data as a cell
% Last modified: 9/22/23
%9/22/23 - only does baseline correction rn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear; clc
DataDir1 = 'D:\sweep_time_res\MAT'; % eeg data
DataDir2 = 'C:\Users\inapi\Data_Analysis\EEG_Time_scripts'; % chan info
DataDir3 = 'C:\Users\inapi\sweep_data_a\rcaExtra' ; % functions from SVNDL
SaveDir = 'D:\cleaned_EEG_Data\'; % where eeg data will be saved in
OutDataFileName = 'clean_data_all.mat';
matFileLoc = fullfile(SaveDir, OutDataFileName);
addpath(DataDir1) ; addpath(DataDir2) ; addpath(DataDir3) 
%% set path where eeg data exists and get Subj ID
cd(DataDir1) % set working directory
disp(pwd)
fileList = dir(DataDir1); % lists files and folder
fileNames = {};
for i = 1:numel(fileList)
    if ~fileList(i).isdir  % Check if the item is a file (not a directory)
        % Get the file name and add it to the cell array
        fileNames{end+1} = fileList(i).name;
    end
end
fileNames = sort(fileNames);
%% import data and sotre into cells
rawEEGData_records = cell(numel(fileNames),1); % will store raw eeg data
for subs = 1:size(fileNames,2) % all subjects 
    fullFilePath = fileNames{subs}; % subject file name
    data = load(fullFilePath); % import file with that name
    c1 = data.subjEEG{1}; % 60 trials 
    rawEEGData_records{subs} = c1;
end 
%% baseline correct data
% data is:  time * chans * trials
baselinesamps = range(1:211);
baseline_correction_function = @(x) fun_baselinecorrect_3D_data(x, baselinesamps);
% Apply the baseline correction function to each cell in EEG_Data
EEG_Data = cellfun(baseline_correction_function, rawEEGData_records, 'UniformOutput', false);

save(matFileLoc, 'EEG_Data', '-v7.3') % save cleaned data 