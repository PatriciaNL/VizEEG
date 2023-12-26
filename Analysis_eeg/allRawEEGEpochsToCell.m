%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                       Created: 12/01/2023                               %
%                     Last Modified: 12/05/2023                           %
%%%%%%%%%%%%%%%%% STEP ONE OF PROCESSING PIPELINE %%%%%%%%%%%%%%%%%%%%%%%%%
% Script imports all subjects unepoched EEG data for 1 condition in       %
% time domain in a single cell for 1 condition per bin and then calls     %
% IsEpochOK to exclude rejected trials by replacing bad channel data      % 
% with NaN's. Saved as a cell row for each subject and each col for a     %
% bin : prelude, X Core Bins, and postlude store this data into a         %
%                               .mat file                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DataDir ='D:\AttnXV3_analysis\rawEEG\'; % source eeg folders
RCA_dir = 'D:\sweep_data_a\rcaExtra\'; addpath(RCA_dir) % rca dir
DataDirOut = 'D:\AttnXV3_analysis\AllRaw_EEG_Data\'; %dir where cell data will be stored
addpath(DataDir);addpath(DataDirOut);cd(DataDir);
eegSrc = fullfile(DataDir);
%% take XDiva export and convert it to cell array format
list_subj = dir([eegSrc filesep 'nl*']); % mass file info encyclop.
domain = '\Exp_MATL_HCN_128_Avg'; % import time data
nsubj = {list_subj.name}; % import filenames
AllEpochOKData = {}; % cell to store all subjects data
sub_counter = 1;
%% start segmenting per condition, per bin, per goodChans
while sub_counter <= numel(nsubj)
    if (list_subj(sub_counter).isdir) % load consecutive file info
        % full dir of matl file to import single trials
        subjDir = fullfile(eegSrc, list_subj(sub_counter).name, domain);
        try
            display(['Loading ' list_subj(sub_counter).name]);
        catch err
            display(['Wrong path, could not load ' list_subj(sub_counter).name]);
        end
        rawTrials =  dir(fullfile(subjDir, 'Raw_*.mat'));
        f = {rawTrials.name}; % all file names
        % find all conditions in data - array
        %nCndsTotal = unique(cellfun(@(x) str2double(x(7:8)), f));
        % or if you want a specific condition
        nCndsTotal = 1; % 1-5
        for file = 1:numel(nCndsTotal)
            %SpecFileTypeCondInd = ['Raw_c00',num2str(file),'_*.mat'];
            SpecFileTypeCondInd = ['Raw_c00',num2str(nCndsTotal),'_*.mat'];
            % get raw for just indexed condition
            eegDir = dir(fullfile(subjDir, SpecFileTypeCondInd));
            fName = {eegDir.name}; % files for 1 condition,x trial
            basicInfo = load(char(fName(1))); % all files have uniform struct, get first one
            length = size(basicInfo.RawTrial,1); % whole trial duration
            Nbins = size(basicInfo.IsEpochOK,1); % bins of data
            Nchans = size(basicInfo.IsEpochOK,2); % all channels
            % get all number of trials for each condition
            nTrialsTotal = unique(cellfun(@(x) str2double(x(11:13)), fName));
            nTrialsTotal = numel(nTrialsTotal);
            %disp(nTrialsTotal)
            EEGperBin = cell(Nbins,1);
            disp(size(EEGperBin))
            BinDur = length/Nbins;
            matrixSize = [BinDur,Nchans,nTrialsTotal];
            disp(matrixSize)
            nEEGBins = cell(Nbins, 1);
            % Assign empty matrices to each cell
            for i = 1:Nbins
                nEEGBins{i} = zeros(matrixSize);
            end
            for trial = 1:nTrialsTotal
                rawData = fullfile(subjDir, (eegDir(trial).name));
                data = load(rawData);
                RawTrial = data.RawTrial; % t x chans
                RawTrial = RawTrial(:,1:128); % rmv last chans
                IsEpochOK = data.IsEpochOK; % bins x chans
                for bin = 1:size(EEGperBin,1)
                    % 560 x 128 x 1 trial per cell                   
                    goodChans = IsEpochOK(bin,:); % 1 x 128 bool
                    nEEGBins{bin}(:,:,trial) = RawTrial(((bin-1)*(BinDur))+1:bin*(BinDur),:);
                    nEEGBins{bin}(:,~goodChans,trial) = NaN;
                end
            end
        end
    end
    % epoched, and artifact corrected data
    % subject x chronological bin epochs [(pre)L -> R(post)]
    % 12th subjects is suspiscious - drops 1 trial
    AllEpochOKData(sub_counter, :) = (nEEGBins(:));
    sub_counter = sub_counter + 1;
end
%% save epoched data with bad channels rmv'ed into folder we want
OutFileName = ['C', num2str(nCndsTotal), '_Epoched_EEG_122523.mat']; %fn
outp = fullfile(DataDirOut , OutFileName);
outData = struct(); 
outData.names = nsubj; % save all file names
outData.cellData = AllEpochOKData; % save all bundeled data Nsubjs x NConds
disp 'Saving Data ...'
%save(outp , 'outData', '-v7.3') % save cell based on dir and filename we made 
disp 'Data Saved!'
%% some quick visualization of eeg data
sub = 22; % subject data
bin_ind = 3; %(1-8)
nElecs = 65:85; % select electrodes
nBinData = AllEpochOKData(sub,:); % 1 row, 8 cells

for bin_iter = 1:size(nBinData,2)
   a = nBinData{bin_iter}; % 560 x 128 x 78
   b = mean(a(:,nElecs,1:3), 3,'omitnan');
   c = mean(b,2);
   plot(c);
   hold on
 end