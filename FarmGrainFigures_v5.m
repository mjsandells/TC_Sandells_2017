% code to produce Sodankyla grain size figures for Model Farm paper
% nick.rutter@northumbria.ac.uk
% 14 April 2016

% Info about FMI pitdata from Leena:
%
% Units:
% t - degree C
% d - g/cm3
% h – cm
% swe – kg/m2
% grain size - mm 
% 
% Grain size is estimated visually from macro-photographs (largest extent of an average grain) for every layer. 
% For the layer height, first number is bottom layer and last number is surface layer.

%load('pitdata.mat');
load('pitdata_with_Do_from_SSA.mat');   %this is a result of adding new Do from SSA to the original 'pitdata' structure array
%pitdata = ans;
load('pitdate.mat');
pitdate = ans;
clear('ans');

%%
% Create a SWE weighted inverse diameter using grain diamater from
% macrophotos

swe_weight_inv_grain_diam_all = [];
for i=1:49;
[q r] = size(pitdata(i).h);
dummy_grain = [];
dummy_swe = [];
    for j=1:q
    dummy = (1 ./ pitdata(i).gsiz(j)) .* pitdata(i).swe(j);
    dummy_grain = cat(1, dummy_grain, dummy);
    dummy_swe = cat(1, dummy_swe, pitdata(i).swe(j));
    end 
total_grain = sum(dummy_grain,1);
total_swe = sum(dummy_swe,1);
dummy2 = total_grain ./ total_swe;
swe_weight_inv_grain_diam = 1 ./ dummy2;
swe_weight_inv_grain_diam_all = cat(1, swe_weight_inv_grain_diam_all, swe_weight_inv_grain_diam);
end

%%
% create an array of serial dates that relate to pit dates
pit_serial_dates = [];
for i=1:49;
    dummy3 = datenum(pitdate(i,:));
    pit_serial_dates = cat(1,pit_serial_dates, dummy3); 
end
%%
% plot Swe inverse weigthed grain size from macro photos for winters 2011-12 and 2012-13

% create start and end date vectors to provide limits for plotting graphs
start2011 = datenum('1-Oct-2011');
end2012 = datenum('1-Jun-2012');
start2012 = datenum('1-Oct-2012');
end2013 = datenum('1-Jun-2013');

% in pit_serial_dates rows 1:23 are 2011-12, and rows 24:49 are 2012-13
% find(pit_serial_dates < end2012)

