CyclerpDir = 'D:\AttnXV3_analysis\cleanEEG\AllCondCycleData';
SaveImgDir = 'D:\AttnXV3_analysis\plots\eeg\Conds3thru6VEP';
%%%%%%%% import first data file %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileN1 = 'CX_nF1clean_LeftHemi_VEP_121223.mat';
matFileLoc1 = fullfile(CyclerpDir,FileN1);
%load all items to plot
d1 = load(matFileLoc1);
c3_prem1_d1 = d1.AllDataAcrossConds.c3preM1;
c3_pres1_d1 = d1.AllDataAcrossConds.c3preS1;
c3_postm1_d1 = d1.AllDataAcrossConds.c3postM1;
c3_posts1_d1 = d1.AllDataAcrossConds.c3postS1;

c4_prem1_d1 = d1.AllDataAcrossConds.c4preM1;
c4_pres1_d1 = d1.AllDataAcrossConds.c4preS1;
c4_postm1_d1 = d1.AllDataAcrossConds.c4postM1;
c4_posts1_d1 = d1.AllDataAcrossConds.c4postS1;

c5_prem1_d1 = d1.AllDataAcrossConds.c5preM1;
c5_pres1_d1 = d1.AllDataAcrossConds.c5preS1;
c5_postm1_d1 = d1.AllDataAcrossConds.c5postM1;
c5_posts1_d1 = d1.AllDataAcrossConds.c5postS1;

c6_prem1_d1 = d1.AllDataAcrossConds.c6preM1;
c6_pres1_d1 = d1.AllDataAcrossConds.c6preS1;
c6_postm1_d1 = d1.AllDataAcrossConds.c6postM1;
c6_posts1_d1 = d1.AllDataAcrossConds.c6postS1;
%%%%%%% import 2nd data file %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileN2 = 'CX_nF2clean_LeftHemi_VEP_121223.mat';
matFileLoc2 = fullfile(CyclerpDir,FileN2);
% load all items to plot
d2 = load(matFileLoc2);
c3_prem1_d2 = d2.AllDataAcrossConds.c3preM1;
c3_pres1_d2 = d2.AllDataAcrossConds.c3preS1;
c3_postm1_d2 = d2.AllDataAcrossConds.c3postM1;
c3_posts1_d2 = d2.AllDataAcrossConds.c3postS1;

c4_prem1_d2 = d2.AllDataAcrossConds.c4preM1;
c4_pres1_d2 = d2.AllDataAcrossConds.c4preS1;
c4_postm1_d2 = d2.AllDataAcrossConds.c4postM1;
c4_posts1_d2 = d2.AllDataAcrossConds.c4postS1;

c5_prem1_d2 = d2.AllDataAcrossConds.c5preM1;
c5_pres1_d2 = d2.AllDataAcrossConds.c5preS1;
c5_postm1_d2 = d2.AllDataAcrossConds.c5postM1;
c5_posts1_d2 = d2.AllDataAcrossConds.c5postS1;

c6_prem1_d2 = d2.AllDataAcrossConds.c6preM1;
c6_pres1_d2 = d2.AllDataAcrossConds.c6preS1;
c6_postm1_d2 = d2.AllDataAcrossConds.c6postM1;
c6_posts1_d2 = d2.AllDataAcrossConds.c6postS1;
%%%%%%%% import 3rd data file %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileN3 = 'CX_nF1clean_RightHemi_VEP_121223.mat';
matFileLoc3 = fullfile(CyclerpDir,FileN3);
% load all items to plot
d3 = load(matFileLoc3);
c3_prem1_d3 = d3.AllDataAcrossConds.c3preM1;
c3_pres1_d3 = d3.AllDataAcrossConds.c3preS1;
c3_postm1_d3 = d3.AllDataAcrossConds.c3postM1;
c3_posts1_d3 = d3.AllDataAcrossConds.c3postS1;

c4_prem1_d3 = d3.AllDataAcrossConds.c4preM1;
c4_pres1_d3 = d3.AllDataAcrossConds.c4preS1;
c4_postm1_d3 = d3.AllDataAcrossConds.c4postM1;
c4_posts1_d3 = d3.AllDataAcrossConds.c4postS1;

