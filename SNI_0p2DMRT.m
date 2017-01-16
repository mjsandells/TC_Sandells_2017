% Calculates mean and maximum difference between JIM members for each microstructure-microwave model combination
% Table 9
% SNI and less sticky DMRT-ML
clear all;
% Read in observations file

processobs;

% TB_Subset_Obs is date, 19V, 19H, 37V, 37H
% Simulations are in form date tb19v tb19h tb37v tb37h;

% Aims to cycle through snow model output
% SIMID list
% May be an automatic way to do this
simid = cell(1,63);

simid (1,1) = '0000';
simid (1,2) = '0001';
simid (1,3) = '0002';
simid (1,4) = '0010';
simid (1,5) = '0011';
simid (1,6) = '0012';
simid (1,7) = '0020';
simid (1,8) = '0021';
simid (1,9) = '0022';
simid (1,10) = '0100';
simid (1,11) = '0101';
simid (1,12) = '0102';
simid (1,13) = '0110';
simid (1,14) = '0111';
simid (1,15) = '0112';
simid (1,16) = '0120';
simid (1,17) = '0121';
simid (1,18) = '0122';
simid (1,19) = '0200';
simid (1,20) = '0201';
simid (1,21) = '0202';
simid (1,22) = '0210';
simid (1,23) = '0211';
simid (1,24) = '0212';
simid (1,25) = '0220';
simid (1,26) = '0221';
simid (1,27) = '0222';
simid (1,28) = '1000';
simid (1,29) = '1001';
simid (1,30) = '1002';
simid (1,31) = '1010';
simid (1,32) = '1011';
simid (1,33) = '1012';
simid (1,34) = '1020';
simid (1,35) = '1021';
simid (1,36) = '1022';
simid (1,37) = '1100';
simid (1,38) = '1101';
simid (1,39) = '1102';
simid (1,40) = '1110';
simid (1,41) = '1111';
simid (1,42) = '1112';
simid (1,43) = '1120';
simid (1,44) = '1121';
simid (1,45) = '1122';
simid (1,46) = '1200';
simid (1,47) = '1201';
simid (1,48) = '1202';
simid (1,49) = '1210';
simid (1,50) = '1211';
simid (1,51) = '1212';
simid (1,52) = '1220';
simid (1,53) = '1221';
simid (1,54) = '1222';
simid (1,55) = '2020';
simid (1,56) = '2021';
simid (1,57) = '2022';
simid (1,58) = '2120';
simid (1,59) = '2121';
simid (1,60) = '2122';
simid (1,61) = '2220';
simid (1,62) = '2221';
simid (1,63) = '2222';




% DMRT results-------------------------------------------------------------------------------------------------------

% Want to get a list of directories in the results folder
% Define some top-level folder.
topLevelFolder = '../TBresults_MainFarm_y1/1p0/DMRT/4p4/0.0/0p2/Processed'; % DMRT tau 0.2 ONLY
basepath = pwd;


% Generate list of all subfolders.
% Unfortunately they'll be all in one big long string, separated by colons.
allSubFolders = genpath(topLevelFolder);

% Scan through them separating them.
remain = allSubFolders;
listOfFolderNames = {};
while true % Demo code adapted from the help file.
    [singleSubFolder, remain] = strtok(remain, ':');
    if isempty(singleSubFolder), break; end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end

% Create list of dates from input files
% format will be date, (min, max, cumulative sum, number of values, mean value) repeated for tb19v tb19h tb37v tb37h
all_dates_memls=[];

% Cycle through list of folders
for d = 1:size(listOfFolderNames,2)
    folder = listOfFolderNames{d};
    cd (folder);


    % do stuff
    if ~isempty(dir('*.txt'))
        % Want to find mean, min and max for all empirical memls-MOS model combos
        FileList = dir('SNI*.txt'); % MOS only
        N = size(FileList,1);
        % Initialise TBresults
        TBresults = [];
        for k = 1:N

            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
            % Remove bad datapoint %NO SPIKES
            ydiff = diff(y); % Calculates difference from value above %NO SPIKES
            [irow, icolumn] = find(ydiff(:,2:5)>20); % Find it %NO SPIKES
            y(irow,icolumn+1) = NaN;  % Remove it (not dates) %NO SPIKES %+1 needed because ignoring column 1 in search
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
                    all_dates_memls(irow,17) = y(jj,5);
                    % new min value
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
disp(folder)

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

% Calculate difference between maximum and minimum TB for 37 H
% Min is column 17, max is column 18
differenceH= memlssortedresults(:,18) - memlssortedresults(:,17);
maxdiffH = max(differenceH)
meandiffH = mean(differenceH)


% Calculate difference between maximum and minimum TB for 37 V
% Min is column 12, max is column 13
differenceV = memlssortedresults(:,13) - memlssortedresults(:,12);
maxdiffV = max(differenceV)
meandiffV = mean(differenceV)

%disp(differenceH-differenceV)