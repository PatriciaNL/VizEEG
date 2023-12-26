%% Set Directories and add paths
CleanDataDir = 'D:\version3\cleanEEG'; % preprocessed EEG Data (filtered)
RCA_dir = 'D:\CODE_SCRIPTS\sweep_data_a\rcaExtra';  % RCA Extra functions
SaveImgDir = 'D:\version3\plots\inductionPlots';
addpath(CleanDataDir);addpath(RCA_dir);addpath(SaveImgDir)
%% F1 file names (1hz filtered)
F1_C2 = 'C2_nF1clean_112023.mat'; 
%  F2 file names (1.5 hz filtered)
F2_C2 = 'C2_nF2clean_112023.mat';
%% Data + Info for files
dataf1_C2 = load(F1_C2); % load 1st cond
dataf2_C2 = load(F2_C2); % load 1st cond
%% load eeg data
eegf1_c2 = dataf1_C2.DataStore.eeg;
eegf2_c2 = dataf2_C2.DataStore.eeg;
%% load data/subject labels
Sname = dataf1_C2.DataStore.names; % file info / subj title
Nsubs = size(dataf1_C2.DataStore.eeg,1); % total # of subjs
[nSamps, nChans, nTrials] = size(eegf1_c2{1}); % data shape / info
Nelecs = 65:85; % list of chans to look at
%% import eeg data per subject
sr = 420;
time = (0:(length(ones(840))-1)) / sr * 1000;
for ind = 1:Nsubs
    figure
    cond2f1 = eegf1_c2{ind};
    cond2f2 = eegf2_c2{ind};
    %% average of eeg activity for each condition
    c2f1 = mean(mean(cond2f1(:,Nelecs,:),3, 'omitnan'),2);
    c2f2 = mean(mean(cond2f2(:,Nelecs,:),3, 'omitnan'),2);
    %%
    subplot(1,2,1)
    plot(time,c2f1, 'DisplayName', '1 Hz', LineWidth = 1, Color =  [0.4940 0.1840 0.5560])
    legend('Location','southwest');
    titleString = ['1 hz filter: ',num2str(Sname(ind))];
    title(titleString)
    xlabel('Time (ms)'); ylabel('Amp (mV)');
    yMax = 3 ; yMin = -3 ;
    ylim([yMin,yMax]);
    xticks(linspace(0, 2 * 1000, 10)); 
    grid;set(gcf,'color','w'); shg;
    
    subplot(1,2,2)
    plot(time,c2f2, 'DisplayName', '1.5 Hz', LineWidth = 1, Color =  [0.6350 0.0780 0.1840])
    legend('Location','southwest'); 
    titleString = ['1.5 hz filter: ',num2str(Sname(ind))];
    title(titleString)
    xlabel('Time (ms)'); ylabel('Amp (mV)');
    yMax = 3 ; yMin = -3 ; 
    ylim([yMin,yMax]);
    xticks(linspace(0, 2 * 1000, 10));
    grid;set(gcf,'color','w'); shg;
    Fname =  ['C2_erp_',num2str(Sname(ind)),'.png'];
    ImgPath = fullfile(SaveImgDir, Fname);
    saveas(gcf, ImgPath)
    close gcf;
end 