c5_prem1_d3 = d3.AllDataAcrossConds.c5preM1;
c5_pres1_d3 = d3.AllDataAcrossConds.c5preS1;
c5_postm1_d3 = d3.AllDataAcrossConds.c5postM1;
c5_posts1_d3 = d3.AllDataAcrossConds.c5postS1;

c6_prem1_d3 = d3.AllDataAcrossConds.c6preM1;
c6_pres1_d3 = d3.AllDataAcrossConds.c6preS1;
c6_postm1_d3 = d3.AllDataAcrossConds.c6postM1;
c6_posts1_d3 = d3.AllDataAcrossConds.c6postS1;
%%%%%%%% import 4th data file %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileN4 = 'CX_nF2clean_RightHemi_VEP_121223.mat';
matFileLoc4 = fullfile(CyclerpDir,FileN4);
% load all items to plot
d4 = load(matFileLoc4);
c3_prem1_d4 = d4.AllDataAcrossConds.c3preM1;
c3_pres1_d4 = d4.AllDataAcrossConds.c3preS1;
c3_postm1_d4 = d4.AllDataAcrossConds.c3postM1;
c3_posts1_d4 = d4.AllDataAcrossConds.c3postS1;

c4_prem1_d4 = d4.AllDataAcrossConds.c4preM1;
c4_pres1_d4 = d4.AllDataAcrossConds.c4preS1;
c4_postm1_d4 = d4.AllDataAcrossConds.c4postM1;
c4_posts1_d4 = d4.AllDataAcrossConds.c4postS1;

c5_prem1_d4 = d4.AllDataAcrossConds.c5preM1;
c5_pres1_d4 = d4.AllDataAcrossConds.c5preS1;
c5_postm1_d4 = d4.AllDataAcrossConds.c5postM1;
c5_posts1_d4 = d4.AllDataAcrossConds.c5postS1;

