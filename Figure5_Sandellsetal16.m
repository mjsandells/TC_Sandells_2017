%% CSet up the Figure 
clear all
close all
% Aims to cycle through snow model output. Here are use defined parameters
GSFtoplot='1p0'
timeperiod='2011-2012'
Fsize=10
w=0.27
h=0.2
maxspike=30
maxspikemean=30
switch timeperiod 
case '2011-2012'
inputstartdate='010711' %2011-2012: 010711 2012-2013: 01072012
inputenddate='300612' %2011-2012: 300612  2012-2013: 30052013
startDate = datenum('10-01-2011');
endDate = datenum('05-22-2012');
startDateCF=datenum('11-01-2011');
endDateCF=datenum('03-31-2012');

xloclabel=datenum(2012,5,8);
yloclabel=285;
fid = fopen('/home/leanne/MEL/MEL-FARM/observations/NOSREX_sodrad_tb_avgs_2011_2012.csv','rt');  % YR1 CHANGES HERE
figure_name=strcat('TBresults_SpikeGone_Lineadded_newcomp_',timeperiod,'_',GSFtoplot);
realdi='4p4';
compdi='0.0';
case '2012-2013';
inputstartdate='01072012'; %2011-2012: 010711 2012-2013: 01072012;
inputenddate='30052013'; %2011-2012: 300612  2012-2013: 30052013;
startDate = datenum('09-30-2012');
endDate = datenum('05-30-2013');
startDateCF=datenum('11-01-2012');
endDateCF=datenum('03-31-2013');
xloclabel=datenum(2013,5,8)
yloclabel=285
fid = fopen('/home/leanne/MEL/MEL-FARM/observations/NOSREX_sodrad_tb_avgs_2012_2013.csv','rt');  % YR1 CHANGES HERE
figure_name=strcat('TBresults_SpikeGone_Lineadded_newcomp_',timeperiod,'_',GSFtoplot);
realdi='4p6'
compdi='0.0'
end

topLevelFolderHUT=strcat('/home/leanne/MEL/MEL-FARM/TBresults_MainFarm_',timeperiod,'/',GSFtoplot,'/HUT/',realdi,'/',compdi,'/')
topLevelFolderDMRT=strcat('/home/leanne/MEL/MEL-FARM/TBresults_MainFarm_',timeperiod,'/',GSFtoplot,'/DMRT/',realdi,'/',compdi,'/')
topLevelFolderMEMLS=strcat('/home/leanne/MEL/MEL-FARM/TBresults_MainFarm_',timeperiod,'/',GSFtoplot,'/MEMLS/',realdi,'/',compdi,'/')

%%

simid = cell(1,63);
simid {1,1} = '0000';
simid {1,2} = '0001';
simid {1,3} = '0002';
simid {1,4} = '0010';
simid {1,5} = '0011';
simid {1,6} = '0012';
simid {1,7} = '0020';
simid {1,8} = '0021';
simid {1,9} = '0022';
simid {1,10} = '0100';
simid {1,11} = '0101';
simid {1,12} = '0102';
simid {1,13} = '0110';
simid {1,14} = '0111';
simid {1,15} = '0112';
simid {1,16} = '0120';
simid {1,17} = '0121';
simid {1,18} = '0122';
simid {1,19} = '0200';
simid {1,20} = '0201';
simid {1,21} = '0202';
simid {1,22} = '0210';
simid {1,23} = '0211';
simid {1,24} = '0212';
simid {1,25} = '0220';
simid {1,26} = '0221';
simid {1,27} = '0222';
simid {1,28} = '1000';
simid {1,29} = '1001';
simid {1,30} = '1002';
simid {1,31} = '1010';
simid {1,32} = '1011';
simid {1,33} = '1012';
simid {1,34} = '1020';
simid {1,35} = '1021';
simid {1,36} = '1022';
simid {1,37} = '1100';
simid {1,38} = '1101';
simid {1,39} = '1102';
simid {1,40} = '1110';
simid {1,41} = '1111';
simid {1,42} = '1112';
simid {1,43} = '1120';
simid {1,44} = '1121';
simid {1,45} = '1122';
simid {1,46} = '1200';
simid {1,47} = '1201';
simid {1,48} = '1202';
simid {1,49} = '1210';
simid {1,50} = '1211';
simid {1,51} = '1212';
simid {1,52} = '1220';
simid {1,53} = '1221';
simid {1,54} = '1222';
simid {1,55} = '2020';
simid {1,56} = '2021';
simid {1,57} = '2022';
simid {1,58} = '2120';
simid {1,59} = '2121';
simid {1,60} = '2122';
simid {1,61} = '2220';
simid {1,62} = '2221';
simid {1,63} = '2222';

% DMRTML results

% Want to get a list of directories in the results folder
basepath = pwd;

% Generate list of all subfolders.
% Unfortunately they'll be all in one big long string, separated by colons.
allSubFolders = genpath(topLevelFolderDMRT);

