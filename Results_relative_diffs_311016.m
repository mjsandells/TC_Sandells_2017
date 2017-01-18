% code to produce relative differences for Model Farm paper
% nick.rutter@northumbria.ac.uk
% 31 October 2016

% load 2011-12 data which create Fig 5
load('U:\Mel\newresultsfornick_311016\memlssortedresults_y1.mat');
load('U:\Mel\newresultsfornick_311016\memlsobs_y1.mat');
load('U:\Mel\newresultsfornick_311016\hutsortedresults_y1.mat');
load('U:\Mel\newresultsfornick_311016\hutobs_y1.mat');
load('U:\Mel\newresultsfornick_311016\dmrtsortedresults_y1.mat');
load('U:\Mel\newresultsfornick_311016\dmrtobs_y1.mat');
%%
% Quickly comapre observation files  - they should be the same, and the sum of the differences should be zero
dmrtobs_memlsobs_diffs = dmrtobs(:, 2:5) - memlsobs(:, 2:5);
dmrtobs_memlsobs_diffs_sum = nansum(dmrtobs_memlsobs_diffs,1);

dmrtobs_hutobs_diffs = dmrtobs(:, 2:5) - hutobs(:, 2:5);
dmrtobs_hutobs_diffs_sum = nansum(dmrtobs_hutobs_diffs,1);