figure(1);subplot(1,2,1),plot(pit_serial_dates(1:23, :), swe_weight_inv_grain_diam_all(1:23, :), '-sk');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
%ylim ([-40 40]);
title('2011-12');
ylabel('Grain size - visual (mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(1,2,2),plot(pit_serial_dates(24:49, :), swe_weight_inv_grain_diam_all(24:49, :), '-sk');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
%ylim ([-40 40]);
title('2012-13');
ylabel('Grain size - visual (mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\grain_visual.png');

%%
% This section was run (repeatedly) manually to create pitdata.Do (i.e. a Do
% value for every layer idetified in the pit profiles (where measurmeents
% were available). This created 'pitdata_with_Do_from_SSA.mat' and produces
% a structure array called 'pitdata' which has Do values where available.
% It should only need doing once. 

% % adjust manually to find the correct row that associates with the date of the pit
% row = [46];
% whichdate = pitdate(row,:); 
% 
% %%
% % Add optical grain diameter, calculated from SSA values as a variable in
% % the pitdata structure array
% 
% layer_thickness = pitdata(row).h;
% layer_swe = pitdata(row).swe;
% 
% layer_boundary_top = cumsum(layer_thickness,1);
% layer_boundary_bottom = [0; layer_boundary_top(1:(length(layer_boundary_top) - 1),1)];
% 
% % Create (manually) an array caled 'data' from the icecube output - cut and
% % paste from *.csv files
% layer_ave_SSA_all = [];
% for i=1:length(layer_boundary_top);
%     dummy4 = data_2013_04_16(find(data_2013_04_16(:,5) <= layer_boundary_top(i,1) & data_2013_04_16(:,5) >= layer_boundary_bottom(i,1)),:);
%     layer_ave_SSA = mean(dummy4(:,4),1);
%     dummy5 = cat(2,layer_boundary_bottom(i,1), layer_boundary_top(i,1), layer_ave_SSA);
%     layer_ave_SSA_all = cat(1, layer_ave_SSA_all, dummy5);
% end
% 
% % Calculate optical grain diameter from SSA value (after Montpetit et al. 2013)
% % Optical diamater (in metres) = 6 ./ (SSA * desnity of ice). 
% % Then multiply by 1000 to get diameter in mm.
% 
% layer_Do_from_SSA = (6 ./ (layer_ave_SSA_all(:, 3) .* 917)) .* 1000;
% layer_Do_from_SSA = cat(2, layer_ave_SSA_all(:,1:2),layer_Do_from_SSA);
% pitdata(row).Do = layer_Do_from_SSA(:,3);
%
% % New array saved as 
% save('pitdata_with_Do_from_SSA.mat', 'pitdata');

%%
load('pitdata_with_Do_from_SSA.mat');

% Subset the pitdata and pitdate arrays so that only rows with Do derived from SSA are used.
pitdata_subset1 = pitdata(9:20);
pitdata_subset2 = pitdata(25:32);
pitdata_subset3 = pitdata(34:42);
pitdata_subset4 = pitdata(45:46);
pitdata_subset = [pitdata_subset1 pitdata_subset2 pitdata_subset3 pitdata_subset4];

pitdate_subset1 = pitdate(9:20, :);
pitdate_subset2 = pitdate(25:32, :);
pitdate_subset3 = pitdate(34:42, :);
pitdate_subset4 = pitdate(45:46, :);
pitdate_subset = [pitdate_subset1; pitdate_subset2; pitdate_subset3; pitdate_subset4];


%%
% Create a SWE weighted inverse diameter using grain diamater from SSA
swe_weight_inv_grain_diam__from_SSA_all = [];
for i=1:31; % 31 pits had SSA measurements 
[q r] = size(pitdata_subset(i).h);
dummy_grain_SSA = [];
dummy_swe = [];
    for j=1:q
    dummy = (1 ./ pitdata_subset(i).Do(j)) .* pitdata_subset(i).swe(j); % inverse diameter mutiplied by swe
    dummy_grain_SSA = cat(1, dummy_grain_SSA, dummy);
    dummy_swe = cat(1, dummy_swe, pitdata_subset(i).swe(j));
    end 
dummy5 = cat(2,dummy_grain_SSA, dummy_swe); % join together layer 'inverse diameter mutiplied by swe' and 'swe' to allow removal of NaN layers where there are no SWE measurements
dummy6 = dummy5(~any(isnan(dummy5), 2),:); % remove layers where there is no SSA data (i.e. NaNs) and associated swe values so that Do is only weighted against swe in layers with Do values
dummy_grain_SSA_no_NaNs = dummy6(:,1);
dummy_swe_no_NaNs = dummy6(:,2);

total_grain = sum(dummy_grain_SSA_no_NaNs,1);   % total the grain size in layers with SSA measurmeents 
total_swe = sum(dummy_swe_no_NaNs,1);   % total the swe in layers with SSA measurmeents
dummy7 = total_grain ./ total_swe; 
swe_weight_inv_grain_diam_from_SSA = 1 ./ dummy7;
swe_weight_inv_grain_diam__from_SSA_all = cat(1, swe_weight_inv_grain_diam__from_SSA_all, swe_weight_inv_grain_diam_from_SSA);
end
%%
% create an array of serial dates that relate to pit dates where SSA was
% measured
pit_serial_dates_SSA = [];
for i=1:31;
    dummy8 = datenum(pitdate_subset(i,:));
    pit_serial_dates_SSA = cat(1,pit_serial_dates_SSA, dummy8); 
end

%%
% plot Swe inverse weigthed grain size from SSA for winters 2011-12 and 2012-13

% create start and end date vectors to provide limits for plotting graphs
start2011 = datenum('1-Oct-2011');
end2012 = datenum('1-Jun-2012');
start2012 = datenum('1-Oct-2012');
end2013 = datenum('1-Jun-2013');

% in pit_serial_dates rows 1:23 are 2011-12, and rows 24:49 are 2012-13
% find(pit_serial_dates < end2012)

figure(2);subplot(1,2,1),plot(pit_serial_dates_SSA(1:12, :), swe_weight_inv_grain_diam__from_SSA_all(1:12, :), '-sk');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
%ylim ([-40 40]);
title('2011-12');
ylabel('Grain size - SSA(mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(2);subplot(1,2,2),plot(pit_serial_dates_SSA(13:31, :), swe_weight_inv_grain_diam__from_SSA_all(13:31, :), '-sk');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
%ylim ([-40 40]);
title('2012-13');
ylabel('Grain size - SSA (mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\grain_SSA.png');

%%
% Plot SWE inverse weighted grain size from macrophotos and from SSA for winters 2011-12 and 2012-13
% create start and end date vectors to provide limits for plotting graphs
start2011 = datenum('1-Oct-2011');
end2012 = datenum('1-Jun-2012');
start2012 = datenum('1-Oct-2012');
end2013 = datenum('1-Jun-2013');

% in pit_serial_dates rows 1:23 are 2011-12, and rows 24:49 are 2012-13
% find(pit_serial_dates < end2012)

figure(3);subplot(1,2,1),plot(pit_serial_dates_SSA(1:12, :), swe_weight_inv_grain_diam__from_SSA_all(1:12, :), '-sk',...
                              pit_serial_dates(1:23, :), swe_weight_inv_grain_diam_all(1:23, :), '-sb');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0.2 1.8]);
title('2011-12');
legend('SSA','Visual','Location','NorthWest');
ylabel('SWE weighted mean grain diameter (mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(3);subplot(1,2,2),plot(pit_serial_dates_SSA(13:31, :), swe_weight_inv_grain_diam__from_SSA_all(13:31, :), '-sk',...
                              pit_serial_dates(24:49, :), swe_weight_inv_grain_diam_all(24:49, :), '-sb');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0.2 1.8]);
