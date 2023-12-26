%% Set & Get basic dimensions of data
MainDir='D:\AttnXV3_analysis\cleanEEG\';
%% 4 files per condition
nF1Lh='C6_nF1clean_LeftHemiOccipChans_121223.mat'; % done 
nF1Rh='C6_nF1clean_RightHemiOccipChans_121223.mat'; % done
nF2Lh='C6_nF2clean_LeftHemiOccipChans_121223.mat'; % done
nF2Rh='C6_nF2clean_RightHemiOccipChans_121223.mat'; % done
Nfile={nF1Lh,nF1Rh,nF2Lh,nF2Rh};
%% Pick what file to epoch and save
file = 4;
switch file
    case {1,2}
        Setfreq = 3;
    case {3,4}
        Setfreq = 3.75;  
end
%% Import Information from file
matFileImport=fullfile(MainDir,Nfile{file});
NumCond = Nfile{file}(1:2); % get condition
%NumFreq = Nfile{file}(4:11); % get filter info 
cell_data=load(matFileImport);
data=cell_data.DataStore.eeg; % subj x bins (over time)
data=data(:,2:9); % rmv pre and post bins
%ChanIndRec=cell_data.DataStore.usedChans;
HemiIndRec=cell_data.DataStore.HemiData; % hemisphere
fName=cell_data.DataStore.names;
%% Load subject name, bins and dims of data (only need 1 file)
numBins=size(data,2); % rmv pre and post bins
%Bin_ind = 1:1:numBins;
[nSamps,nChans,~]=size(data{1,1});
DAQ = 420;
%% Average data over bins for all participants
AllSubjPreEEG = cell(numel(fName),1);
AllSubjPostEEG = cell(numel(fName),1);

for subj=1:numel(fName)
    CellArrayData = data(subj,:)'; % transpose 
    % combine data based on pre and post
    AllPreEEG=cellfun(@(x) x(:,:, 1:3), CellArrayData, 'UniformOutput', false);
    AllPostEEG=cellfun(@(x) x(:,:, 4:6), CellArrayData, 'UniformOutput', false);
    % combine all cells along trials
    pre_eeg=cat(3,AllPreEEG{:}); % Samps x chans x stacked trials  
    post_eeg=cat(3,AllPostEEG{:}); % Samps x chans x stacked trials
    % info to epoch based on cycle duration ito samps
    [~,~,Numtrials] = size(pre_eeg); % Ntrials after stacking bins
    SampsPerCycle = (DAQ/(Setfreq*2)); % # of samples for 1 cycle given freq
    TotalCycles = nSamps/SampsPerCycle; % # of cycles completed for 1 trial
    % empty arrays: SampsPerCycle x chans x (cycles*trials)
    pre_eeg_matrix = zeros(SampsPerCycle,nChans,Numtrials*TotalCycles);
    post_eeg_matrix = zeros(SampsPerCycle,nChans,Numtrials*TotalCycles);
    % iterate to fill arrays
    for j = 1:TotalCycles
        pre_eeg_matrix = pre_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24
        post_eeg_matrix = post_eeg(((j-1)*SampsPerCycle)+1:j*SampsPerCycle,:,:); % 70 x 59 x 24        
    end
    AllSubjPreEEG{subj} = pre_eeg_matrix; % nsubjs x 1 - Samps x chans x (trials*cycles)
    AllSubjPostEEG{subj} = post_eeg_matrix;
end
%% plot std for pre and post conditions YUH
%TotalConds = 4; % 3 4 5 6 

AllDataAcrossConds = struct();

for sub_ind=1:numel(fName)
    figure
    pre_signal = AllSubjPreEEG{sub_ind}/100; % 70 x 59 x 24
    post_signal = AllSubjPostEEG{sub_ind}/100; % 70 x 59 x 24

    pre = squeeze(mean(pre_signal,2,'omitnan'))'; % 24 x 70 (trials ,time)
    post = squeeze(mean(post_signal,2,'omitnan'))'; % 24 x 70 (trials ,time)

    nTrialsPre = sum(~isnan(pre(:,1))); % number of trials non-nan
    nTrialsPost = sum(~isnan(post(:,1))); % number of trials non-nan

    pre_m1 = mean(pre,1,'omitnan'); % 1 x 70
    post_m1 = mean(post,1,'omitnan'); % 1 x 70

    pre_s1 = std(pre,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
    post_s1 = std(post,1,'omitnan')/sqrt(nTrialsPost); % 1 x 70

    pre_s1(1:3:end) = nan;
    pre_s1(2:3:end) = nan;

    post_s1(1:3:end) = nan;
    post_s1(2:3:end) = nan;
    % plot for each participant 

    % Plot pre data
    e = errorbar(pre_m1, pre_s1, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, 'DisplayName', 'Pre');
    e.Color = 'black';
    hold on;
    % Plot post data
    e = errorbar(post_m1, post_s1, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', [0.15 0.75 0.90], 'LineWidth', 2, 'DisplayName', 'Post');
    e.Color = 'blue';
    % set plt params
    legend('Location','southwest','FontAngle','italic','FontSize',12); grid;
    titleString = [num2str(NumCond),num2str(Setfreq),HemiIndRec,(fName(sub_ind))];
    titleText = sprintf('%s, VEP of %sHz at %s of %s', titleString{:});
    title(titleText)
    set(gcf,'color','w'); shg;
    yMax = 5 ; yMin = -5 ;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMin,yMax]);
    hold off;
    close gcf;
    % save data
    AllDataAcrossConds.c6preM1{sub_ind} = pre_m1;
    AllDataAcrossConds.c6preS1 {sub_ind} = pre_s1;
    AllDataAcrossConds.c6postM1{sub_ind} = post_m1;
    AllDataAcrossConds.c6postS1{sub_ind} = post_s1;
    AllDataAcrossConds.c6info{sub_ind} = titleText;
end
% group files f = 2 3 4 up next
Nfile = 'CX_nF2clean_RightHemi_VEP_121223.mat';
outDir =  'D:\AttnXV3_analysis\cleanEEG\AllCondCycleData';
matFileLoc = fullfile(outDir, Nfile);
disp 'Saving Data ...'
save(matFileLoc , 'AllDataAcrossConds' , '-v7.3') 
disp 'Data Saved!'