%%
%Calculate mean Tb ranges from emission models
dmrt19V_range_mean = nanmean((dmrtsortedresults(:,3) - dmrtsortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
dmrt19H_range_mean = nanmean((dmrtsortedresults(:,8) - dmrtsortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
dmrt37V_range_mean = nanmean((dmrtsortedresults(:,13) - dmrtsortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
dmrt37H_range_mean = nanmean((dmrtsortedresults(:,18) - dmrtsortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

memls19V_range_mean = nanmean((memlssortedresults(:,3) - memlssortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
memls19H_range_mean = nanmean((memlssortedresults(:,8) - memlssortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
memls37V_range_mean = nanmean((memlssortedresults(:,13) - memlssortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
memls37H_range_mean = nanmean((memlssortedresults(:,18) - memlssortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

hut19V_range_mean = nanmean((hutsortedresults(:,3) - hutsortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
hut19H_range_mean = nanmean((hutsortedresults(:,8) - hutsortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
hut37V_range_mean = nanmean((hutsortedresults(:,13) - hutsortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
hut37H_range_mean = nanmean((hutsortedresults(:,18) - hutsortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

% Ratios of mean ranges between emission models
ratio_dmrt19V_range_mean_hut19V_range_mean = dmrt19V_range_mean ./ hut19V_range_mean;
ratio_dmrt19H_range_mean_hut19H_range_mean = dmrt19H_range_mean ./ hut19H_range_mean;
ratio_dmrt37V_range_mean_hut37V_range_mean = dmrt37V_range_mean ./ hut37V_range_mean;
ratio_dmrt37H_range_mean_hut37H_range_mean = dmrt37H_range_mean ./ hut37H_range_mean;
dummy1 = cat(2,ratio_dmrt19V_range_mean_hut19V_range_mean, ratio_dmrt19H_range_mean_hut19H_range_mean, ratio_dmrt37V_range_mean_hut37V_range_mean, ratio_dmrt37H_range_mean_hut37H_range_mean);

ratio_memls19V_range_mean_hut19V_range_mean = memls19V_range_mean ./ hut19V_range_mean;
ratio_memls19H_range_mean_hut19H_range_mean = memls19H_range_mean ./ hut19H_range_mean;
ratio_memls37V_range_mean_hut37V_range_mean = memls37V_range_mean ./ hut37V_range_mean;
ratio_memls37H_range_mean_hut37H_range_mean = memls37H_range_mean ./ hut37H_range_mean;
dummy2 = cat(2,ratio_memls19V_range_mean_hut19V_range_mean, ratio_memls19H_range_mean_hut19H_range_mean, ratio_memls37V_range_mean_hut37V_range_mean, ratio_memls37H_range_mean_hut37H_range_mean);

ratio_memls19V_range_mean_dmrt19V_range_mean = memls19V_range_mean ./ dmrt19V_range_mean;
ratio_memls19H_range_mean_dmrt19H_range_mean = memls19H_range_mean ./ dmrt19H_range_mean;
ratio_memls37V_range_mean_dmrt37V_range_mean = memls37V_range_mean ./ dmrt37V_range_mean;
ratio_memls37H_range_mean_dmrt37H_range_mean = memls37H_range_mean ./ dmrt37H_range_mean;
dummy3 = cat(2,ratio_memls19V_range_mean_dmrt19V_range_mean, ratio_memls19H_range_mean_dmrt19H_range_mean, ratio_memls37V_range_mean_dmrt37V_range_mean, ratio_memls37H_range_mean_dmrt37H_range_mean);

ratios_mean_ranges_all = cat(1, dummy1, dummy2, dummy3);
%%
clear all;
%%
% load 2012-13 data which create Fig 5
load('U:\Mel\newresultsfornick_311016\memlssortedresults_y2.mat');
load('U:\Mel\newresultsfornick_311016\memlsobs_y2.mat');
load('U:\Mel\newresultsfornick_311016\hutsortedresults_y2.mat');
load('U:\Mel\newresultsfornick_311016\hutobs_y2.mat');
load('U:\Mel\newresultsfornick_311016\dmrtsortedresults_y2.mat');
load('U:\Mel\newresultsfornick_311016\dmrtobs_y2.mat');
%%
% Quickly comapre observation files  - they should be the same, and the sum of the differences should be zero
dmrtobs_memlsobs_diffs = dmrtobs(:, 2:5) - memlsobs(:, 2:5);
dmrtobs_memlsobs_diffs_sum = nansum(dmrtobs_memlsobs_diffs,1);

dmrtobs_hutobs_diffs = dmrtobs(:, 2:5) - hutobs(:, 2:5);
dmrtobs_hutobs_diffs_sum = nansum(dmrtobs_hutobs_diffs,1);

%%
%Calculate mean Tb ranges from emission models
dmrt19V_range_mean = nanmean((dmrtsortedresults(:,3) - dmrtsortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
dmrt19H_range_mean = nanmean((dmrtsortedresults(:,8) - dmrtsortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
dmrt37V_range_mean = nanmean((dmrtsortedresults(:,13) - dmrtsortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
dmrt37H_range_mean = nanmean((dmrtsortedresults(:,18) - dmrtsortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

memls19V_range_mean = nanmean((memlssortedresults(:,3) - memlssortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
memls19H_range_mean = nanmean((memlssortedresults(:,8) - memlssortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
memls37V_range_mean = nanmean((memlssortedresults(:,13) - memlssortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
memls37H_range_mean = nanmean((memlssortedresults(:,18) - memlssortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

hut19V_range_mean = nanmean((hutsortedresults(:,3) - hutsortedresults(:,2)), 1); %subtract min Tb from max Tb and the find mean
hut19H_range_mean = nanmean((hutsortedresults(:,8) - hutsortedresults(:,7)), 1); %subtract min Tb from max Tb and the find mean
hut37V_range_mean = nanmean((hutsortedresults(:,13) - hutsortedresults(:,12)), 1); %subtract min Tb from max Tb and the find mean
hut37H_range_mean = nanmean((hutsortedresults(:,18) - hutsortedresults(:,17)), 1); %subtract min Tb from max Tb and the find mean

% Ratios of mean ranges between emission models
ratio_dmrt19V_range_mean_hut19V_range_mean = dmrt19V_range_mean ./ hut19V_range_mean;
ratio_dmrt19H_range_mean_hut19H_range_mean = dmrt19H_range_mean ./ hut19H_range_mean;
ratio_dmrt37V_range_mean_hut37V_range_mean = dmrt37V_range_mean ./ hut37V_range_mean;
ratio_dmrt37H_range_mean_hut37H_range_mean = dmrt37H_range_mean ./ hut37H_range_mean;
dummy1 = cat(2,ratio_dmrt19V_range_mean_hut19V_range_mean, ratio_dmrt19H_range_mean_hut19H_range_mean, ratio_dmrt37V_range_mean_hut37V_range_mean, ratio_dmrt37H_range_mean_hut37H_range_mean);

ratio_memls19V_range_mean_hut19V_range_mean = memls19V_range_mean ./ hut19V_range_mean;
ratio_memls19H_range_mean_hut19H_range_mean = memls19H_range_mean ./ hut19H_range_mean;
ratio_memls37V_range_mean_hut37V_range_mean = memls37V_range_mean ./ hut37V_range_mean;
ratio_memls37H_range_mean_hut37H_range_mean = memls37H_range_mean ./ hut37H_range_mean;
dummy2 = cat(2,ratio_memls19V_range_mean_hut19V_range_mean, ratio_memls19H_range_mean_hut19H_range_mean, ratio_memls37V_range_mean_hut37V_range_mean, ratio_memls37H_range_mean_hut37H_range_mean);

ratio_memls19V_range_mean_dmrt19V_range_mean = memls19V_range_mean ./ dmrt19V_range_mean;
ratio_memls19H_range_mean_dmrt19H_range_mean = memls19H_range_mean ./ dmrt19H_range_mean;
ratio_memls37V_range_mean_dmrt37V_range_mean = memls37V_range_mean ./ dmrt37V_range_mean;
ratio_memls37H_range_mean_dmrt37H_range_mean = memls37H_range_mean ./ dmrt37H_range_mean;
dummy3 = cat(2,ratio_memls19V_range_mean_dmrt19V_range_mean, ratio_memls19H_range_mean_dmrt19H_range_mean, ratio_memls37V_range_mean_dmrt37V_range_mean, ratio_memls37H_range_mean_dmrt37H_range_mean);

ratios_mean_ranges_all = cat(1, dummy1, dummy2, dummy3);
