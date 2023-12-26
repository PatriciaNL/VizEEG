%% Set Directories
CleanDataDir = 'D:\version3\cleanEEG'; % preprocessed EEG Data
RCA_dir = 'D:\CODE_SCRIPTS\sweep_data_a\rcaExtra';  % RCA Extra Dir
F1_file = 'C1_nF1cleanV3_111123.mat'; % F1 clean 
F2_file = 'C1_nF2cleanV3_111123.mat'; % F2 clean 
%F1_file = 'nF1Clean_data.mat'; % F1 clean 
%F2_file = 'nF2Clean_data.mat'; % F2 clean
addpath(CleanDataDir); addpath(RCA_dir); cd(CleanDataDir); % add paths
%% Data + Info for epoching 
dataF1 = load(F1_file); % load file 1 - cell of subj data
dataF2 = load(F2_file); % load file 2
F1 = dataF1.DataStore.eeg ; F2 = dataF2.DataStore.eeg; % contains filter data
Nsubs = size(dataF1.DataStore.eeg,1); % total # of subjs
Sname = dataF1.DataStore.names; % name of eeg file (Subj ID)
dims = round(sqrt(Nsubs));
[nSamps, nChans, nTrials] = size(F1{1}); % data shape / info
%% Set basic params
Fx = 3; %%%% frequency to pick (2 choices) : F1 = 3 Hz, F2 = 3.75 Hz %%%%%%
DAQ = 420; % sampling rate
EOI = 65:85; % chans of interest
T1 = [1,  40] ; % start inds
T2 = [39, 78]; % end inds

%T1 = [1,4];
%T2 = [3,6];
NumEps = 2; % # times we want to analyze data in pre / post manner
%% Get Cycle Binning Info
TotalSampsPerDur = DAQ / Fx; % # of samples for a single freq cycle
NumBins = nSamps * (Fx/DAQ); % get total # of cycles completed given trial duration (BIN #)
BinTimeinSecs = (TotalSampsPerDur / DAQ); 
NumCycles = (TotalSampsPerDur/ TotalSampsPerDur) * 2; % #cycles per bin
NumSamps = TotalSampsPerDur / NumCycles ; % # of samples for 1 cycle dur
NumRows = (nSamps/NumBins) / NumSamps; % rows to account for each binned time array
%% Set Time indicies per bin
BinEnd = TotalSampsPerDur : TotalSampsPerDur : nSamps;
BinInit = (BinEnd - (TotalSampsPerDur-1));
%% Set Time indicies per cycle 
cycle_init = BinInit: NumSamps : TotalSampsPerDur;
cycle_end = cycle_init + (NumSamps-1);
cycle_data = zeros(NumRows,NumSamps,size(EOI,1));
%legend_hands = {'pre','post'};
%%  plot

F1_mini = F1(38:44);
Sname_mini = Sname(38:44);
Nsubs = 7;
counter = 1; % for plots
figure;
for bin = 1:size(BinEnd,2) % iterate for all 4 bins
    for subj = 1:Nsubs % iterate for all subjects 
        data = F1_mini{subj}; % import file with that name
        eeg_data = data(BinInit(bin):BinEnd(bin),EOI,:); % list of many electrodes
        subplot(NumBins,Nsubs,counter) % plot
        counter = counter + 1;
        for trial_ind = 1:NumEps % binned data within this time interval to average a number of electrodes
                avg = mean(eeg_data(:,:,T1(trial_ind):T2(trial_ind)),2,'omitnan'); 
                data_ind = mean(avg, 3); % single array of time
                for row = 1:NumRows % store mini bins
                   cycle_data(row,:) = data_ind(cycle_init(trial_ind):cycle_end(trial_ind),:);
                end
                erp = mean(cycle_data,1,'omitnan'); %compute avg
                if trial_ind == 1
                    plot(erp, 'DisplayName', 'pre', 'LineWidth', 1.5,'Marker','.') % plot data result
                else 
                    plot(erp, 'DisplayName', 'post', 'LineWidth', 1.5,'Marker','.') % plot data result
                end 
                grid; legend('Location','southwest');
                legend('FontSize', 4);
                grid on; hold on; box off;
                titleString = [num2str(Sname_mini(subj)),': ',num2str(Fx), ' Hz ERP'];
                title(titleString)
                xlabel('1 Freq Cycle'); ylabel('Amp (mV)');
                %yMax = 3 ;% * 10^(-6);
                %yMin = -3 ;% * 10^(-6);
                %ylim([yMin,yMax]);
                set(gcf,'color','w'); shg;
                %yline(0, 'k--', 'LineWidth', 2);
        end
        hold off;
    end 
end