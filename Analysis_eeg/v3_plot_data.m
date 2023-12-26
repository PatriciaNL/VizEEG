%% Set Directories
CleanDataDir = 'D:\version3\cleanEEG'; % preprocessed EEG Data
RCA_dir = 'D:\CODE_SCRIPTS\sweep_data_a\rcaExtra';  % RCA Extra Dir
F1_file = 'C1_nF1cleanV3_111123.mat'; % F1 clean 
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
%% plot entire trial series
mini_Nsubs = 7;
mini_data = F1(38:44);
Sname = Sname(38:44);
mini_dims = round(sqrt(mini_Nsubs))+ 2;
%for subs = 1:Nsubs
    %data = F1{subs};  
for subs = 1:mini_Nsubs
    data = mini_data{subs}; 
    pre = squeeze(mean(data(:,Nelecs,1:39),3, 'omitnan')); % 560 x 128
    post = squeeze(mean(data(:,Nelecs,40:78),3, 'omitnan'));
    pre1 = squeeze(mean(pre,2));
    post1 = squeeze(mean(post,2));
    subplot(mini_dims,2,subs)
    %subplot(dims,dims,subs)
    %plot(pre1(420:end), 'DisplayName', 'pre', LineWidth=2)
    plot(pre1, 'DisplayName', 'pre', LineWidth = 2, Color =  [0, 0, 0])
    legend('Location','southwest');
    hold on;
    %plot(post1(420:end), 'DisplayName','post', LineWidth=2)
    plot(post1, 'DisplayName','post', LineWidth = 2, Color = [0.3, 0.4, 1])
    grid;
    hold off;
    titleString = ['3 hz',num2str(Sname(subs))];
    title(titleString)
end 
% plot data correponding to bin intervals
%560/420 = 1.33 seconds per trial
%5 contrasts, 560/5 = 112 - 26.77 s

%% plot per contrast 

contrasts = 5;
for i = 1:contrasts
    figure;
    c_ind = (112*i) - 111;
    c_end = 112*i;
    for subs = 1:Nsubs
        data = F1{subs};
        pre = squeeze(mean(data(c_ind:c_end,Nelecs,1:39),3, 'omitnan')); % 560 x 128
        post = squeeze(mean(data(c_ind:c_end,Nelecs,40:78),3, 'omitnan'));
        pre1 = squeeze(mean(pre,2));
        post1 = squeeze(mean(post,2));
        subplot(dims,dims,subs)
        plot(pre1, 'DisplayName', 'pre', LineWidth=2)
        legend('Location','southwest');
        legend('FontSize', 3);
        hold on;
        plot(post1, 'DisplayName','post', LineWidth=2)
        grid;
        hold off;
        titleString = [num2str(Sname(subs))];
        title(titleString)
    end 
end 

% plot mean of each contrasts - save in an array and then plot into one
d_points_pre = zeros(1,contrasts);
d_points_post = zeros(1,contrasts);
%testL = F1{22};
%testR = F1{23};

t_s = [1,40];
t_e = [39,78];

figure;
for cond = 1:2
    for i = 1:contrasts
        c_ind = (112*i) - 111;
        c_end = 112*i;
        eeg_data = F1{23}; % 560 128 78
        avg2 = mean(eeg_data(c_ind:c_end,Nelecs,t_s(cond):t_e(cond)),2,'omitnan');%112 1 78
        avg1 = mean(avg2,3);% 112 1 
        avg = mean(avg1,1); % 1 1

        if cond == 1
            d_points_pre(i) = avg;
        else
            d_points_post(i) = avg;
        end
    end 
end

plot(d_points_pre, 'DisplayName', 'pre', LineWidth=2)
hold on;
plot(d_points_post, 'DisplayName', 'post', LineWidth=2)
grid; legend('Location','southwest');
hold off;

%% plot bin average for all eeg data - not the best plotting method :/
d_points_pre = zeros(1,contrasts);
d_points_post = zeros(1,contrasts);

t_s = [1,40];
t_e = [39,78];

for subs = 1:Nsubs %Sname(subs)
    for cond = 1:2
        for i = 1:contrasts
            c_ind = (112*i) - 111;
            c_end = 112*i;
            eeg_data = F1{subs}; % 560 128 78
            avg2 = mean(eeg_data(c_ind:c_end,Nelecs,t_s(cond):t_e(cond)),2,'omitnan');%112 1 78
            avg1 = mean(avg2,3);% 112 1
            avg = mean(avg1,1); % 1 1

            if cond == 1
                d_points_pre(i) = avg;
            else
                d_points_post(i) = avg;
            end
            subplot(dims,dims,subs)
            plot(d_points_pre, 'DisplayName', 'pre', LineWidth=2)
            hold on;
            plot(d_points_post, 'DisplayName', 'post', LineWidth=2)
            titleString = [num2str(Sname(subs))];
            title(titleString)
            grid; legend('Location','southwest');
            legend('FontSize', 4);
            hold off;
        end
    end
end