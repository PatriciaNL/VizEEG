%% Set & Get basic dimensions of data
MainDir='D:\AttnXV3_analysis\cleanEEG\';
%% 4 files per condition
nF1Lh='C3_nF1clean_LeftHemi_121123.mat';
nF1Rh='C3_nF1clean_RightHemi_121123.mat';
nF2Lh='C3_nF2clean_LeftHemi_121123.mat';
nF2Rh='C3_nF2clean_RightHemi_121123.mat';
Nfile={nF1Lh,nF1Rh,nF2Lh,nF2Rh};
%% Set Mat Files directory
matFileImport1=fullfile(MainDir,Nfile{1});
matFileImport2=fullfile(MainDir,Nfile{2});
matFileImport3=fullfile(MainDir,Nfile{3});
matFileImport4=fullfile(MainDir,Nfile{4});
%% Load eeg.mat files 
cell_data1=load(matFileImport1);
cell_data2=load(matFileImport2);
cell_data3=load(matFileImport3);
cell_data4=load(matFileImport4);
%% Load EEG Data and rmv pre and post lude
data1=cell_data1.DataStore.eeg; % subj x bins (over time)
data1=data1(:,2:9); % rmv pre and post bins
data2=cell_data2.DataStore.eeg; % subj x bins (over time)
data2=data2(:,2:9); % rmv pre and post bins
data3=cell_data3.DataStore.eeg; % subj x bins (over time)
data3=data3(:,2:9); % rmv pre and post bins
data4=cell_data4.DataStore.eeg; % subj x bins (over time)
data4=data4(:,2:9); % rmv pre and post bins
%% load channel info 
ChanIndRec1=cell_data1.DataStore.usedChans;
ChanIndRec2=cell_data2.DataStore.usedChans;
ChanIndRec3=cell_data3.DataStore.usedChans;
ChanIndRec4=cell_data4.DataStore.usedChans;
%% load hemisphere information
HemiIndRec1=cell_data1.DataStore.HemiData;
HemiIndRec2=cell_data2.DataStore.HemiData;
HemiIndRec3=cell_data3.DataStore.HemiData;
HemiIndRec4=cell_data4.DataStore.HemiData;
%% Load subject name, bins and dims of data (only need 1 file)
fName=cell_data1.DataStore.names;
numBins=size(data1,2); % rmv pre and post bins
Bin_ind = 1:1:numBins;
[nSamps,nChans,nTrials]=size(data1{1,1});
sr = 420;
freq = 3;
%nElecs = x:y; % chans to index and include
%% average data over bins for all participants
AllSubjPreEEG = cell(numel(fName),1);
AllSubjPostEEG = cell(numel(fName),1);

for subj=1:numel(fName)
    CellArrayData = data1(subj,:)';
    % combine data based on pre and post
    pre_eeg_trials=cellfun(@(x) x(:,:, 1:3), CellArrayData, 'UniformOutput', false);
    post_eeg_trials=cellfun(@(x) x(:,:, 4:6), CellArrayData, 'UniformOutput', false);
    % combine all cells along trials
    pre_eeg=cat(3,pre_eeg_trials{:});
    post_eeg=cat(3,post_eeg_trials{:});
    % info to epoch based on cycle duration ito samps
    [~,~,Numtrials] = size(pre_eeg);
    SampsPerCycle = (sr/(freq*2)); % use to bin data once more
    TotalCycles = nSamps/SampsPerCycle; % sanity check - nm lol need it bad
    % empty arrays
    pre_eeg_matrix = zeros(SampsPerCycle,nChans,Numtrials*TotalCycles);
    post_eeg_matrix = zeros(SampsPerCycle,nChans,Numtrials*TotalCycles);
    % iterate to fill arrays
    for j = 1:TotalCycles
        pre_eeg_matrix = pre_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24
        post_eeg_matrix = post_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24        
    end
    AllSubjPreEEG{subj} = pre_eeg_matrix;
    AllSubjPostEEG{subj} = post_eeg_matrix;
end

