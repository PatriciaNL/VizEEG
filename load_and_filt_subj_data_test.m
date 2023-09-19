%% attempt to clean eeg data for just one certain frequency
%% set path for data
DataDir1 = 'D:\sweep_time_res\MAT';
DataDir2 = 'C:\Users\inapi\Data_Analysis\EEG_Time_scripts';
addpath(DataDir1)
addpath(DataDir2)
cd(DataDir2)
run('SubjElec_Chans.m');
f1_chans = UniqElecInfo.F1;
f2_chans = UniqElecInfo.F2;
cd(DataDir1) % set working directory
disp(pwd)
fileList = dir(DataDir1); % lists files and folder
fileNames = {};
for i = 1:numel(fileList)
    % Check if the item is a file (not a directory)
    if ~fileList(i).isdir
        % Get the file name and add it to the cell array
        fileNames{end+1} = fileList(i).name;
    end
end

fileNames = sort(fileNames);

%% store all data thats imported
data_cells = cell(numel(fileNames),1);
%% import data
counter = 1;
DataInvCounter = 0;

for subs = 1:size(fileNames,2) % all subjects 
    subj_id = fileNames{subs}(7:15);
    fullFilePath = fileNames{subs}; % subject file name
    data = load(fullFilePath); % import file with that name
    c1 = data.subjEEG{1}; % 60 trials
    DataInvCounter = DataInvCounter + 1; 
    data_cells{DataInvCounter} = c1;
    end1 = size(c1,3)/2 ;
    end2 = end1 + 1;

    %c2 = data.subjEEG{2}; % 20 trials
    elec = f1_chans(subs); % choosen electrode  
    %disp(elec)
    nbins = 10; % number of time epochs per trial
    binsize = 420; %210; % half of trial time - 0.5 seconds    
    vep_data = cell(1,2);
    c1_data = squeeze(c1(:,elec,:)); % time (4200) by 1 electrode
    c1_pre  = c1_data(:,1:end1);
    c1_post = c1_data(:,end2:end); 
        for bin = 1:nbins % loop 1 - 10 
            vep_data{1}(:,end+1:end+end1) = c1_pre((bin-1)*binsize+1:bin*binsize,:);
            vep_data{2}(:,end+1:end+end1)= c1_post((bin-1)*binsize+1:bin*binsize,:);
        end

     yMax = 5 * 10^(-6);
     yMin = -5 * 10^(-6);

     for cond = 1:2
        m1 = mean(vep_data{cond},2,'omitnan')';
        ntrials = sum(~isnan(vep_data{cond}(1,:)));
        s1 = nanstd(vep_data{cond}')/sqrt(ntrials);
        s1(1:5:end) = nan;
        s1(2:5:end) = nan;
        s1(3:5:end) = nan;
        s1(4:5:end) = nan;

        subplot(3,3,counter)
        colororder([0 0 0; 0 .2 1; 1 .5 0])
        title('Subject: ', subj_id)
        errorbar(m1,s1,'LineWidth',0.75)
        hold on;
     end
        hold off
        box off;
        grid on
        xlabel('Time (ms)'); ylabel('Amplitude (mV)');
        set(gca,'xtick',1:42:420,'xticklabel',0:100:1000)
        set(gcf,'color','w')
        ylim([yMin,yMax]);
        xlim([1 420]);
        counter = counter + 1;
        fprintf('%d\n',counter)
        shg
end 
%% enter analysis params 
DAQ = 420;
%freqsPresentHz = [10,20,30,40,50]; % list of frequencies present
% 2f1 4f1 6f1 8f1
freqsPresentHz = [1.5,3,4.5,6];
%freqsPresentHz = [2,4,6,8];
%% make simulation data first

% number of samples reqired to fully encapsulate a single cycle, array is 
% supposed to be decreasing as you near the final frequencies - faster 
% frequencies have a smaller cycle duration bc its cycling faster. 

% cycleSizeSamplesPresent returns a list 
cycleSizeSamplesPresent = round(DAQ./freqsPresentHz); % min samp per freq (each)

% get the fundamntal freq + 1st harmonic in the above list
% this line calculates the least common multiple of the freqs
% lcm calculates the least common multiple 
minEpochDurationSamples = lcm(cycleSizeSamplesPresent(1), cycleSizeSamplesPresent(2));
freqsPresentHz_2F = freqsPresentHz; % rep of the same list - for sm else

% workaround we will probs mever need 
if( numel(freqsPresentHz) == 1)
        freqsPresentHz_2F = [freqsPresentHz, freqsPresentHz];
end

% compute nF1, nF2 frequencies
% 1st freq ; 1st freq : 210 (1/2 DAQ rate)
freqsSplitHz_nF1 = freqsPresentHz_2F(1):freqsPresentHz_2F(1):DAQ/2;
% 1st harm freq : 1st harm freq : 210 (1/2 DAQ rate)
freqsSplitHz_nF2 = freqsPresentHz_2F(2):freqsPresentHz_2F(2):DAQ/2;

filteredFreqPeriods_nF1 = floor(freqsSplitHz_nF1*minEpochDurationSamples./DAQ);
filteredFreqPeriods_nF2 = floor(freqsSplitHz_nF2*minEpochDurationSamples./DAQ);

Data2Clean = 'nF1clean';

switch Data2Clean
    case 'nF1clean'
        filteredFreqPeriods = setdiff(filteredFreqPeriods_nF1, filteredFreqPeriods_nF2);
    case 'nF2clean'
        filteredFreqPeriods = setdiff(filteredFreqPeriods_nF2, filteredFreqPeriods_nF1);
end 

if (isempty(filteredFreqPeriods))
        disp 'unable to perform filtering'
else    
    disp 'able to perform filtering'
        return;
end

%resampledDataCell = cell(1,2);
%resampledDataCell{1} = c1;
%resampledDataCell{2} = c1;

resampledDataCell = data_cells;

filteredFreqPeriodsNq = filteredFreqPeriods(filteredFreqPeriods < round(minEpochDurationSamples/2));

 % filter data
 [cleanSignal, nFSignal] = cellfun(@(x) rcaExtra_filter4DData(x, filteredFreqPeriodsNq), ...
 resampledDataCell, 'uni', false);

 filterOperation = 'keep';

 switch filterOperation
        case 'keep'
            dataOut = cellfun(@(x) reshapeEpochsToTrial(x), nFSignal, 'uni', false);
        case 'remove'
            dataOut = cellfun(@(x) reshapeEpochsToTrial(x), cleanSignal, 'uni', false);
        otherwise
 end
% look to see how data varies
 cs_test = mean(cleanSignal{1},3,'omitnan');
 nfs_test = mean(nFSignal{1},3,'omitnan');
 dout_test = mean(dataOut{1},3,'omitnan');

figure
plot(cs_test(:,71));
hold on;
plot(nfs_test(:,71));
hold off;
%plot(dout_test(:,71));
figure
plot(cs_test(:,1:10))
hold off;
figure
plot(nfs_test(:,1:10))

%resampledDataCell = h_eeg_signal(minEpochDurationSamples); eeg_signal;

%[cleanSignal, nFSignal] = cellfun(@(x) rcaExtra_filter4DData(x, filteredFreqPeriodsNq), ...
%resampledDataCell, 'uni', false);

%% toy data just in case
time = 1;
freq = 10;
amp = 1;
num_harmonics = 5;
TimeVec = 0 :(1/DAQ): time; % 0 - 1 by step of 1/420

eeg_signal = zeros(size(TimeVec));
h_eeg_signal = zeros(size(TimeVec));

p_harmonic = amp* sin(2* pi* freq* TimeVec);

eeg_signal = eeg_signal + p_harmonic;
h_eeg_signal =  h_eeg_signal + p_harmonic;

for harmonic = 2: num_harmonics
    harmonic_frequency = freq * harmonic;
    harmonic_amplitude = amp / harmonic ;
    harmonic_component = harmonic_amplitude * sin(2* pi* harmonic_frequency* TimeVec);
    h_eeg_signal = h_eeg_signal + harmonic_component ;
end 
% plot the faux eeg data >:D
figure
plot(TimeVec, eeg_signal);
hold on;
plot(TimeVec , h_eeg_signal)
