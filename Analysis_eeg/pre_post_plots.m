% ltp induction pre-post analysis 11/23/2023 
%% Set Directories
CleanDataDir = 'D:\version3\cleanEEG'; % preprocessed EEG Data
RCA_dir = 'D:\CODE_SCRIPTS\sweep_data_a\rcaExtra';  % RCA Extra Dir
F1_file = 'C1_nF2clean_112023.mat'; % F1 clean
SaveImgDir = 'D:\version3\plots\contrast_eeg';
%F2_file = 'nF2Clean_data.mat'; % F2 clean 
addpath(CleanDataDir); addpath(RCA_dir); cd(CleanDataDir); % add paths
%% Data + Info for epoching 
dataF1 = load(F1_file); % load file 1 - cell of subj data
F1 = dataF1.DataStore.eeg;
Sname = dataF1.DataStore.names;
Nsubs = size(dataF1.DataStore.eeg,1); % total # of subjs
[nSamps, nChans, nTrials] = size(F1{1}); % data shape / info
dims = round(sqrt(Nsubs));
Nelecs = 65:85; % list of chans to look at

for ind = 1:Nsubs
    test = F1{ind};
    pre_eeg = test(:,Nelecs,1:39);
    post_eeg = test(:,Nelecs,40:78);
    pre_erp = mean(mean(pre_eeg,2),3);
    post_erp = mean(mean(post_eeg,2),3);
    %  1  112
    % 113 224
    % 225 336
    % 337 448
    % 449 560
    pre_contrast_bins = zeros(5,112);
    post_contrast_bins = zeros(5,112);
    for i = 1:5
        pre_contrast_bins(i,:) = pre_erp(((i*112)-111):i*112);
        post_contrast_bins(i,:) = post_erp(((i*112)-111):i*112);
    end

    pre_legend_labs = {'pre contrast 1','pre contrast 2','pre contrast 3','pre contrast 4','pre contrast 5'};
    post_legend_labs = {'post contrast 1','post contrast 2','post contrast 3','post contrast 4','post contrast 5'};

    for j = 1:5
        subplot(1,5,j)
        plot(pre_contrast_bins(j,:),'DisplayName', pre_legend_labs{j} , LineWidth = 1, Color =  [0 0 0])
        hold on;
        plot(post_contrast_bins(j,:),'DisplayName', post_legend_labs{j}, LineWidth = 1, Color =  [0.1940 0.1840 0.9560])
        legend('Location','southwest'); grid;
        if j == 3
            titleString = ['3.75 Hz ERP per contrast: ',num2str(Sname(ind))];
            title(titleString)
        end
        xlabel('Frames (sr)'); ylabel('Amp (mV)');
        yMax = 3 ; yMin = -3 ;
        ylim([yMin,yMax]);
        set(gcf,'color','w'); shg;
        hold off;
    end
    Fname =  ['incContrast_F2_',num2str(Sname(ind)),'.png'];
    ImgPath = fullfile(SaveImgDir, Fname);
    saveas(gcf, ImgPath)
    close gcf;
end

% subplot(5,1,1)
% plot(pre_contrast_bins(1,:),'DisplayName', 'pre c1', LineWidth = 1, Color =  [0.4940 0.1840 0.5560])
% hold on;
% plot(pre_contrast_bins(5,:),'DisplayName', 'pre c5 ', LineWidth = 1, Color =  [0.4940 0.7840 0.5560])
% legend('Location','southwest'); grid;
% hold off
