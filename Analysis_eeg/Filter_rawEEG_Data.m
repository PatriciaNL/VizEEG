%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                        Created: 12/06/2023                              %
%                     Last Modified: 12/12/2023                           %
%%%%%%%%%%%%%%%%% STEP TWO OF PROCESSING PIPELINE %%%%%%%%%%%%%%%%%%%%%%%%%
% This script imports epoched EEG data for 1 condition generated from the %
% previous step, pick a file / condition, enter F1 and F2 frequencies to  %
% filter and save into another .mat file with the condition name and date %
% the data was saved. Output is : Filtered data (clean) for the single    %
%                   condition that was imported. Also able to filter      %
% based on the hemisphere dependent activity (index channels)             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set Dirs and pick condition to filter
SourceDir =  'D:\AttnXV3_analysis\AllRaw_EEG_Data'; addpath(SourceDir); cd(SourceDir);
RCA_dir = 'D:\sweep_data_a\rcaExtra'; addpath(RCA_dir)
HemiIndsDir = 'D:\AttnXV3_analysis\Analysis_Xtra\EEG_analysis_imports\'; addpath(HemiIndsDir)
fileNameIn = 'C4_Epoched_EEG_120723.mat'; % cell data raw
outDir = 'D:\AttnXV3_analysis\cleanEEG\'; % where filter data will be stored
c_lab = num2str(fileNameIn(2)); % get condition we imported into string
%% filter params
Data2Clean = 'nF1clean'; % or nF1clean
Chans2Use = 'LeftHemi'; % or RightHemi
filterOperation = 'keep'; % or remove
DAQ = 420; % sampling rate 
Nfile = ['C', c_lab, '_', Data2Clean,'_',Chans2Use, 'OccipChans_122523.mat']; % name for filtered data (out)
% Frequencies used for bilateral vep
Fx = [3 , 3.75]; 
freqsPresentHz = Fx * 2; % inverse stim
%% Import data specs before filtering 
matFileLoc = fullfile(outDir, Nfile);
cell_data = load(fileNameIn);
data = cell_data.outData.cellData; % subj x bins (over time)
Fname = cell_data.outData.names;
% load electrode placement inds
%HemiInds = fullfile(HemiIndsDir,'LatHemi_Index.mat');
%elecInfo = load(HemiInds);
% NumElecsL = elecInfo.Channel_Indicies.L;
% NumElecsR = elecInfo.Channel_Indicies.R;
% NumElecsM = elecInfo.Channel_Indicies.M;
% left occ - 65 66 67 68 69 70 71 72 75 73 74
% right occ - 72 75 76 77 82 83 84 88 89 90 94 
NumElecsL = [65,66,67,68,69,70,71,72,73,74,75];
NumElecsR = [72,75,76,77,82,83,84,88,89,90,94];
%% fixed params based on input ^
cycleSizeSamplesPresent = round(DAQ./freqsPresentHz); % min samp per freq (each)
% get the fundamntal freq + 1st harmonic in the above list
% this line calculates the least common multiple of the freqs
% lcm calculates the least common multiple 
minEpochDurationSamples = lcm(cycleSizeSamplesPresent(1), cycleSizeSamplesPresent(2));
freqsPresentHz_2F = freqsPresentHz; % rep of the same list - for sm else
freqsSplitHz_nF1 = freqsPresentHz_2F(1):freqsPresentHz_2F(1):DAQ/2;
freqsSplitHz_nF2 = freqsPresentHz_2F(2):freqsPresentHz_2F(2):DAQ/2;
filteredFreqPeriods_nF1 = floor(freqsSplitHz_nF1*minEpochDurationSamples./DAQ);
filteredFreqPeriods_nF2 = floor(freqsSplitHz_nF2*minEpochDurationSamples./DAQ);
%% Select which frequency to undergo filtering 
switch Data2Clean
    case 'nF1clean'
        filteredFreqPeriods = setdiff(filteredFreqPeriods_nF1, filteredFreqPeriods_nF2);
    case 'nF2clean'
        filteredFreqPeriods = setdiff(filteredFreqPeriods_nF2, filteredFreqPeriods_nF1);
