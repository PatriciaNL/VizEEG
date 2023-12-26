% last modified: 12/29/2023 - script was for avg not single trials
%%%%%%%%%%%%%%%%% NO STEP OF PROCESSING PIPELINE %%%%%%%%%%%%%%%%%%%%%
% This script imports all subjects EEG data in time domain in a single 
% cell per condition presented and then stores this data into a .mat
% file. save IsEpochOK to exclude rejected trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DataDir ='D:\AttnXV3_analysis\rawEEG\'; % source eeg
RCA_dir = 'D:\sweep_data_a\rcaExtra'; addpath(RCA_dir)
DataDirOut = 'D:\AttnXV3_analysis\AllRaw_EEG_Data\'; %dir where cell data will be stored
OutFileName = 'All_EEG_Data_113023.mat'; % file name will be saved
outp = fullfile(DataDirOut , OutFileName);
addpath(DataDir); addpath(DataDirOut);  cd (DataDir);
eegSrc = fullfile(DataDir);
%% take powerdiva export and convert it to cell array format
list_subj = dir([eegSrc filesep 'nl*']); % data info
domain = '\Exp_MATL_HCN_128_Avg'; % import time data
nsubj = numel(list_subj); % get total % of subjects
subjN = strings(1,nsubj);
axxData = {}; % cell to store all subjects data
IsEpochOK = {};
sub_counter = 1;
while sub_counter <= nsubj
        if (list_subj(sub_counter).isdir)
            subjDir = fullfile(eegSrc, list_subj(sub_counter).name, domain);
            subjName = list_subj(sub_counter).name; % file name
            label = subjName;%subjName(4:13);
            subjN(sub_counter) = label;
            try
                display(['Loading ' list_subj(sub_counter).name]);

                axxTrials = dir(fullfile(subjDir, 'Axx_*_trials.mat')); % access these files only            

                nCnd = numel(axxTrials); % conditions is the number of existing files of this format

                % nCnd x nElectodes x nTrials
                subjEEG = cell(nCnd, 1); % function
                % flatten the data out, each subj is a row, each col is cnd
                for c = 1:nCnd % loop for total trials
                    dataFile = fullfile(subjDir, axxTrials(c).name); % name of file for each condition
                    %disp(dataFile) % show the file being imported
                    try
                        load(dataFile); % import the file if it exists 
                        subjEEG{c} = Wave;
                    catch
                        sprintf('Error loading %s', dataFile);
                    end
                end
                % flatten the data out, each subject is a row, each column is a cond
                axxData(sub_counter, :) = (subjEEG(:))'; % store per col (transpose)

            catch err
                display(['Warning, could not load   ' list_subj(sub_counter).name]);
                display(err.message);
            end
        end
        sub_counter = sub_counter + 1; % counter to move to the next subject
end
%% Import and save IsEpochOK index into mat files
rawTrials =  dir(fullfile(subjDir, 'Raw_*.mat'));
IEP_Nfiles = {rawTrials.name};
iters = sort(IEP_Nfiles);
%IsEpochOKFile = fullfile(subjDir, rawTrials(c).name);
cX_files = dir(fullfile(subjDir, 'Raw_c003_*.mat'));
cX_FileName = {cX_files.name};
NumIters = numel(cX_FileName); % 132
disp(NumIters)
SubjEpochIndex = cell(NumIters,1);
for k = 1:NumIters    
    SubjEpochFile = fullfile(subjDir, cX_FileName(k));
    SubjEpochFile = char(SubjEpochFile); 
    NumItems = load(SubjEpochFile);
    EpochInds = NumItems.IsEpochOK; % 8 x 128 channels
    SubjEpochIndex{k} = EpochInds; % 80 x 1 
end 
% import some data to see whats going on 
epochind = load('Raw_c001_t001.mat', 'IsEpochOK');
epoch = epochind.IsEpochOK;
eeg_c1 = load('Axx_c001_trials.mat', 'Wave');
raw_eeg = eeg_c1.Wave;
test = raw_eeg(:,:,1);
chan_index = 1:1:128;
select_chans = [chan_index(epoch(1,:) == 1)];
plot(test(:,[chan_index(epoch(2,:) == 0)]))
bad_chans = sum(epoch(1,:) == 1);
good_chans = sum(epoch(1,:) == 0);
%% save data
outData = struct(); 
outData.names = subjN; % save all file names
outData.cellData = axxData; % save all bundeled data Nsubjs x NConds
outData.IsEpochOkData = SubjEpochIndex; %save IsEpochOK info to rmv artifacts
save(outp , 'outData', '-v7.3') % save cell based on dir and filename we made 