% Scan through them separating them.
remain = allSubFolders;
listOfFolderNames = {};
while true % Demo code adapted from the help file.
[singleSubFolder, remain] = strtok(remain, ':');
if isempty(singleSubFolder), break; end
listOfFolderNames = [listOfFolderNames singleSubFolder];
end

% Create list of dates from input files
% format will be date, (min, max, cumulative sum, number of values, mean value) repeated for TB 18.7V TB 18.7H tb37v tb37h
all_dates_dmrt=[];

% Cycle through list of folders
for d = 1:size(listOfFolderNames,2)
    folder = listOfFolderNames{d};
% skip folders containing 1e6 in the string
  smatch1e6 = regexp(folder,'1e6/Processed'); 
  smatch0p1 = regexp(folder,'0p1/Processed'); 
  smatch0p2 = regexp(folder,'0p2/Processed'); 
  
    % continue
if  (isempty(smatch0p2)==0 || isempty(smatch0p1)==0) && (isempty(smatch1e6)==1)
    cd (folder);
    % do stuff
    if ~isempty(dir('*.txt'));
        % Want to find mean, min and max for all memls-ML model combos
        sprintf('***********Working in Folder ==')
        disp(folder)
        sprintf('***********Finished working in Folder ==')
       
        FileList = dir('*.txt');
        N = size(FileList,1);
        % Initialise TBresults
        TBresults = [];
        for k = 1:N

            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
            % Loop over rows (dates) in processed files
            for jj = 1:size(y,1)
                % Identify date
                search_date = y(jj,1);
                % Try to look for it in the all_dates_dmrt matrix
                if isempty(all_dates_dmrt)
                    % need to create first set of data
                    all_dates_dmrt = [search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];
                elseif any(all_dates_dmrt(:,1)==search_date)
                    % date already exists in matrix - process data
                    % Find out where it is
                    [irow,icolumn] = find(y==search_date);

                    % 19v. These are columns 2-6 in all_dates_dmrt (2.min, 3.max, 4.cumulative sum, 5.number of values, 6.mean value)
                    if (y(jj,2) < all_dates_dmrt(irow,2))
                        all_dates_dmrt(irow,2) = y(jj,2); % new min value
                    end
                    if (y(jj,2) > all_dates_dmrt(irow,3))
                        all_dates_dmrt(irow,3) = y(jj,2); % new max value
                    end
                    % Add to cumulative sum as long as it isn't a NaN
                    if ~isnan(y(jj,2))
                        % add to cumulative sum
                        all_dates_dmrt(irow,4) = all_dates_dmrt(irow,4) + y(jj,2);
                        all_dates_dmrt(irow,5) = all_dates_dmrt(irow,5) + 1; % increase number of values by 1
                    end

                    % 19h. These are columns 7-11 in all_dates_dmrt (7.min, 8.max, 9.cumulative sum, 10.number of values, 11.mean value)
                    if (y(jj,3) < all_dates_dmrt(irow,7))
                        all_dates_dmrt(irow,7) = y(jj,3); % new min value
                    end
                    if (y(jj,3) > all_dates_dmrt(irow,8))
                        all_dates_dmrt(irow,8) = y(jj,3); % new max value
                    end
                    % Add to cumulative sum as long as it isn't a NaN
                    if ~isnan(y(jj,3))
                        % add to cumulative sum
                        all_dates_dmrt(irow,9) = all_dates_dmrt(irow,9) + y(jj,3);
                        all_dates_dmrt(irow,10) = all_dates_dmrt(irow,10) + 1; % increase number of values by 1
                    end

                    % 37v. These are columns 12-16 in all_dates_dmrt (12.min, 13.max, 14.cumulative sum, 15.number of values, 16.mean value)
                    if (y(jj,4) < all_dates_dmrt(irow,12))
                        all_dates_dmrt(irow,12) = y(jj,4); % new min value
                    end
                    if (y(jj,4) > all_dates_dmrt(irow,13))
                        all_dates_dmrt(irow,13) = y(jj,4); % new max value
                    end
                    % Add to cumulative sum as long as it isn't a NaN
                    if ~isnan(y(jj,4))
                        % add to cumulative sum
                        all_dates_dmrt(irow,14) = all_dates_dmrt(irow,14) + y(jj,4);
                        all_dates_dmrt(irow,15) = all_dates_dmrt(irow,15) + 1; % increase number of values by 1
                    end

                    % 37h. These are columns 17-21 in all_dates_dmrt (17.min, 18.max, 19.cumulative sum, 20.number of values, 21.mean value)
                    if (y(jj,5) < all_dates_dmrt(irow,17))
                        all_dates_dmrt(irow,17) = y(jj,5); % new min value
                    end
                    if (y(jj,5) > all_dates_dmrt(irow,18))
                        all_dates_dmrt(irow,18) = y(jj,5); % new max value
                    end
                    % Add to cumulative sum as long as it isn't a NaN
                    if ~isnan(y(jj,5))
                        % add to cumulative sum
                        all_dates_dmrt(irow,19) = all_dates_dmrt(irow,19) + y(jj,5);
                        all_dates_dmrt(irow,20) = all_dates_dmrt(irow,20) + 1; % increase number of values by 1
                    end
                else
                    % Need to add it
                    all_dates_dmrt = [all_dates_dmrt; search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];

                end % if date exists condition

            end % loop over dates within file

        end % Loop over files



    end % If statement
    disp(folder);
    % Get back into top level directory
    cd (basepath);
    sprintf('Finished plotting',folder)