title('2012-13');
legend('SSA','Visual','Location','NorthWest');
ylabel('SWE weighted mean grain diameter (mm)');
%print('-r300', '-dpng', 'C:\Nick\Mel\grain_visual_and_SSA.png');

%%
% Load simulated grain sizes from three models
load('bulkgraind2011_2012.mat');

% create start and end date vectors to provide limits for plotting graphs
% start2011 = datenum('1-Oct-2011');
start2011 = datenum('15-Nov-2011');
end2012 = datenum('1-Jun-2012');

% create a serial date 
A = num2str(all_graind(:,1));
Y = str2num(A(:,1:4));
M = str2num(A(:,5:6));
D = str2num(A(:,7:8));
sim_serial_dates = datenum(Y,M,D);

model_MOS = all_graind(:,2:64);
dummy = cat(2, sim_serial_dates, all_graind(:,2:64));
model_MOS_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_MOS_noNaNs_dates = model_MOS_noNaNs(:,1);

model_SNT = all_graind(:,65:127);
dummy = cat(2, sim_serial_dates, all_graind(:,65:127));
model_SNT_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_SNT_noNaNs_dates = model_SNT_noNaNs(:,1);

model_SNI = all_graind(:,128:190);
dummy = cat(2, sim_serial_dates, all_graind(:,128:190));
model_SNI_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_SNI_noNaNs_dates = model_SNI_noNaNs(:,1);


model_MOS_max = nanmax(model_MOS,[],2);
model_SNT_max = nanmax(model_SNT,[],2);
model_SNI_max = nanmax(model_SNI,[],2);
model_MOS_noNaNs_max = nanmax(model_MOS_noNaNs(:,2:end),[],2);
model_SNT_noNaNs_max = nanmax(model_SNT_noNaNs(:,2:end),[],2);
model_SNI_noNaNs_max = nanmax(model_SNI_noNaNs(:,2:end),[],2);

