function databc = baselinecorrect_3D_data(data, baselinesamps)
    % Corrects for baseline offset in evoked potentials for 3D data
    % INPUT: data is the 3D data (time * channels * trials)
    %        baselinesamps is the indices of baseline samples
    % OUTPUT: databc baseline corrected 3D data
    % Automatically calculates the mean of the baseline interval
    % and then removes it from the timeseries for each channel and trial
    
    [ntime, nchannels, ntrials] = size(data);
    databc = zeros(ntime, nchannels, ntrials);
    
    % Calculate baseline mean for each channel and trial
    for trial = 1:ntrials
        for channel = 1:nchannels
            base = mean(data(baselinesamps, channel, trial), 'omitnan');
            databc(:, channel, trial) = data(:, channel, trial) - base;
        end
    end
end