end 
%% Pick what chans data will go through filtering 
switch Chans2Use
    case 'LeftHemi'
        indData = cellfun(@(x) x(:, NumElecsL, :), data, 'UniformOutput', false);
        % replace nans
        ind_data = cellfun(@(x) fillmissing(x, 'spline'), indData, 'UniformOutput', false);% use spline to fix filter
        elecsUsed = NumElecsL;
    case 'RightHemi'
        indData = cellfun(@(x) x(:, NumElecsR, :), data, 'UniformOutput', false);
        ind_data = cellfun(@(x) fillmissing(x, 'spline'), indData, 'UniformOutput', false);% use spline to fix filter
        elecsUsed = NumElecsR;
end 
%% begin filtering
% 4 d matrix
resampledDataCell =  cellfun(@(x) reshapeTrialToEpochs(x, minEpochDurationSamples), ind_data,'uni', false);
if (isempty(filteredFreqPeriods))
        disp 'Something went wrong, double check params'
else    
    disp 'Filtering data ....'
end

filteredFreqPeriodsNq = filteredFreqPeriods(filteredFreqPeriods < round(minEpochDurationSamples/2));
 % filter data
 [cleanSignal, nFSignal] = cellfun(@(x) rcaExtra_filter4DData(x, filteredFreqPeriodsNq), ...
 resampledDataCell, 'uni', false);

 switch filterOperation
        case 'keep'
            dataOut = cellfun(@(x) reshapeEpochsToTrial(x), nFSignal, 'uni', false);
        case 'remove'
            dataOut = cellfun(@(x) reshapeEpochsToTrial(x), cleanSignal, 'uni', false);
        otherwise
 end

DataStore = struct;
DataStore.eeg = dataOut; % filtered and chan indexed data
DataStore.names = Fname; % subject names
DataStore.usedChans = elecsUsed; % array of electrodes used
DataStore.HemiData = Chans2Use; % hemisphere the electrodes are located on 
%% plot data(pre-filter) vs dataOut(post-filter)
subj = 35;

label = Fname(subj);
rawData = data(subj,:);
filteredData = dataOut(subj,:); 

for iter = 1:size(data,2)
    disp(iter)
    % rawData 
    a = mean(indData{iter},3, 'omitnan'); % 560 x 128
    b = squeeze(mean(a,2, 'omitnan'));
    % filteredData
    y = mean(dataOut{iter},3, 'omitnan'); % 560 x 128
    z = squeeze(mean(y,2, 'omitnan')); 
    % plt figs per bin for comparision
    figure; title(label)
    plot(b,'DisplayName','rawData','LineWidth',2,Color=[0 0 0]);
    hold on;
    plot(z,'DisplayName','filteredData','LineWidth',2,Color=[0 0 1]);
    grid; legend;
    hold off;
end
%% save data
 disp 'Saving Data ...'
% save(matFileLoc , 'DataStore' , '-v7.3') 
 disp 'Data Saved!'
%% see differences, viz sanity check :p
% d = dataOut(1,:); % 30 bins 
% Nelecs = 55:95;
% for bin = 1:size(d,2)
%     figure
%     eeg = d{bin}; % 420 x 128 x  20
%     avg_chans_pre = squeeze(mean(eeg(:,Nelecs,1:10),2,'omitnan')); % 420 x 1 x 10
%     avg_chans_post = squeeze(mean(eeg(:,Nelecs,11:20),2,'omitnan')); % 420 x 1 x 10
%     avg_pre = mean(avg_chans_pre,2, 'omitnan');
%     avg_post = mean(avg_chans_post,2, 'omitnan');
%     plot(avg_pre,'LineWidth',2, 'Color','black', 'DisplayName','Pre')
%     hold on;
%     grid;
%     plot(avg_post,'LineWidth',2, 'Color','blue', 'DisplayName','Post')
%     hold off;
% end