%% Set Directories and add paths
CleanDataDir = 'D:\version3\cleanEEG'; % preprocessed EEG Data (filtered)
RCA_dir = 'D:\CODE_SCRIPTS\sweep_data_a\rcaExtra';  % RCA Extra functions
SaveImgDir = 'D:\version3\plots\eeg';
addpath(CleanDataDir);addpath(RCA_dir);addpath(SaveImgDir)
%% F1 file names (3hz filtered)
F1_C3 = 'C3_nF1clean_112023.mat'; 
F1_C4 = 'C4_nF1clean_112023.mat';
F1_C5 = 'C5_nF1clean_112023.mat';
F1_C6 = 'C6_nF1clean_112023.mat'; 
%% F2 file names (3.75 hz filtered)
F2_C3 = 'C3_nF2clean_112023.mat';
F2_C4 = 'C4_nF2clean_112023.mat';
F2_C5 = 'C5_nF2clean_112023.mat';
F2_C6 = 'C6_nF2clean_112023.mat';
%% Data + Info for epoching f1
dataf1_C3 = load(F1_C3); % load 1st cond
dataf1_C4 = load(F1_C4);
dataf1_C5 = load(F1_C5);
dataf1_C6 = load(F1_C6); % load 4th cond
%% Data + Info for epoching f2 
dataf2_C3 = load(F2_C3); % load 1st cond
dataf2_C4 = load(F2_C4);
dataf2_C5 = load(F2_C5);
dataf2_C6 = load(F2_C6); % load 4th cond
%% load eeg data in each f1 file
eegf1_c3 = dataf1_C3.DataStore.eeg;
eegf1_c4 = dataf1_C4.DataStore.eeg;
eegf1_c5 = dataf1_C5.DataStore.eeg;
eegf1_c6 = dataf1_C6.DataStore.eeg;
%% load eeg data in each f2 file
eegf2_c3 = dataf2_C3.DataStore.eeg;
eegf2_c4 = dataf2_C4.DataStore.eeg;
eegf2_c5 = dataf2_C5.DataStore.eeg;
eegf2_c6 = dataf2_C6.DataStore.eeg;
%% load data/subject labels
Sname = dataf1_C3.DataStore.names; % file info / subj title
Nsubs = size(dataf1_C3.DataStore.eeg,1); % total # of subjs
[nSamps, nChans, nTrials] = size(eegf1_c3{1}); % data shape / info
%dims = round(sqrt(Nsubs));
Nelecs = 65:85; % list of chans to look at
%% import eeg data per subject
sr = 420;
time = (0:(length(ones(560))-1)) / sr * 1000;

for ind = 1:Nsubs
    figure
    condf1_3 = eegf1_c3{ind};
    condf1_4 = eegf1_c4{ind};
    condf1_5 = eegf1_c5{ind};
    condf1_6 = eegf1_c6{ind};

    condf2_3 = eegf2_c3{ind};
    condf2_4 = eegf2_c4{ind};
    condf2_5 = eegf2_c5{ind};
    condf2_6 = eegf2_c6{ind};
    %% average of eeg activity for each condition
    mcf1_3 = mean(mean(condf1_3(:,Nelecs,:),3, 'omitnan'),2);
    mcf1_4 = mean(mean(condf1_4(:,Nelecs,:),3, 'omitnan'),2);
    mcf1_5 = mean(mean(condf1_5(:,Nelecs,:),3, 'omitnan'),2);
    mcf1_6 = mean(mean(condf1_6(:,Nelecs,:),3, 'omitnan'),2);

    mcf2_3 = mean(mean(condf2_3(:,Nelecs,:),3, 'omitnan'),2);
    mcf2_4 = mean(mean(condf2_4(:,Nelecs,:),3, 'omitnan'),2);
    mcf2_5 = mean(mean(condf2_5(:,Nelecs,:),3, 'omitnan'),2);
    mcf2_6 = mean(mean(condf2_6(:,Nelecs,:),3, 'omitnan'),2);
    %%
    subplot(1,2,1)
    plot(time,mcf1_3, 'DisplayName', 'c3', LineWidth = 1, Color =  [0, 0, 0])
    hold on;
    plot(time,mcf1_4, 'DisplayName', 'c4', LineWidth = 1, Color =  [0.4660 0.6740 0.1880])
    plot(time,mcf1_5, 'DisplayName', 'c5', LineWidth = 1, Color =  [0.3010 0.7450 0.9330])
    plot(time,mcf1_6, 'DisplayName', 'c6', LineWidth = 1, Color = [0.4940 0.1840 0.5560])
    legend('Location','southwest','FontAngle','italic','FontSize',4); grid;
    titleString = ['3 hz filter : ',num2str(Sname(ind))];
    title(titleString)
    xlabel('Time (ms)'); ylabel('Amp (mV)');
    yMax = 4 ;% * 10^(-6);
    yMin = -4 ;% * 10^(-6);
    ylim([yMin,yMax]);
    xticks(0:100:1400);
    set(gcf,'color','w'); shg;
    hold off;
    %
    subplot(1,2,2)
    plot(time,mcf2_3, 'DisplayName', 'c3', LineWidth = 1, Color =  [0, 0, 0])
    hold on;
    plot(time,mcf2_4, 'DisplayName', 'c4', LineWidth = 1, Color =  [0.4660 0.6740 0.1880])
    plot(time,mcf2_5, 'DisplayName', 'c5', LineWidth = 1, Color =  [0.3010 0.7450 0.9330])
    plot(time,mcf2_6, 'DisplayName', 'c6', LineWidth = 1, Color = [0.4940 0.1840 0.5560])
    legend('Location','southwest'); grid;
    titleString = ['3.75 hz filter : ',num2str(Sname(ind))];
    title(titleString)
    hold off;
    xlabel('Time (ms)'); ylabel('Amp (mV)');
    yMax = 4 ;% * 10^(-6);
    yMin = -4 ;% * 10^(-6);
    ylim([yMin,yMax]);
    xticks(0:100:1400);
    set(gcf,'color','w'); shg;
    Fname =  ['conditions_ERP_',num2str(Sname(ind)),'.png'];
    ImgPath = fullfile(SaveImgDir, Fname);
    saveas(gcf, ImgPath)
    close gcf;
end 

%% plot errorbars - work in progress
% D = squeeze(mean(condf1_3(:,Nelecs,:),2,'omitnan'));
% %test = mean(mean(condf1_3(:,Nelecs,:),3,'omitnan'),2); % 560 x 8
% ntrials = sum(~isnan(D(1,:)));
% s1 = (nanstd(D))/sqrt(ntrials);

% s1(1:5:end) = nan;
% s1(2:5:end) = nan;
% s1(3:5:end) = nan;
% s1(4:5:end) = nan;
% 
% errorbar(D,s1)