model_MOS_min = nanmin(model_MOS,[],2);
model_SNT_min = nanmin(model_SNT,[],2);
model_SNI_min = nanmin(model_SNI,[],2);
model_MOS_noNaNs_min = nanmin(model_MOS_noNaNs(:,2:end),[],2);
model_SNT_noNaNs_min = nanmin(model_SNT_noNaNs(:,2:end),[],2);
model_SNI_noNaNs_min = nanmin(model_SNI_noNaNs(:,2:end),[],2);

model_MOS_mean = nanmean(model_MOS,2);
model_SNT_mean = nanmean(model_SNT,2);
model_SNI_mean = nanmean(model_SNI,2);
model_MOS_noNaNs_mean = nanmean(model_MOS_noNaNs(:,2:end),2);
model_SNT_noNaNs_mean = nanmean(model_SNT_noNaNs(:,2:end),2);
model_SNI_noNaNs_mean = nanmean(model_SNI_noNaNs(:,2:end),2);
%%
ratio_MOStoSNT_2011_12 = model_SNT_mean ./ model_MOS_mean;
ratio_MOStoSNI_2011_12 = model_SNI_mean ./ model_MOS_mean;
ratio_SNItoSNT_2011_12 = model_SNT_mean ./ model_SNI_mean;

mean_ratio_MOStoSNT_2011_12 = nanmean(ratio_MOStoSNT_2011_12,1);
mean_ratio_MOStoSNI_2011_12 = nanmean(ratio_MOStoSNI_2011_12,1);
mean_ratio_SNItoSNT_2011_12 = nanmean(ratio_SNItoSNT_2011_12,1);

%%
% Calculating model bias compared to observed grain size (derived from SSA)
model_all_means = cat(2,sim_serial_dates, model_MOS_mean, model_SNT_mean, model_SNI_mean);
model_all_means_subset = [];
for i=1:12 %rows 1 to 12 have the 2011-12 SSA derived grain size data
    dummy = model_all_means(find(model_all_means(:,1) == floor(pit_serial_dates_SSA(i,1))),:);
    dummy2 = cat(2, dummy, swe_weight_inv_grain_diam__from_SSA_all(i,:));
    model_all_means_subset = cat(1,model_all_means_subset, dummy2);
end

bias_meanGrainSize_MOS_2011_12 = mean(model_all_means_subset(:,2) - model_all_means_subset(:,5));
bias_meanGrainSize_SNT_2011_12 = mean(model_all_means_subset(:,3) - model_all_means_subset(:,5));
bias_meanGrainSize_SNI_2011_12 = mean(model_all_means_subset(:,4) - model_all_means_subset(:,5));

