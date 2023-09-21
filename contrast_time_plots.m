%% data dir
%clear; clc
DataDir1 = 'D:\sweep_time_res\MAT';
DataDir2 = 'C:\Users\inapi\Data_Analysis\EEG_Time_scripts';
addpath(DataDir1)
addpath(DataDir2)
%% import data to pick best electrodes % not incorporated into code yet
cd(DataDir2)
run('SubjElec_Chans.m');
f1_chans = UniqElecInfo.F1;
f2_chans = UniqElecInfo.F2;
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
%% params
cond = 1;
NumEps = 2; % # times we want to analyze data in pre / post manner
T1 = [1,  31] ; % start inds
T2 = [30, 60]; % end inds
EOI = 70:1:75; % electrodes of interest to average across can be: [] too
DAQ = 420; % sampling rate
nSamps = 4200; % total samples for a single trial
Fx = 2; %%%%%%%%%%%%%%%%% F1 = 1.5 Hz, F2 = 2 Hz %%%%%%%%%%%%%%%%%%%%%%%%
% math to find samps per cycle of a frequency
BinTimeinSecs = 2 ; % bin duration in seconds
NumBins = 5; % number of bins
TotalSampsPerDur = DAQ * BinTimeinSecs; % total samples per bin
SampsPerSingleCycle = DAQ / Fx; % # of samples for a single freq cycle
NumCycles = (TotalSampsPerDur / SampsPerSingleCycle) * 2; % #cycles per bin
% number of samples and arrays to use for indexing
NumSamps = TotalSampsPerDur / NumCycles ; % # of samples for 1 cycle dur
% set new empty data dims
NumRows = (nSamps/NumBins) / NumSamps; % rows 2 account 4 each binned time array
cycle_data = zeros(NumRows,NumSamps,size(EOI,2)); % empty data matrix
%legend_hands = {'pre','post'};
%%
counter = 1; % for plots
BinInd = TotalSampsPerDur:TotalSampsPerDur: nSamps;
BinInit = (BinInd - (TotalSampsPerDur-1));
cycle_init = BinInit: NumSamps : TotalSampsPerDur;
cycle_end = cycle_init + (NumSamps-1);
figure;
for bin = 1:size(BinInd,2) % iterate for all 5 contrast increments
    for subs = 1:size(fileNames,2) % iterate for all subjects 
        fullFilePath = fileNames{subs}; % subject file name
        data = load(fullFilePath); % import file with that name
        % data is indexed as 1 bin interval (2s)
        eeg_data = data.subjEEG{cond}(BinInit(bin):BinInd(bin),:,:);
        subplot(NumBins,size(fileNames,2),counter) % plot
        counter = counter + 1;
            for trial_ind = 1:NumEps % binned data within this t interval            
                data_ind = mean(eeg_data(:,EOI,T1(trial_ind):T2(trial_ind)),3,'omitnan');     
                    for row = 1:NumRows % store mini bins
                        cycle_data(row,:,:) = data_ind(cycle_init(bin):cycle_end(bin),:) ;
                    end
                erp = mean(mean(cycle_data,1,'omitnan'),3); %compute avg
                plot(erp, 'LineWidth', 2) % plot data result
                %legend(legend_hands)
                %yline(0, 'k--', 'Zero Line', 'LineWidth', 2);
                grid on; hold on; box off;
                titleString = [num2str(Fx), ' Hz ERP, C: Vert.'];
                title(titleString)
                xlabel('1 Freq Cycle'); ylabel('Amplitude (mV)');
                yMax = 5 * 10^(-6);
                yMin = -5 * 10^(-6);
                ylim([yMin,yMax]);
                set(gcf,'color','w'); shg
            end
            hold off;
    end
 end 