%% plot std for pre and post conditions YUH
test = AllSubjPreEEG{1}; % 70 x 59 x 24
mean_test = squeeze(mean(test,2,'omitnan'))'; % 24 x 70 (trials ,time)
nTrialsPre = sum(~isnan(mean_test(:,1))); % number of trials non-nan
pre_mean = mean(mean_test,1,'omitnan'); % 1 x 70
pre_std = std(mean_test,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
pre_std(1:4:end) = nan;
pre_std(2:4:end) = nan;
pre_std(3:4:end) = nan;
errorbar(pre_mean,pre_std,'black')

%% test plot one single subject
%test = data1(1,:)';
% combine data based on pre and post
%pre_eeg_trials=cellfun(@(x) x(:, :, 1:3), test, 'UniformOutput', false);
%post_eeg_trials=cellfun(@(x) x(:, :, 4:6), test, 'UniformOutput', false);
% % combine all cells along trials
% pre_eeg=cat(3,pre_eeg_trials{:});
% post_eeg=cat(3,post_eeg_trials{:});
% % info to epoch based on cycle duration ito samps
% [trial_dur,Numchans,Numtrials] = size(pre_eeg);
% sr = 420;
% freq = 3;
% SampsPerCycle = (sr/(freq*2)); % use to bin data once more
% TotalCycles = trial_dur/SampsPerCycle; % sanity check - nm lol need it bad
% % empty arrays 
% pre_eeg_matrix = zeros(SampsPerCycle,Numchans,Numtrials*TotalCycles);
% post_eeg_matrix = zeros(SampsPerCycle,Numchans,Numtrials*TotalCycles);
% % iterate to fill arrays
% for j = 1:TotalCycles
%     pre_eeg_matrix = pre_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24
%     post_eeg_matrix = post_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24
% end 

pre_erp = mean(mean(pre_eeg_matrix,3,'omitnan'),2,'omitnan'); % 70 x 1
post_erp = mean(mean(post_eeg_matrix,3,'omitnan'),2,'omitnan'); % 70 x 1
%post_erp = mean(mean(post_eeg,3,'omitnan'),2,'omitnan');
%squ_diff = sqrt(sum((pre_eeg - pre_erp).^2)/24); 



%% CODE BELOW IS TO PLOT BASED ON FULL TIME COURSE BY BINS
%% Plot data
% yMax = 1/3 ; yMin = -1/3 ;
% sr = 420;
% time = (0:(length(ones(560))-1)) / sr * 1000;
% 
% for subj=1:numel(fName)
%     figure
%     for BinInd=1:numBins
%         % average per channels
%         eeg1=mean(data1{subj,BinInd},2,'omitnan'); %
%         eeg2=mean(data2{subj,BinInd},2,'omitnan'); %
%         eeg3=mean(data3{subj,BinInd},2,'omitnan'); %
%         eeg4=mean(data4{subj,BinInd},2,'omitnan'); %
%         % average per trials
%         erp1=squeeze(mean(eeg1,3,'omitnan'))/1000; % time in sr x 1
%         erp2=squeeze(mean(eeg2,3,'omitnan'))/1000; % time in sr x 1
%         erp3=squeeze(mean(eeg3,3,'omitnan'))/1000; % time in sr x 1
%         erp4=squeeze(mean(eeg4,3,'omitnan'))/1000; % time in sr x 1
% 
%         if BinInd == 1 || BinInd == 6
%         % plot for nF1 Left
%         subplot(2,2,1)
%         title(char(Nfile{1}(1:20)));
%         plot(time,erp1,'DisplayName',num2str(Bin_ind(BinInd)),LineWidth=2,Color=[0 0 (BinInd/10)/1]);
%         legend('Location','southwest','FontAngle','italic','FontSize',4); grid;
%         hold on;
%         xlabel('Time (ms)'); ylabel('Amp (mV)');
%         ylim([yMin,yMax]);
%         set(gcf,'color','w'); shg;
% 
%         % plot for nF1 Right
%         subplot(2,2,2)
%         title(char(Nfile{2}(1:20)));
%         plot(time,erp2,'DisplayName',num2str(Bin_ind(BinInd)),LineWidth=2,Color=[0 0 (BinInd/10)/1]);
%         legend('Location','southwest','FontAngle','italic','FontSize',4); grid;
%         hold on;
%         xlabel('Time (ms)'); ylabel('Amp (mV)');
%         ylim([yMin,yMax]);
%         set(gcf,'color','w'); shg;
% 
%         % plot for nF2 Left
%         subplot(2,2,3)
%         title(char(Nfile{3}(1:20)));
%         plot(time,erp3,'DisplayName',num2str(Bin_ind(BinInd)),LineWidth=2,Color=[0 0 (BinInd/10)/1]);
%         legend('Location','southwest','FontAngle','italic','FontSize',4); grid;
%         hold on;
%         xlabel('Time (ms)'); ylabel('Amp (mV)');
%         ylim([yMin,yMax]);
%         set(gcf,'color','w'); shg;
% 
%         % plot for nF2 Right
%         subplot(2,2,4)
%         title(char(Nfile{4}(1:20)));
%         plot(time,erp4,'DisplayName',num2str(Bin_ind(BinInd)),LineWidth=2,Color=[0 0 (BinInd/10)/1]);
%         legend('Location','southwest','FontAngle','italic','FontSize',4);grid;
%         hold on;
%         xlabel('Time (ms)'); ylabel('Amp (mV)');
%         ylim([yMin,yMax]);
%         set(gcf,'color','w'); shg;
% 
%         sgtitle(char(fName(subj)))
%         else
%             disp('skipping middle bin eeg')
%         end 
%     end
%     %hold off;
%     %close gcf;
% end