%%
% figure(4);plot(sim_serial_dates,model_SNT_mean,'-g');
% hold on;
% figure(4);plot(sim_serial_dates,model_SNI_mean,'-k');
% hold on;
% figure(4);plot(sim_serial_dates,model_MOS_mean,'-r');
% hold on;
% figure(4);plot(pit_serial_dates_SSA(1:12, :), swe_weight_inv_grain_diam__from_SSA_all(1:12, :), '-sk');
% hold on;
% figure(4);plot(pit_serial_dates(1:23, :), swe_weight_inv_grain_diam_all(1:23, :), '-sb');
% hold on;
% legend('SNT','SNI','MOS','SSA','Visual','Location','NorthWest');
% 
% figure(4);area(sim_serial_dates,model_SNT_max,'BaseValue',0.04,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(4);area(sim_serial_dates,model_SNT_min,'BaseValue',0.04,'FaceColor',[1 1 1],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(4);area(sim_serial_dates,model_SNI_max,'BaseValue',0.04,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(4);area(sim_serial_dates,model_SNI_min,'BaseValue',0.04,'FaceColor',[1 1 1],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(4);area(sim_serial_dates,model_MOS_max,'BaseValue',0.04,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(4);area(sim_serial_dates,model_MOS_min,'BaseValue',0.04,'FaceColor',[1 1 1],'EdgeColor',[1 1 1]);
% hold on
% 
% figure(4);plot(sim_serial_dates,model_SNT_mean,'-g');
% hold on;
% figure(4);plot(sim_serial_dates,model_SNI_mean,'-k');
% hold on;
% figure(4);plot(sim_serial_dates,model_MOS_mean,'-r');
% hold on;
% figure(4);plot(pit_serial_dates_SSA(1:12, :), swe_weight_inv_grain_diam__from_SSA_all(1:12, :), '-sk');
% hold on;
% figure(4);plot(pit_serial_dates(1:23, :), swe_weight_inv_grain_diam_all(1:23, :), '-sb');
% hold on;
% 
% tk = datelist(start2011, end2012, 1:1:12);
% set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
% datetick('x', 'm', 'keepticks', 'keeplimits');
% %ylim ([0.2 1.8]);
% title('2011-12');
% ylabel('Grain diameter (mm)');
% %print('-r300', '-dpng', 'C:\Nick\Mel\all_grain_sizes_2011_12.png');
%%
drangeX=[model_SNT_noNaNs_dates; flipud(model_SNT_noNaNs_dates)]; 
drangeY=[model_SNT_noNaNs_max; flipud(model_SNT_noNaNs_min)];  
figure(4);SNTfill=fill(drangeX,drangeY,'g');
hasbehavior(SNTfill,'legend',false);
set(SNTfill,'facealpha',0.2,'edgecolor','g','edgealpha',0.2)
hold on
figure(4);plot(model_SNT_noNaNs_dates,model_SNT_noNaNs_mean,'Color','g','LineWidth',1)
hold on

drangeX=[model_SNI_noNaNs_dates; flipud(model_SNI_noNaNs_dates)]; 
drangeY=[model_SNI_noNaNs_max; flipud(model_SNI_noNaNs_min)];  
figure(4);SNIfill=fill(drangeX,drangeY,'k');
hasbehavior(SNIfill,'legend',false);
set(SNIfill,'facealpha',0.2,'edgecolor','k','edgealpha',0.2)
hold on
figure(4);plot(model_SNI_noNaNs_dates,model_SNI_noNaNs_mean,'Color','k','LineWidth',1)
hold on

drangeX=[model_MOS_noNaNs_dates; flipud(model_MOS_noNaNs_dates)]; 
drangeY=[model_MOS_noNaNs_max; flipud(model_MOS_noNaNs_min)];  
figure(4);MOSfill=fill(drangeX,drangeY,'r');
hasbehavior(MOSfill,'legend',false);
set(MOSfill,'facealpha',0.2,'edgecolor','r','edgealpha',0.2)
hold on
figure(4);plot(model_MOS_noNaNs_dates,model_MOS_noNaNs_mean,'Color','r','LineWidth',1)
hold on

figure(4);plot(pit_serial_dates_SSA(1:12, :), swe_weight_inv_grain_diam__from_SSA_all(1:12, :), '-sk');
hold on;
figure(4);plot(pit_serial_dates(1:23, :), swe_weight_inv_grain_diam_all(1:23, :), '-sb');
hold on;

hold on
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
legend('SNT', 'SNI', 'MOS', 'SSA','Visual','Location','NorthWest');


ylim ([0 1.8]);
ylabel('Grain diameter (mm)');
title('2011-12');
box on
%print('-r300', '-dpng', 'U:\Mel\all_grain_sizes_2011_12_v2.png');

%%
load('bulkgraind2012_2013.mat'); % this overwrite the 2011-1 data and prodcues new vaules for current variables

%start2012 = datenum('1-Oct-2012');
start2012 = datenum('15-Oct-2012');
end2013 = datenum('1-Jun-2013');

% create a serial date 
A = num2str(all_graind(:,1));
Y = str2num(A(:,1:4));
M = str2num(A(:,5:6));
D = str2num(A(:,7:8));
sim_serial_dates = datenum(Y,M,D);


model_MOS = all_graind(:,2:64);
dummy = cat(2, sim_serial_dates, all_graind(:,2:64));
model_MOS_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_MOS_noNaNs_dates = model_MOS_noNaNs(:,1);

model_SNT = all_graind(:,65:127);
dummy = cat(2, sim_serial_dates, all_graind(:,65:127));
model_SNT_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_SNT_noNaNs_dates = model_SNT_noNaNs(:,1);

model_SNI = all_graind(:,128:190);
dummy = cat(2, sim_serial_dates, all_graind(:,128:190));
model_SNI_noNaNs = dummy(~any(isnan(dummy), 2),:);
model_SNI_noNaNs_dates = model_SNI_noNaNs(:,1);


model_MOS_max = nanmax(model_MOS,[],2);
model_SNT_max = nanmax(model_SNT,[],2);
model_SNI_max = nanmax(model_SNI,[],2);
model_MOS_noNaNs_max = nanmax(model_MOS_noNaNs(:,2:end),[],2);
model_SNT_noNaNs_max = nanmax(model_SNT_noNaNs(:,2:end),[],2);
model_SNI_noNaNs_max = nanmax(model_SNI_noNaNs(:,2:end),[],2);

model_MOS_min = nanmin(model_MOS,[],2);
model_SNT_min = nanmin(model_SNT,[],2);
model_SNI_min = nanmin(model_SNI,[],2);
model_MOS_noNaNs_min = nanmin(model_MOS_noNaNs(:,2:end),[],2);
model_SNT_noNaNs_min = nanmin(model_SNT_noNaNs(:,2:end),[],2);
model_SNI_noNaNs_min = nanmin(model_SNI_noNaNs(:,2:end),[],2);

model_MOS_mean = nanmean(model_MOS,2);
model_SNT_mean = nanmean(model_SNT,2);
model_SNI_mean = nanmean(model_SNI,2);
model_MOS_noNaNs_mean = nanmean(model_MOS_noNaNs(:,2:end),2);
model_SNT_noNaNs_mean = nanmean(model_SNT_noNaNs(:,2:end),2);
model_SNI_noNaNs_mean = nanmean(model_SNI_noNaNs(:,2:end),2);

ratio_MOStoSNT_2012_13 = model_SNT_mean ./ model_MOS_mean;
ratio_MOStoSNI_2012_13 = model_SNI_mean ./ model_MOS_mean;
ratio_SNItoSNT_2012_13 = model_SNT_mean ./ model_SNI_mean;

mean_ratio_MOStoSNT_2012_13 = nanmean(ratio_MOStoSNT_2012_13,1);
mean_ratio_MOStoSNI_2012_13 = nanmean(ratio_MOStoSNI_2012_13,1);
mean_ratio_SNItoSNT_2012_13 = nanmean(ratio_SNItoSNT_2012_13,1);

%%
% Calculating model bias compared to observed grain size (derived from SSA)
model_all_means = cat(2,sim_serial_dates, model_MOS_mean, model_SNT_mean, model_SNI_mean);
model_all_means_subset = [];
for i=13:31 %rows 13 to 31 have the 2012-13 SSA derived grain size data
    dummy = model_all_means(find(model_all_means(:,1) == floor(pit_serial_dates_SSA(i,1))),:);
    dummy2 = cat(2, dummy, swe_weight_inv_grain_diam__from_SSA_all(i,:));
    model_all_means_subset = cat(1,model_all_means_subset, dummy2);
end

bias_meanGrainSize_MOS_2012_13 = mean(model_all_means_subset(:,2) - model_all_means_subset(:,5));
bias_meanGrainSize_SNT_2012_13 = mean(model_all_means_subset(:,3) - model_all_means_subset(:,5));
bias_meanGrainSize_SNI_2012_13 = mean(model_all_means_subset(:,4) - model_all_means_subset(:,5));


%%
% figure(5);plot(sim_serial_dates,model_SNT_mean,'-g');
% hold on;
% figure(5);plot(sim_serial_dates,model_SNI_mean,'-k');
% hold on;
% figure(5);plot(sim_serial_dates,model_MOS_mean,'-r');
% hold on;
% figure(5);plot(pit_serial_dates_SSA(13:31, :), swe_weight_inv_grain_diam__from_SSA_all(13:31, :), '-sk');
% hold on;
% figure(5);plot(pit_serial_dates(24:49, :), swe_weight_inv_grain_diam_all(24:49, :), '-sb');
% hold on;
% legend('SNT','SNI','MOS','SSA','Visual','Location','NorthWest');
% 
% figure(5);area(sim_serial_dates,model_SNT_max,'BaseValue',0.07,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(5);area(sim_serial_dates,model_SNT_min,'BaseValue',0.07,'FaceColor',[1 1 1],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(5);area(sim_serial_dates,model_SNI_max,'BaseValue',0.07,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(5);area(sim_serial_dates,model_SNI_min,'BaseValue',0.07,'FaceColor',[1 1 1],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(5);area(sim_serial_dates,model_MOS_max,'BaseValue',0.07,'FaceColor',[.75 .75 .75],'EdgeColor',[.75 .75 .75]);
% hold on
% figure(5);area(sim_serial_dates,model_MOS_min,'BaseValue',0.07,'FaceColor',[1 1 1],'EdgeColor',[1 1 1]);
% hold on
% 
% figure(5);plot(sim_serial_dates,model_SNT_mean,'-g');
% hold on;
% figure(5);plot(sim_serial_dates,model_SNI_mean,'-k');
% hold on;
% figure(5);plot(sim_serial_dates,model_MOS_mean,'-r');
% hold on;
% figure(5);plot(pit_serial_dates_SSA(13:31, :), swe_weight_inv_grain_diam__from_SSA_all(13:31, :), '-sk');
% hold on;
% figure(5);plot(pit_serial_dates(24:49, :), swe_weight_inv_grain_diam_all(24:49, :), '-sb');
% hold on;
% 
% tk = datelist(start2012, end2013, 1:1:12);
% set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
% datetick('x', 'm', 'keepticks', 'keeplimits');
% %ylim ([0.2 1.8]);
% title('2012-13');
% ylabel('Grain diameter (mm)');
% %print('-r300', '-dpng', 'C:\Nick\Mel\all_grain_sizes_2012_13.png');
% % xlabel('Distance across trench (m)');
% % ylabel('Depth (cm)');
% % ylim([-1 90]);
%%

drangeX=[model_SNT_noNaNs_dates; flipud(model_SNT_noNaNs_dates)]; 
drangeY=[model_SNT_noNaNs_max; flipud(model_SNT_noNaNs_min)];  
figure(5);SNTfill=fill(drangeX,drangeY,'g');
set(SNTfill,'facealpha',0.2,'edgecolor','g','edgealpha',0.2);
hasbehavior(SNTfill,'legend',false);
hold on
h1 = figure(5);plot(model_SNT_noNaNs_dates,model_SNT_noNaNs_mean,'Color','g','LineWidth',1)
hold on

drangeX=[model_SNI_noNaNs_dates; flipud(model_SNI_noNaNs_dates)]; 
drangeY=[model_SNI_noNaNs_max; flipud(model_SNI_noNaNs_min)];  
figure(5);SNIfill=fill(drangeX,drangeY,'k');
set(SNIfill,'facealpha',0.2,'edgecolor','k','edgealpha',0.2);
hasbehavior(SNIfill,'legend',false);
hold on
h2 = figure(5);plot(model_SNI_noNaNs_dates,model_SNI_noNaNs_mean,'Color','k','LineWidth',1)
hold on

drangeX=[model_MOS_noNaNs_dates; flipud(model_MOS_noNaNs_dates)]; 
drangeY=[model_MOS_noNaNs_max; flipud(model_MOS_noNaNs_min)];  
figure(5);MOSfill=fill(drangeX,drangeY,'r');
set(MOSfill,'facealpha',0.2,'edgecolor','r','edgealpha',0.2);
hasbehavior(MOSfill,'legend',false);
hold on
h3 = figure(5);plot(model_MOS_noNaNs_dates,model_MOS_noNaNs_mean,'Color','r','LineWidth',1)
hold on

h4 = figure(5);plot(pit_serial_dates_SSA(13:31, :), swe_weight_inv_grain_diam__from_SSA_all(13:31, :), '-sk');
hold on;
h5 = figure(5);plot(pit_serial_dates(24:49, :), swe_weight_inv_grain_diam_all(24:49, :), '-sb');
hold on;

hold on;
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
legend('SNT', 'SNI', 'MOS', 'SSA','Visual','Location','NorthWest');

ylim ([0 1.8]);
ylabel('Grain diameter (mm)');
title('2012-13');
box on
%print('-r300', '-dpng', 'U:\Mel\all_grain_sizes_2012_13_v2.png');