end % new else end
end % Loop over all subdirectories

% calculate means
all_dates_dmrt(:,6) = all_dates_dmrt(:,4) ./ all_dates_dmrt(:,5); % 19v
all_dates_dmrt(:,11) = all_dates_dmrt(:,9) ./ all_dates_dmrt(:,10); % 19h
all_dates_dmrt(:,16) = all_dates_dmrt(:,14) ./ all_dates_dmrt(:,15); % 37v
all_dates_dmrt(:,21) = all_dates_dmrt(:,19) ./ all_dates_dmrt(:,20); % 37h

% Get back into scripts directory
cd (basepath)

% Sort matrix into ascending date order
[values, order] = sort(all_dates_dmrt(:,1));
dmrtsortedresults = all_dates_dmrt(order,:);


% MEMLS results-------------------------------------------------------------------------------------------------------

% Want to get a list of directories in the results folder

basepath = pwd;


% Generate list of all subfolders.
% Unfortunately they'll be all in one big long string, separated by colons.
allSubFolders = genpath(topLevelFolderMEMLS);

% Scan through them separating them.
remain = allSubFolders;
listOfFolderNames = {};
while true % Demo code adapted from the help file.
    [singleSubFolder, remain] = strtok(remain, ':');
    if isempty(singleSubFolder), break; end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end

% Create list of dates from input files
% format will be date, (min, max, cumulative sum, number of values, mean value) repeated for TB 18.7V TB 18.7H tb37v tb37h
all_dates_memls=[];

% Cycle through list of folders
for d = 1:size(listOfFolderNames,2)
    folder = listOfFolderNames{d};
    cd (folder);


    % do stuff
    if ~isempty(dir('*.txt'))
        % Want to find mean, min and max for all memls-ML model combos
        FileList = dir('*.txt');
        N = size(FileList,1);
        % Initialise TBresults
        TBresults = [];
        for k = 1:N

            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
            % Loop over rows (dates) in processed files
            for jj = 1:size(y,1)
                % Identify date
                search_date = y(jj,1);
                % Try to look for it in the all_dates_memls matrix
                if isempty(all_dates_memls)
                    % need to create first set of data
                    all_dates_memls = [search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];
                elseif any(all_dates_memls(:,1)==search_date)
                    % date already exists in matrix - process data
                    % Find out where it is
                    [irow,icolumn] = find(y==search_date);

                % 19v. These are columns 2-6 in all_dates_memls (2.min, 3.max, 4.cumulative sum, 5.number of values, 6.mean value)
                if (y(jj,2) < all_dates_memls(irow,2))
                    all_dates_memls(irow,2) = y(jj,2); % new min value
                end
                if (y(jj,2) > all_dates_memls(irow,3))
                    all_dates_memls(irow,3) = y(jj,2); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,2))
                    % add to cumulative sum
                    all_dates_memls(irow,4) = all_dates_memls(irow,4) + y(jj,2);
                    all_dates_memls(irow,5) = all_dates_memls(irow,5) + 1; % increase number of values by 1
                end

                % 19h. These are columns 7-11 in all_dates_memls (7.min, 8.max, 9.cumulative sum, 10.number of values, 11.mean value)
                if (y(jj,3) < all_dates_memls(irow,7))
                    all_dates_memls(irow,7) = y(jj,3); % new min value
                end
                if (y(jj,3) > all_dates_memls(irow,8))
                    all_dates_memls(irow,8) = y(jj,3); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,3))
                    % add to cumulative sum
                    all_dates_memls(irow,9) = all_dates_memls(irow,9) + y(jj,3);
                    all_dates_memls(irow,10) = all_dates_memls(irow,10) + 1; % increase number of values by 1
                end

                % 37v. These are columns 12-16 in all_dates_memls (12.min, 13.max, 14.cumulative sum, 15.number of values, 16.mean value)
                if (y(jj,4) < all_dates_memls(irow,12))
                    all_dates_memls(irow,12) = y(jj,4); % new min value
                end
                if (y(jj,4) > all_dates_memls(irow,13))
                    all_dates_memls(irow,13) = y(jj,4); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,4))
                    % add to cumulative sum
                    all_dates_memls(irow,14) = all_dates_memls(irow,14) + y(jj,4);
                    all_dates_memls(irow,15) = all_dates_memls(irow,15) + 1; % increase number of values by 1
                end

                % 37h. These are columns 17-21 in all_dates_memls (17.min, 18.max, 19.cumulative sum, 20.number of values, 21.mean value)
                if (y(jj,5) < all_dates_memls(irow,17))
                    all_dates_memls(irow,17) = y(jj,5); % new min value
                end
                if (y(jj,5) > all_dates_memls(irow,18))
                    all_dates_memls(irow,18) = y(jj,5); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,5))
                    % add to cumulative sum
                    all_dates_memls(irow,19) = all_dates_memls(irow,19) + y(jj,5);
                    all_dates_memls(irow,20) = all_dates_memls(irow,20) + 1; % increase number of values by 1
                end
            else
                % Need to add it
                all_dates_memls = [all_dates_memls; search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];

            end % if date exists condition

        end % loop over dates within file

    end % Loop over files