c6_prem1_d4 = d4.AllDataAcrossConds.c6preM1;
c6_pres1_d4 = d4.AllDataAcrossConds.c6preS1;
c6_postm1_d4 = d4.AllDataAcrossConds.c6postM1;
c6_posts1_d4 = d4.AllDataAcrossConds.c6postS1;
%% load info to add legends
c3_info = d4.AllDataAcrossConds.c3info;
plt_info = c3_info;
% c4_info = d.AllDataAcrossConds.c4info;
% c5_info = d.AllDataAcrossConds.c5info;
% c6_info = d.AllDataAcrossConds.c6info;
%% set some params 
nSubs = size(c3_prem1_d1,2);
NumSamps = size(c3_prem1_d1{1},2); % jic or ele rmv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% plot data based for all conditions %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:nSubs
    figure('Position', [50, 50, 1400, 700])
    %subplot(1,4,1)
    %%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c3
    subplot(4,4,1)
    %% set custom ranges for each plot row
    ylimDeter1 = zeros(8,70);
    ylimDeter1(1,:) = c3_prem1_d1{1};
    ylimDeter1(2,:) = c3_postm1_d1{i};
    ylimDeter1(3,:) = c4_prem1_d1{i};
    ylimDeter1(4,:) = c4_postm1_d1{i};
    ylimDeter1(5,:) = c5_prem1_d1{i};
    ylimDeter1(6,:) = c5_postm1_d1{i};
    ylimDeter1(7,:) = c6_prem1_d1{i};
    ylimDeter1(8,:) = c6_postm1_d1{i};

    yMaxLim1 = floor(max(ylimDeter1, [], 'all')) + 1; 
    yMinLim1 = floor(min(ylimDeter1, [], 'all')) - 1;

    e = errorbar(c3_prem1_d1{i}, c3_pres1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#13187D', 'MarkerFaceColor', '#13187D', 'LineWidth', 1/2, 'DisplayName', 'C3 Pre');
    e.Color = '#13187D';
    hold on;
    % Plot post data
    e = errorbar(c3_postm1_d1{i}, c3_posts1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4553F4', 'MarkerFaceColor', '#4553F4', 'LineWidth', 1/2, 'DisplayName', 'C3 Post');
    e.Color = '#4553F4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); %shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim1,yMaxLim1]);
    titletxt = FileN1(3:24);%plt_info{i}(5:47);
    title(titletxt,'FontSize',15)
    box off;
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c4
    subplot(4,4,2)
    e = errorbar(c4_prem1_d1{i}, c4_pres1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#0F620C', 'MarkerFaceColor', '#0F620C', 'LineWidth', 1/2, 'DisplayName', 'C4 Pre');
    e.Color = '#0F620C';
    hold on;
    % Plot post data
    e = errorbar(c4_postm1_d1{i}, c4_posts1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#30EA29', 'MarkerFaceColor', '#30EA29', 'LineWidth', 1/2, 'DisplayName', 'C4 Post');
    e.Color = '#30EA29';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); %shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim1,yMaxLim1]);
    %title(titletxt,'FontSize',15)
    box off;
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c5
    subplot(4,4,3)
    e = errorbar(c5_prem1_d1{i}, c5_pres1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4F1183', 'MarkerFaceColor', '#4F1183', 'LineWidth', 1/2, 'DisplayName', 'C5 Pre');
    e.Color = '#4F1183';
    hold on;
    % Plot post data
    e = errorbar(c5_postm1_d1{i}, c5_posts1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#A152E4', 'MarkerFaceColor', '#A152E4', 'LineWidth', 1/2, 'DisplayName', 'C5 Post');
    e.Color = '#A152E4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim1,yMaxLim1]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c6
    subplot(4,4,4)
    e = errorbar(c6_prem1_d1{i}, c6_pres1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#750E21', 'MarkerFaceColor', '#750E21', 'LineWidth', 1/2, 'DisplayName', 'C6 Pre');
    e.Color = '#750E21';
    hold on;
    % Plot post data
    e = errorbar(c6_postm1_d1{i}, c6_posts1_d1{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#E8506C', 'MarkerFaceColor', '#E8506C', 'LineWidth', 1/2, 'DisplayName', 'C6 Post');
    e.Color = '#E8506C';
    % set params for plotting nicely
    %legend('Location','northwest','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim1,yMaxLim1]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %hold off

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% New Plot                           %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    ylimDeter2 = zeros(8,56);
    ylimDeter2(1,:) = c3_prem1_d2{1};
    ylimDeter2(2,:) = c3_postm1_d2{i};
    ylimDeter2(3,:) = c4_prem1_d2{i};
    ylimDeter2(4,:) = c4_postm1_d2{i};
    ylimDeter2(5,:) = c5_prem1_d2{i};
    ylimDeter2(6,:) = c5_postm1_d2{i};
    ylimDeter2(7,:) = c6_prem1_d2{i};
    ylimDeter2(8,:) = c6_postm1_d2{i};

    yMaxLim2 = floor(max(ylimDeter2, [], 'all')) + 1; 
    yMinLim2 = floor(min(ylimDeter2, [], 'all')) - 1;

    %subplot(1,4,2)
    subplot(4,4,5)
    e = errorbar(c3_prem1_d2{i}, c3_pres1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#13187D', 'MarkerFaceColor', '#13187D', 'LineWidth', 1/2, 'DisplayName', 'C3 Pre');
    e.Color = '#13187D';
    hold on;
    % Plot post data
    e = errorbar(c3_postm1_d2{i}, c3_posts1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4553F4', 'MarkerFaceColor', '#4553F4', 'LineWidth', 1/2, 'DisplayName', 'C3 Post');
    e.Color = '#4553F4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim2,yMaxLim2]);
    titletxt = FileN2(3:24);%plt_info{i}(5:47);
    title(titletxt,'FontSize',15)
    box off;
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c4
    subplot(4,4,6)
    e = errorbar(c4_prem1_d2{i}, c4_pres1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#0F620C', 'MarkerFaceColor', '#0F620C', 'LineWidth', 1/2, 'DisplayName', 'C4 Pre');
    e.Color = '#0F620C';
    hold on;
    % Plot post data
    e = errorbar(c4_postm1_d2{i}, c4_posts1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#30EA29', 'MarkerFaceColor', '#30EA29', 'LineWidth', 1/2, 'DisplayName', 'C4 Post');
    e.Color = '#30EA29';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim2,yMaxLim2]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c5
    subplot(4,4,7)
    e = errorbar(c5_prem1_d2{i}, c5_pres1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4F1183', 'MarkerFaceColor', '#4F1183', 'LineWidth', 1/2, 'DisplayName', 'C5 Pre');
    e.Color = '#4F1183';
    hold on;
    % Plot post data
    e = errorbar(c5_postm1_d2{i}, c5_posts1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#A152E4', 'MarkerFaceColor', '#A152E4', 'LineWidth', 1/2, 'DisplayName', 'C5 Post');
    e.Color = '#A152E4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim2,yMaxLim2]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c6
    subplot(4,4,8)
    e = errorbar(c6_prem1_d2{i}, c6_pres1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#750E21', 'MarkerFaceColor', '#750E21', 'LineWidth', 1/2, 'DisplayName', 'C6 Pre');
    e.Color = '#750E21';
    hold on;
    % Plot post data
    e = errorbar(c6_postm1_d2{i}, c6_posts1_d2{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#E8506C', 'MarkerFaceColor', '#E8506C', 'LineWidth', 1/2, 'DisplayName', 'C6 Post');
    e.Color = '#E8506C';
    % set params for plotting nicely
    %legend('Location','northwest','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim2,yMaxLim2]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% New Plot                           %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

    ylimDeter3 = zeros(8,70);
    ylimDeter3(1,:) = c3_prem1_d3{1};
    ylimDeter3(2,:) = c3_postm1_d3{i};
    ylimDeter3(3,:) = c4_prem1_d3{i};
    ylimDeter3(4,:) = c4_postm1_d3{i};
    ylimDeter3(5,:) = c5_prem1_d3{i};
    ylimDeter3(6,:) = c5_postm1_d3{i};
    ylimDeter3(7,:) = c6_prem1_d3{i};
    ylimDeter3(8,:) = c6_postm1_d3{i};

    yMaxLim3 = floor(max(ylimDeter3, [], 'all')) + 1; 
    yMinLim3 = floor(min(ylimDeter3, [], 'all')) - 1;

    %subplot(1,4,3)
    subplot(4,4,9)
    e = errorbar(c3_prem1_d3{i}, c3_pres1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#13187D', 'MarkerFaceColor', '#13187D', 'LineWidth', 1/2, 'DisplayName', 'C3 Pre');
    e.Color = '#13187D';
    hold on;
    % Plot post data
    e = errorbar(c3_postm1_d3{i}, c3_posts1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4553F4', 'MarkerFaceColor', '#4553F4', 'LineWidth', 1/2, 'DisplayName', 'C3 Post');
    e.Color = '#4553F4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim3,yMaxLim3]);
    titletxt = FileN3(3:24);%plt_info{i}(5:47);
    title(titletxt,'FontSize',15)
    box off;
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c4
    subplot(4,4,10)
    e = errorbar(c4_prem1_d3{i}, c4_pres1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#0F620C', 'MarkerFaceColor', '#0F620C', 'LineWidth', 1/2, 'DisplayName', 'C4 Pre');
    e.Color = '#0F620C';
    hold on;
    % Plot post data
    e = errorbar(c4_postm1_d3{i}, c4_posts1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#30EA29', 'MarkerFaceColor', '#30EA29', 'LineWidth', 1/2, 'DisplayName', 'C4 Post');
    e.Color = '#30EA29';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim3,yMaxLim3]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c5
    subplot(4,4,11)
    e = errorbar(c5_prem1_d3{i}, c5_pres1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4F1183', 'MarkerFaceColor', '#4F1183', 'LineWidth', 1/2, 'DisplayName', 'C5 Pre');
    e.Color = '#4F1183';
    hold on;
    % Plot post data
    e = errorbar(c5_postm1_d3{i}, c5_posts1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#A152E4', 'MarkerFaceColor', '#A152E4', 'LineWidth', 1/2, 'DisplayName', 'C5 Post');
    e.Color = '#A152E4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim3,yMaxLim3]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c6
    subplot(4,4,12)
    e = errorbar(c6_prem1_d3{i}, c6_pres1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#750E21', 'MarkerFaceColor', '#750E21', 'LineWidth', 1/2, 'DisplayName', 'C6 Pre');
    e.Color = '#750E21';
    hold on;
    % Plot post data
    e = errorbar(c6_postm1_d3{i}, c6_posts1_d3{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#E8506C', 'MarkerFaceColor', '#E8506C', 'LineWidth', 1/2, 'DisplayName', 'C6 Post');
    e.Color = '#E8506C';
    % set params for plotting nicely
    %legend('Location','northwest','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim3,yMaxLim3]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    hold off
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% New Plot                           %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    ylimDeter4 = zeros(8,56);
    ylimDeter4(1,:) = c3_prem1_d4{1};
    ylimDeter4(2,:) = c3_postm1_d4{i};
    ylimDeter4(3,:) = c4_prem1_d4{i};
    ylimDeter4(4,:) = c4_postm1_d4{i};
    ylimDeter4(5,:) = c5_prem1_d4{i};
    ylimDeter4(6,:) = c5_postm1_d4{i};
    ylimDeter4(7,:) = c6_prem1_d4{i};
    ylimDeter4(8,:) = c6_postm1_d4{i};

    yMaxLim4 = floor(max(ylimDeter4, [], 'all')) + 1; 
    yMinLim4 = floor(min(ylimDeter4, [], 'all')) - 1;

    %subplot(1,4,4)
    subplot(4,4,13)
    e = errorbar(c3_prem1_d4{i}, c3_pres1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#13187D', 'MarkerFaceColor', '#13187D', 'LineWidth', 1/2, 'DisplayName', 'C3 Pre');
    e.Color = '#13187D';
    hold on;
    % Plot post data
    e = errorbar(c3_postm1_d4{i}, c3_posts1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4553F4', 'MarkerFaceColor', '#4553F4', 'LineWidth', 1/2, 'DisplayName', 'C3 Post');
    e.Color = '#4553F4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim4,yMaxLim4]);
    titletxt = FileN4(3:24);%plt_info{i}(5:47);
    title(titletxt, 'FontSize',15)
    box off;
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c4
    subplot(4,4,14)
    e = errorbar(c4_prem1_d4{i}, c4_pres1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#0F620C', 'MarkerFaceColor', '#0F620C', 'LineWidth', 1/2, 'DisplayName', 'C4 Pre');
    e.Color = '#0F620C';
    hold on;
    % Plot post data
    e = errorbar(c4_postm1_d4{i}, c4_posts1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#30EA29', 'MarkerFaceColor', '#30EA29', 'LineWidth', 1/2, 'DisplayName', 'C4 Post');
    e.Color = '#30EA29';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim4,yMaxLim4]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c5
    subplot(4,4,15)
    e = errorbar(c5_prem1_d4{i}, c5_pres1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#4F1183', 'MarkerFaceColor', '#4F1183', 'LineWidth', 1/2, 'DisplayName', 'C5 Pre');
    e.Color = '#4F1183';
    hold on;
    % Plot post data
    e = errorbar(c5_postm1_d4{i}, c5_posts1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#A152E4', 'MarkerFaceColor', '#A152E4', 'LineWidth', 1/2, 'DisplayName', 'C5 Post');
    e.Color = '#A152E4';
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim4,yMaxLim4]);
    box off;
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    %%%%%%%%%%%%%%%%%%%%%%%%%% plot pre and post for c6
    subplot(4,4,16)
    e = errorbar(c6_prem1_d4{i}, c6_pres1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#750E21', 'MarkerFaceColor', '#750E21', 'LineWidth', 1/2, 'DisplayName', 'C6 Pre');
    e.Color = '#750E21';
    hold on;
    % Plot post data
    e = errorbar(c6_postm1_d4{i}, c6_posts1_d4{i}, '-s', 'MarkerSize', 5, 'MarkerEdgeColor', '#E8506C', 'MarkerFaceColor', '#E8506C', 'LineWidth', 1/2, 'DisplayName', 'C6 Post');
    e.Color = '#E8506C';
    ylim([yMinLim4,yMaxLim4]);
    % set params for plotting nicely
    %legend('Location','northeast','FontAngle','italic','FontSize',6);grid;
    set(gcf,'color','w'); shg;
    xlabel('Frames'); ylabel('Amp (mV)');
    ylim([yMinLim4,yMaxLim4]);
    % titletxt = plt_info{i}(35:50);
    % title(titletxt)
    box off;
    hold off
    titletxt = plt_info{i}(35:50);
    fullttltxt = ['VEP Responses Across Increasing Contasts: ', titletxt];
    sgt = sgtitle(fullttltxt,'Color', 'Black');
    sgt.FontSize = 20;
    Fname =  ['VEPof_',titletxt,'.png'];
    ImgPath = fullfile(SaveImgDir, Fname);
    %saveas(gcf, ImgPath,'.png')
    exportgraphics(gcf, ImgPath, 'Resolution', 200);
    close gcf;
end

