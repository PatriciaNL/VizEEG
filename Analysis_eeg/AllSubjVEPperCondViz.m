CyclerpDir = 'D:\AttnXV3_analysis\cleanEEG\AllCondCycleData';
SaveImgDir = 'D:\AttnXV3_analysis\plots\eeg\AllSubjC3VEPs';

File = 'CX_nF2clean_RightHemi_VEP_121223.mat';
matFileLoc3 = fullfile(CyclerpDir,File);
d3 = load(matFileLoc3); % load all items to plot
i = 4; % row / new file entered
%%%%%%%%%%% all participants performance on c3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c3_pres1_d3 = d3.AllDataAcrossConds.c3preS1;
%c3_posts1_d3 = d3.AllDataAcrossConds.c3postS1;
%figure('Position', [50, 50, 1400, 700])
subplot(4,4,((i-1)*4)+1)
c3_pre = cat(1,d3.AllDataAcrossConds.c3preM1{:}); % 1 x 70 for 49 subjs
c3_pre_avg = mean(c3_pre,1);
nTrialsPre = sum(~isnan(c3_pre(:,1))); % number of trials non-nan
pre_s1 = std(c3_pre,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
pre_s1(1:3:end) = nan;
pre_s1(2:3:end) = nan;

c3_post = cat(1,d3.AllDataAcrossConds.c3postM1{:});
c3_post_avg = mean(c3_post,1);
nTrialsPost = sum(~isnan(c3_post(:,1))); % number of trials non-nan
post_s1 = std(c3_post,1,'omitnan')/sqrt(nTrialsPost); % 1 x 70
post_s1(1:3:end) = nan;
post_s1(2:3:end) = nan;

e = errorbar(c3_pre_avg, pre_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, 'DisplayName', 'Pre');
e.Color = 'black';
hold on;
e = errorbar(c3_post_avg, post_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', [0.15 0.75 0.90], 'LineWidth', 1, 'DisplayName', 'Post');
e.Color = 'blue';
hold off;

set(gcf,'color','w'); %shg;
xlabel('Frames'); ylabel('Amp (mV)');
titletxt = [File(4:11),' ', File(13:20),' ',File(22:24)];
title(titletxt,'FontSize',15)
box off;
%%%%%%%%%%% all participants performance on c4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c4_pres1_d3 = d3.AllDataAcrossConds.c4preS1;
% c4_posts1_d3 = d3.AllDataAcrossConds.c4postS1;
subplot(4,4,((i-1)*4)+2)
c4_pre = cat(1,d3.AllDataAcrossConds.c4preM1{:});  % 1 x 70 for 49 subjs
c4_pre_avg = mean(c4_pre,1);
nTrialsPre = sum(~isnan(c4_pre(:,1))); % number of trials non-nan
pre_s1 = std(c4_pre,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
pre_s1(1:3:end) = nan;
pre_s1(2:3:end) = nan;

c4_post = cat(1,d3.AllDataAcrossConds.c4postM1{:});
c4_post_avg = mean(c4_post,1);
nTrialsPost = sum(~isnan(c4_post(:,1))); % number of trials non-nan
post_s1 = std(c4_post,1,'omitnan')/sqrt(nTrialsPost); % 1 x 70
post_s1(1:3:end) = nan;
post_s1(2:3:end) = nan;

e = errorbar(c4_pre_avg, pre_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#0F620C', 'MarkerFaceColor', '#0F620C', 'LineWidth', 1, 'DisplayName', 'C4 Pre');
e.Color = '#0F620C';
hold on;
% Plot post data
e = errorbar(c4_post_avg, post_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#30EA29', 'MarkerFaceColor', '#30EA29', 'LineWidth', 1, 'DisplayName', 'C4 Post');
e.Color = '#30EA29';
hold off;
set(gcf,'color','w'); %shg;
xlabel('Frames'); ylabel('Amp (mV)');
box off;
%%%%%%%%%%% all participants performance on c4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,4,((i-1)*4)+3)
c5_pre = cat(1,d3.AllDataAcrossConds.c5preM1{:});  % 1 x 70 for 49 subjs
c5_pre_avg = mean(c5_pre,1);
nTrialsPre = sum(~isnan(c5_pre(:,1))); % number of trials non-nan
pre_s1 = std(c5_pre,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
pre_s1(1:3:end) = nan;
pre_s1(2:3:end) = nan;

c5_post = cat(1,d3.AllDataAcrossConds.c5postM1{:});
c5_post_avg = mean(c5_post,1);
nTrialsPost = sum(~isnan(c5_post(:,1))); % number of trials non-nan
post_s1 = std(c5_post,1,'omitnan')/sqrt(nTrialsPost); % 1 x 70
post_s1(1:3:end) = nan;
post_s1(2:3:end) = nan;

e = errorbar(c5_pre_avg, pre_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#4F1183', 'MarkerFaceColor', '#4F1183', 'LineWidth', 1, 'DisplayName', 'C4 Pre');
e.Color = '#4F1183';
hold on;
% Plot post data
e = errorbar(c5_post_avg, post_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#A152E4', 'MarkerFaceColor', '#A152E4', 'LineWidth', 1, 'DisplayName', 'C4 Post');
e.Color = '#A152E4';
hold off;
set(gcf,'color','w'); %shg;
xlabel('Frames'); ylabel('Amp (mV)');
box off;
%%%%%%%%%%% all participants performance on c4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c6_pres1_d3 = d3.AllDataAcrossConds.c6preS1;
% c6_posts1_d3 = d3.AllDataAcrossConds.c6postS1;
subplot(4,4,((i-1)*4)+4)

c6_pre = cat(1,d3.AllDataAcrossConds.c6preM1{:});  % 1 x 70 for 49 subjs
c6_pre_avg = mean(c6_pre,1);
nTrialsPre = sum(~isnan(c6_pre(:,1))); % number of trials non-nan
pre_s1 = std(c6_pre,1,'omitnan')/sqrt(nTrialsPre); % 1 x 70 
pre_s1(1:3:end) = nan;
pre_s1(2:3:end) = nan;

c6_post = cat(1,d3.AllDataAcrossConds.c6postM1{:});
c6_post_avg = mean(c6_post,1);
nTrialsPost = sum(~isnan(c6_post(:,1))); % number of trials non-nan
post_s1 = std(c6_post,1,'omitnan')/sqrt(nTrialsPost); % 1 x 70
post_s1(1:3:end) = nan;
post_s1(2:3:end) = nan;

e = errorbar(c6_pre_avg, pre_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#750E21', 'MarkerFaceColor', '#750E21', 'LineWidth', 1, 'DisplayName', 'C4 Pre');
e.Color = '#750E21';
hold on;
% Plot post data
e = errorbar(c6_post_avg, post_s1, '-s', 'MarkerSize', 2, 'MarkerEdgeColor', '#E8506C', 'MarkerFaceColor', '#E8506C', 'LineWidth', 1, 'DisplayName', 'C4 Post');
e.Color = '#E8506C';
hold off;
set(gcf,'color','w'); %shg;
xlabel('Frames'); ylabel('Amp (mV)');
box off;