end % If statement
disp(folder);

% Get back into top level directory
cd (basepath);

end % Loop over all subdirectories

% calculate means
all_dates_memls(:,6) = all_dates_memls(:,4) ./ all_dates_memls(:,5); % 19v
all_dates_memls(:,11) = all_dates_memls(:,9) ./ all_dates_memls(:,10); % 19h
all_dates_memls(:,16) = all_dates_memls(:,14) ./ all_dates_memls(:,15); % 37v
all_dates_memls(:,21) = all_dates_memls(:,19) ./ all_dates_memls(:,20); % 37h

% Get back into scripts directory
cd (basepath)

% Sort matrix into ascending date order
[values, order] = sort(all_dates_memls(:,1));
memlssortedresults = all_dates_memls(order,:);



% HUT results-------------------------------------------------------------------------------------------------------

% Want to get a list of directories in the results folder
% Define some top-level folder.
basepath = pwd;


% Generate list of all subfolders.
% Unfortunately they'll be all in one big long string, separated by colons.
allSubFolders = genpath(topLevelFolderHUT);

% Scan through them separating them.
remain = allSubFolders;
listOfFolderNames = {};
while true % Demo code adapted from the help file.
    [singleSubFolder, remain] = strtok(remain, ':');
    if isempty(singleSubFolder), break; end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end

% Create list of dates from input files
% format will be date, (min, max, cumulative sum, number of values, mean value) repeated for TB 18.7V TB 18.7H tb37v tb37h
all_dates_hut=[];

% Cycle through list of folders
for d = 1:size(listOfFolderNames,2)
    folder = listOfFolderNames{d};
    cd (folder);


    % do stuff
    if ~isempty(dir('*.txt'))
        % Want to find mean, min and max for all memls-ML model combos
        FileList = dir('*.txt');
        N = size(FileList,1);
        for k = 1:N

        % get the file name:
        filename = FileList(k).name;
        y = load(filename);
        % Loop over rows (dates) in processed files
        for jj = 1:size(y,1)
            % Identify date
            search_date = y(jj,1);
            % Try to look for it in the all_dates_hut matrix
            if isempty(all_dates_hut)
                % need to create first set of data
                all_dates_hut = [search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];
            elseif any(all_dates_hut(:,1)==search_date)
                % date already exists in matrix - process data
                % Find out where it is
                [irow,icolumn] = find(y==search_date);

                % 19v. These are columns 2-6 in all_dates_hut (2.min, 3.max, 4.cumulative sum, 5.number of values, 6.mean value)
                if (y(jj,2) < all_dates_hut(irow,2))
                    all_dates_hut(irow,2) = y(jj,2); % new min value
                end
                if (y(jj,2) > all_dates_hut(irow,3))
                    all_dates_hut(irow,3) = y(jj,2); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,2))
                    % add to cumulative sum
                    all_dates_hut(irow,4) = all_dates_hut(irow,4) + y(jj,2);
                    all_dates_hut(irow,5) = all_dates_hut(irow,5) + 1; % increase number of values by 1
                end

                % 19h. These are columns 7-11 in all_dates_hut (7.min, 8.max, 9.cumulative sum, 10.number of values, 11.mean value)
                if (y(jj,3) < all_dates_hut(irow,7))
                    all_dates_hut(irow,7) = y(jj,3); % new min value
                end
                if (y(jj,3) > all_dates_hut(irow,8))
                    all_dates_hut(irow,8) = y(jj,3); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,3))
                    % add to cumulative sum
                    all_dates_hut(irow,9) = all_dates_hut(irow,9) + y(jj,3);
                    all_dates_hut(irow,10) = all_dates_hut(irow,10) + 1; % increase number of values by 1
                end

                % 37v. These are columns 12-16 in all_dates_hut (12.min, 13.max, 14.cumulative sum, 15.number of values, 16.mean value)
                if (y(jj,4) < all_dates_hut(irow,12))
                    all_dates_hut(irow,12) = y(jj,4); % new min value
                end
                if (y(jj,4) > all_dates_hut(irow,13))
                    all_dates_hut(irow,13) = y(jj,4); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,4))
                    % add to cumulative sum
                    all_dates_hut(irow,14) = all_dates_hut(irow,14) + y(jj,4);
                    all_dates_hut(irow,15) = all_dates_hut(irow,15) + 1; % increase number of values by 1
                end

                % 37h. These are columns 17-21 in all_dates_hut (17.min, 18.max, 19.cumulative sum, 20.number of values, 21.mean value)
                if (y(jj,5) < all_dates_hut(irow,17))
                    all_dates_hut(irow,17) = y(jj,5); % new min value
                end
                if (y(jj,5) > all_dates_hut(irow,18))
                    all_dates_hut(irow,18) = y(jj,5); % new max value
                end
                % Add to cumulative sum as long as it isn't a NaN
                if ~isnan(y(jj,5))
                    % add to cumulative sum
                    all_dates_hut(irow,19) = all_dates_hut(irow,19) + y(jj,5);
                    all_dates_hut(irow,20) = all_dates_hut(irow,20) + 1; % increase number of values by 1
                end
            else
                % Need to add it
                all_dates_hut = [all_dates_hut; search_date y(jj,2) y(jj,2) y(jj,2) 1 NaN y(jj,3) y(jj,3) y(jj,3) 1 NaN y(jj,4) y(jj,4) y(jj,4) 1 NaN y(jj,5) y(jj,5) y(jj,5) 1 NaN];

            end % if date exists condition

        end % loop over dates within file

    end % Loop over files



