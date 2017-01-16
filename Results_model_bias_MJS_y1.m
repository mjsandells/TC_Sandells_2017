% code to calculate model bias for Model Farm paper
% Table 6, year 1
% nick.rutter@northumbria.ac.uk
% 5 May 2016

% % load 2011-12 data which create Fig 5
load('memlssortedresults_y1.mat');
load('memlsobs_y1.mat');
load('hutsortedresults_y1.mat');
load('hutobs_y1.mat');
load('dmrtsortedresults_y1.mat');
load('dmrtobs_y1.mat');

% load('C:\Nick\Mel\Fig5_y1_new\memlssortedresults_y1.mat');
% load('C:\Nick\Mel\Fig5_y1_new\memlsobs_y1.mat');
% load('C:\Nick\Mel\Fig5_y1_new\hutsortedresults_y1.mat');
% load('C:\Nick\Mel\Fig5_y1_new\hutobs_y1.mat');
% load('C:\Nick\Mel\Fig5_y1_new\dmrtsortedresults_y1.mat');
% load('C:\Nick\Mel\Fig5_y1_new\dmrtobs_y1.mat');
%% Create a serial date from the observation file
date = int2str(memlsobs(:,1));
[a b] = size(date);
SerialDate = [];
for i=1:a;
    year = str2num(date(i,1:4));
    month = str2num(date(i,5:6));
    day = str2num(date(i,7:8));
    dummy = datenum(year, month, day);
    SerialDate = cat(1, SerialDate, dummy);
end
%%
data = cat(2,SerialDate,...
            memlsobs(:,2:5),...
            hutsortedresults(:,6), hutsortedresults(:,11), hutsortedresults(:,16), hutsortedresults(:,21),...
            memlssortedresults(:,6), memlssortedresults(:,11), memlssortedresults(:,16), memlssortedresults(:,21),...
            dmrtsortedresults(:,6), dmrtsortedresults(:,11), dmrtsortedresults(:,16), dmrtsortedresults(:,21));

 % creates a data set whch removes dates where there is an NaN in any of the four observations (19V, 19H, 37V, 37H)       
data_noNaNs = data;
for i=1:4
data_noNaNs = data_noNaNs(~isnan(data_noNaNs(:,i+1)),:); % for 1:4 for i+1 loops through four observations columns (2:5)
end

% if we want to subset by serial dates, subset data_noNaNs here
%date_1Feb12 = datenum('1-feb-12','dd-mmm-yy');
%date_1Apr12 = datenum('1-apr-12','dd-mmm-yy');

bias_19V_hut = nanmean((data_noNaNs(:,6) - data_noNaNs(:,2)),1);
bias_19H_hut = nanmean((data_noNaNs(:,7) - data_noNaNs(:,3)),1);
bias_37V_hut = nanmean((data_noNaNs(:,8) - data_noNaNs(:,4)),1);
bias_37H_hut = nanmean((data_noNaNs(:,9) - data_noNaNs(:,5)),1);
dummy1 = cat(2, bias_19V_hut, bias_19H_hut, bias_37V_hut, bias_37H_hut);

bias_19V_memls = nanmean((data_noNaNs(:,10) - data_noNaNs(:,2)),1);
bias_19H_memls = nanmean((data_noNaNs(:,11) - data_noNaNs(:,3)),1);
bias_37V_memls = nanmean((data_noNaNs(:,12) - data_noNaNs(:,4)),1);
bias_37H_memls = nanmean((data_noNaNs(:,13) - data_noNaNs(:,5)),1);
dummy2 = cat(2, bias_19V_memls, bias_19H_memls, bias_37V_memls, bias_37H_memls);

bias_19V_dmrt = nanmean((data_noNaNs(:,14) - data_noNaNs(:,2)),1);
bias_19H_dmrt = nanmean((data_noNaNs(:,15) - data_noNaNs(:,3)),1);
bias_37V_dmrt = nanmean((data_noNaNs(:,16) - data_noNaNs(:,4)),1);
bias_37H_dmrt = nanmean((data_noNaNs(:,17) - data_noNaNs(:,5)),1);
dummy3 = cat(2, bias_19V_dmrt, bias_19H_dmrt, bias_37V_dmrt, bias_37H_dmrt);

bias_all = cat(1, dummy1, dummy2, dummy3);  

%%
rmse_19V_hut = rmse(data_noNaNs(:,6),data_noNaNs(:,2));
rmse_19H_hut = rmse(data_noNaNs(:,7), data_noNaNs(:,3));
rmse_37V_hut = rmse(data_noNaNs(:,8), data_noNaNs(:,4));
rmse_37H_hut = rmse(data_noNaNs(:,9), data_noNaNs(:,5));
dummy1 = cat(2, rmse_19V_hut, rmse_19H_hut, rmse_37V_hut, rmse_37H_hut);

rmse_19V_memls = rmse(data_noNaNs(:,10), data_noNaNs(:,2));
rmse_19H_memls = rmse(data_noNaNs(:,11), data_noNaNs(:,3));
rmse_37V_memls = rmse(data_noNaNs(:,12), data_noNaNs(:,4));
rmse_37H_memls = rmse(data_noNaNs(:,13), data_noNaNs(:,5));
dummy2 = cat(2, rmse_19V_memls, rmse_19H_memls, rmse_37V_memls, rmse_37H_memls);

rmse_19V_dmrt = rmse(data_noNaNs(:,14), data_noNaNs(:,2));
rmse_19H_dmrt = rmse(data_noNaNs(:,15), data_noNaNs(:,3));
rmse_37V_dmrt = rmse(data_noNaNs(:,16), data_noNaNs(:,4));
rmse_37H_dmrt = rmse(data_noNaNs(:,17), data_noNaNs(:,5));
dummy3 = cat(2, rmse_19V_dmrt, rmse_19H_dmrt, rmse_37V_dmrt, rmse_37H_dmrt);

rmse_all = cat(1, dummy1, dummy2, dummy3);