end % If statement
disp(folder);

% Get back into top level directory
cd (basepath);

end % Loop over all subdirectories

% calculate means
all_dates_hut(:,6) = all_dates_hut(:,4) ./ all_dates_hut(:,5); % 19v
all_dates_hut(:,11) = all_dates_hut(:,9) ./ all_dates_hut(:,10); % 19h
all_dates_hut(:,16) = all_dates_hut(:,14) ./ all_dates_hut(:,15); % 37v
all_dates_hut(:,21) = all_dates_hut(:,19) ./ all_dates_hut(:,20); % 37h

% Get back into scripts directory
cd (basepath)

% Sort matrix into ascending date order
[values, order] = sort(all_dates_hut(:,1));
hutsortedresults = all_dates_hut(order,:);


%% Process observations
switch timeperiod
    case '2011-2012'
        processobs20112012PLOT
    case '2012-2013'
        processobs20122013PLOT
end
%%
%Make the Figure

%% Row 1: 19V
FIG1=figure('position', [100, 100, 800, 1200])  % create new figure with specified size
h1=subplot(4,3,1,'position',[0.09   0.75   w    h])
h1p=get(h1,'position')
my_colourd = [255 0 0] ./ 255;
ylim([50 300])
set(gca, 'FontName', 'ArialMT')
set(gca, 'FontSize', Fsize)
xlabel(' ');
ylabel('TB 18.7V (K)');
hold on;
%% SPIKE REMOVAL DMRT 19V%%
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,6));
[irow]=find(abs(dmrtsortedresultsdiff)>maxspikemean);
dmrtsortedresults(irow,6)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,6);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,6)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,2));
[irowmin]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmin,2)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,2);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,2)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,3));
[irowmax]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmax,3)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,3);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,3)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
drangeX=[datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
drangeY=[dmrtsortedresults(:,3); flipud(dmrtsortedresults(:,2))];              %#create y values for out and then back
dmrtfill=fill(drangeX,drangeY,'r');
set(dmrtfill,'facealpha',.3,'edgecolor','r','edgealpha',0.5) % Plot DMRT min on top
hold on
plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,6),'Color',my_colourd,'LineWidth',1) % mean
ylim([50 300])
set(gca,'XTickLabel',[]);
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,2),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
hold on
text(xloclabel,yloclabel,'a')
text(mean([startDate endDate]),yloclabel+30,'DMRTML')
hold on
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
%clear irow
%% SPIKE REMOVAL MEMLS 19V%%
memlssortedresultsdiff=diff(memlssortedresults(:,6));
[irow]=find(abs(memlssortedresultsdiff)>maxspikemean);
memlssortedresults(irow,6)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,6);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,6)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,2));
[irowmin]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmin,2)=NaN;%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,2);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,2)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,3));
[irowmax]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmax,3)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,3);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,3)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
% memls
h2=subplot(4,3,2,'position',[0.37   0.75   w    h])
my_colourm = [0 125 0] ./ 255;
%plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,6),'Color',my_colourm,'LineWidth',1.5) % mean
mrangeX=[datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
mrangeY=[memlssortedresults(:,3); flipud(memlssortedresults(:,2))];              %#create y values for out and then back
memlfill=fill(mrangeX,mrangeY,my_colourm);
set(memlfill,'facealpha',.3,'edgecolor',my_colourm,'edgealpha',0.5)
hold on
plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,6),'Color',my_colourm,'LineWidth',1) % mean
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
hold on
ylim([50 300])
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,2),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'b')
text(mean([startDate endDate]),yloclabel+30,'MEMLS');
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
%clear irow
%% SPIKE REMOVAL HUT 19V%%
h3=subplot(4,3,3,'position',[0.65  0.75   w    h]);
hold on
hutsortedresultsdiff=diff(hutsortedresults(:,6));
[irow]=find(abs(hutsortedresultsdiff)>maxspikemean);
hutsortedresults(irow,6)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,6);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,6)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,2));
[irowmin]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmin,2)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,2);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,2)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,3));
[irowmax]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmax,3)=NaN;
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,3);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,3)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
% hut
my_colourh = [0 0 255] ./ 255;
%plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,6),'Color',my_colourh,'LineWidth',1.5,'LineStyle',':') % mean
hrangeX=[datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
hrangeY=[hutsortedresults(:,3); flipud(hutsortedresults(:,2))];              %#create y values for out and then back
hutfill=fill(hrangeX,hrangeY,'b','edgecolor','b');
set(hutfill,'facealpha',.3,'edgecolor','b','edgealpha',0.5)
hold on
plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,6),'Color',my_colourh,'LineWidth',1) % mean
hold on
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
ylim([50 300])
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,2),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'c')
text(mean([startDate endDate]),yloclabel+30,'HUT')
box on
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
%clear irow
%% Row 2: 19H
h1=subplot(4,3,4,'position',[0.09   0.52   w    h])
h1p=get(h1,'position')
my_colourd = [255 0 0] ./ 255;

%plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,6),'Color',my_colourd,'LineWidth',1.5) % mean
%datetick('x','mmm-yy','keeplimits')
%datetick('x','mmm-yy','keeplimits')
xlim([startDate endDate])
ylim([50 300])
set(gca, 'FontName', 'ArialMT')
set(gca, 'FontSize', Fsize)
xlabel(' ');
ylabel('TB 18.7H (K)');
hold on;
%% SPIKE REMOVAL DMRT 19H%%
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,11));
[irow]=find(abs(dmrtsortedresultsdiff)>maxspikemean);
dmrtsortedresults(irow,11)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,11);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,11)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,7));
[irowmin]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmin,7)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,7);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,7)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,8));
[irowmax]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmax,8)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,8);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,8)=xi;
%%% remove bad data points (E.G. THE SPIKES)
clear irow
%%
drangeX=[datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
drangeY=[dmrtsortedresults(:,8); flipud(dmrtsortedresults(:,7))];              %#create y values for out and then back
dmrtfill=fill(drangeX,drangeY,'r');
set(dmrtfill,'facealpha',.3,'edgecolor','r','edgealpha',0.5) % Plot DMRT min on top
hold on


plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,11),'Color',my_colourd,'LineWidth',1) % mean
ylim([50 300])
set(gca,'XTickLabel',[]);
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,3),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
box on
text(xloclabel,yloclabel,'d');
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
%clear irow
%% SPIKE REMOVAL MEMLS 19H%%
memlssortedresultsdiff=diff(memlssortedresults(:,11));
[irow]=find(abs(memlssortedresultsdiff)>maxspikemean);
memlssortedresults(irow,11)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,11);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,11)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,7));
[irowmin]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmin,7)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,7);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,7)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,8));
[irowmax]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmax,8)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,8);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,8)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
% memls
h2=subplot(4,3,5,'position',[0.37   0.52   w    h]);
my_colourm = [0 125 0] ./ 255;
%plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,6),'Color',my_colourm,'LineWidth',1.5) % mean
mrangeX=[datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
mrangeY=[memlssortedresults(:,8); flipud(memlssortedresults(:,7))];              %#create y values for out and then back
memlfill=fill(mrangeX,mrangeY,my_colourm);
set(memlfill,'facealpha',.3,'edgecolor',my_colourm,'edgealpha',0.5)
hold on

plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,11),'Color',my_colourm,'LineWidth',1) % mean
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
ylim([50 300])
xlim([startDate endDate])
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,3),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'e');
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
%clear irow
%% SPIKE REMOVAL HUT 19H%%
hutsortedresultsdiff=diff(hutsortedresults(:,11));
[irow]=find(abs(hutsortedresultsdiff)>maxspikemean);
hutsortedresults(irow,11)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,11);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,11)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,7));
[irowmin]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmin,7)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,7);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,7)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,8));
[irowmax]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmax,8)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,8);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,8)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
h3=subplot(4,3,6,'position',[0.65  0.52   w    h]);
% hut
my_colourh = [0 0 255] ./ 255;
%plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,6),'Color',my_colourh,'LineWidth',1.5,'LineStyle',':') % mean
hrangeX=[datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
hrangeY=[hutsortedresults(:,8); flipud(hutsortedresults(:,7))];              %#create y values for out and then back
hutfill=fill(hrangeX,hrangeY,'b','edgecolor','b');
set(hutfill,'facealpha',.3,'edgecolor','b','edgealpha',0.5)
hold on
plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,11),'Color',my_colourh,'LineWidth',1) % mean
hold on
xlim([startDate endDate])
ylim([50 300])
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,3),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'f')
box on
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
%clear irow
%% Row 3: 36V
h1=subplot(4,3,7,'position',[0.09   0.29   w    h]);
h1p=get(h1,'position');
my_colourd = [255 0 0] ./ 255;
xlim([startDate endDate])
ylim([50 300])
set(gca, 'FontName', 'ArialMT')
set(gca, 'FontSize', Fsize)
xlabel(' ');
ylabel('TB 36.5V (K)');
hold on;
%% SPIKE REMOVAL DMRT 36V%%
%%% now need to interpolate between NaNs
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,16));
[irow]=find(abs(dmrtsortedresultsdiff)>maxspikemean);
dmrtsortedresults(irow,16)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,16);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,16)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
for q=1:1
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,12));
[irowmin]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmin,12)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,12);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,12)=xi;
end
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,13));
[irowmax]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmax,13)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,13);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,13)=xi;
%%
drangeX=[datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
drangeY=[dmrtsortedresults(:,13); flipud(dmrtsortedresults(:,12))];              %#create y values for out and then back
dmrtfill=fill(drangeX,drangeY,'r');
set(dmrtfill,'facealpha',.3,'edgecolor','r','edgealpha',0.5) % Plot DMRT min on top
hold on

plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,16),'Color',my_colourd,'LineWidth',1) % mean
ylim([50 300])
set(gca,'XTickLabel',[]);
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,4),'Color',[0 0 0],'LineWidth',1) % mean
box on
text(xloclabel,yloclabel,'g')
%clear irow
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
box on
% memls
h2=subplot(4,3,8,'position',[0.37   0.29   w    h]);
my_colourm = [0 125 0] ./ 255;
%% SPIKE REMOVAL MEMLS 36V%%
memlssortedresultsdiff=diff(memlssortedresults(:,16));
[irow]=find(abs(memlssortedresultsdiff)>maxspikemean);
memlssortedresults(irow,16)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,16);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,16)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,12));
[irowmin]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmin,12)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,12);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,12)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,13));
[irowmax]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmax,13)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,13);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,13)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
mrangeX=[datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
mrangeY=[memlssortedresults(:,13); flipud(memlssortedresults(:,12))];              %#create y values for out and then back
memlfill=fill(mrangeX,mrangeY,my_colourm);
set(memlfill,'facealpha',.3,'edgecolor',my_colourm,'edgealpha',0.5)
hold on
plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,16),'Color',my_colourm,'LineWidth',1) % mean
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
ylim([50 300])
xlim([startDate endDate])
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,4),'Color',[0 0 0],'LineWidth',1) % mean
hold on
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
text(xloclabel,yloclabel,'h')
%% SPIKE REMOVAL HUT 36V%%
hutsortedresultsdiff=diff(hutsortedresults(:,16));
[irow]=find(abs(hutsortedresultsdiff)>maxspikemean);
hutsortedresults(irow,16)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,16);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,16)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,12));
[irowmin]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmin,12)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,12);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,12)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,13));
[irowmax]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmax,13)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,13);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,13)=xi;
%%% remove bad data points (E.G. THE SPIKES)
h3=subplot(4,3,9,'position',[0.65  0.29   w    h]);
% hut
%%
my_colourh = [0 0 255] ./ 255;
%plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,6),'Color',my_colourh,'LineWidth',1.5,'LineStyle',':') % mean
hrangeX=[datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
hrangeY=[hutsortedresults(:,13); flipud(hutsortedresults(:,12))];              %#create y values for out and then back
hutfill=fill(hrangeX,hrangeY,'b','edgecolor','b');
set(hutfill,'facealpha',.3,'edgecolor','b','edgealpha',0.5)
hold on
%%% remove bad data points (E.G. THE SPIKES)
hutssortedresultsdiff=diff(hutsortedresults);
[irow]=find(hutsortedresultsdiff>maxspike);
hutsortedresults(irow,16)=NaN;
%%% remove bad data points (E.G. THE SPIKES)
plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,16),'Color',my_colourh,'LineWidth',1) % mean
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,4),'Color',[0 0 0],'LineWidth',1) % mean
hold on
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
ylim([50 300])
hold on
xlim([startDate endDate])
box on
text(xloclabel,yloclabel,'i')
%clear irow
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
box on
%% Row 4: 36H
h1=subplot(4,3,10,'position',[0.09   0.06   w    h]);
h1p=get(h1,'position');
my_colourd = [255 0 0] ./ 255;

%plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,6),'Color',my_colourd,'LineWidth',1.5) % mean
%datetick('x','mmm-yy','keeplimits')
%datetick('x','mmm-yy','keeplimits')
xlim([startDate endDate])
ylim([50 300])
set(gca, 'FontName', 'ArialMT')
set(gca, 'FontSize', Fsize)
xlabel(' ');
ylabel('TB 36.5H (K)');
hold on;
%% SPIKE REMOVAL DMRT 36H
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,21));
[irow]=find(abs(dmrtsortedresultsdiff)>maxspikemean);
dmrtsortedresults(irow,21)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,21);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,21)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,18));
[irowmin]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmin,18)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,18);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,18)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
dmrtsortedresultsdiff=diff(dmrtsortedresults(:,17));
[irowmax]=find(abs(dmrtsortedresultsdiff)>maxspike);
dmrtsortedresults(irowmax,17)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); 
b=dmrtsortedresults(:,17);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
dmrtsortedresults(:,17)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
drangeX=[datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
drangeY=[dmrtsortedresults(:,18); flipud(dmrtsortedresults(:,17))];              %#create y values for out and then back
dmrtfill=fill(drangeX,drangeY,'r');
set(dmrtfill,'facealpha',.3,'edgecolor','r','edgealpha',0.5) % Plot DMRT min on top
hold on
plot (datenum(num2str(dmrtsortedresults(:,1)),'yyyymmdd'),dmrtsortedresults(:,21),'Color',my_colourd,'LineWidth',1) % mean
ylim([50 300])
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,5),'Color',[0 0 0],'LineWidth',1) % mean
datetick('x','mmm-yy','keepticks')
set(gca,'XTickLabelRotation',25)
hold on
xlim([startDate endDate])
box on
text(xloclabel,yloclabel,'j')
%clear irow
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
hold on
%% SPIKE REMOVAL MEMLS 36H
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,21));
[irow]=find(abs(memlssortedresultsdiff)>maxspikemean);
memlssortedresults(irow,21)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,21);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,21)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,18));
[irowmin]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmin,18)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,18);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,18)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
memlssortedresultsdiff=diff(memlssortedresults(:,17));
[irowmax]=find(abs(memlssortedresultsdiff)>maxspike);
memlssortedresults(irowmax,17)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); 
b=memlssortedresults(:,17);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
memlssortedresults(:,17)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%
% memls
h2=subplot(4,3,11,'position',[0.37   0.06   w    h]);
my_colourm = [0 125 0] ./ 255;
%plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,6),'Color',my_colourm,'LineWidth',1.5) % mean
mrangeX=[datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
mrangeY=[memlssortedresults(:,17); flipud(memlssortedresults(:,18))];              %#create y values for out and then back
memlfill=fill(mrangeX,mrangeY,my_colourm);
set(memlfill,'facealpha',.3,'edgecolor',my_colourm,'edgealpha',0.5)
hold on
plot (datenum(num2str(memlssortedresults(:,1)),'yyyymmdd'),memlssortedresults(:,21),'Color',my_colourm,'LineWidth',1) % mean
set(gca,'YTickLabel',[]);
ylim([50 300])
xlim([startDate endDate])
datetick('x','mmm-yy','keepticks')
set(gca,'XTickLabelRotation',25)
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,5),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'k')
hold on
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
%clear irow
%% SPIKE REMOVAL HUT 36H
h3=subplot(4,3,12,'position',[0.65  0.06   w    h]);
% hut
my_colourh = [0 0 255] ./ 255;
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,21));
[irow]=find(abs(hutsortedresultsdiff)>maxspikemean);
hutsortedresults(irow,21)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,21);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,21)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,18));
[irowmin]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmin,18)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,18);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,18)=xi;
%%% remove bad data points (E.G. THE SPIKES)
%%% remove bad data points (E.G. THE SPIKES)
hutsortedresultsdiff=diff(hutsortedresults(:,17));
[irowmax]=find(abs(hutsortedresultsdiff)>maxspike);
hutsortedresults(irowmax,17)=NaN;
%%% now need to interpolate between NaNs
a=datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); 
b=hutsortedresults(:,18);
xi = interp1( a(~isnan(b)), b(~isnan(b)) , a, 'linear');
hutsortedresults(:,18)=xi;
%%% remove bad data points (E.G. THE SPIKES)

%plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,6),'Color',my_colourh,'LineWidth',1.5,'LineStyle',':') % mean
hrangeX=[datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'); flipud(datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'))]; %#create continuous x value array for plotting
hrangeY=[hutsortedresults(:,17); flipud(hutsortedresults(:,18))];              %#create y values for out and then back
hutfill=fill(hrangeX,hrangeY,'b','edgecolor','b');
set(hutfill,'facealpha',.3,'edgecolor','b','edgealpha',0.5)
hold on
plot (datenum(num2str(hutsortedresults(:,1)),'yyyymmdd'),hutsortedresults(:,21),'Color',my_colourh,'LineWidth',1) % mean
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,5),'Color',[0 0 0],'LineWidth',1) % mean
hold on
ylim([50 300])
set(gca,'YTickLabel',[]);
xlim([startDate endDate])
datetick('x','mmm-yy','keepticks')
set(gca,'XTickLabelRotation',25)
hold on
plot (datenum(num2str( TB_Subset_Obs(:,1)),'yyyymmdd'), TB_Subset_Obs(:,5),'Color',[0 0 0],'LineWidth',1) % mean
hold on
xlim([startDate endDate])
text(xloclabel,yloclabel,'l')
plot([startDateCF startDateCF] ,[50 300],'k:');
hold on
plot([endDateCF endDateCF] ,[50 300],'k:');
box on
%%
cd('/home/leanne/MEL/MEL-FARM/plots')
print('-djpeg','-r800',figure_name)
