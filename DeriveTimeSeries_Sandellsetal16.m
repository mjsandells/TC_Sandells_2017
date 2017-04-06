% Want to get a list of directories in the results folder
% Define some top-level folder.
clear all
%topLevelFolder = '/home/leanne/MEL/MEL-FARM/TBresults_MainFarm_2012-2013/'
%%% folder 
topLevelFolder = '/home/leanne/MEL/MEL-FARM/TBresults_MainFarm_2011-2012/'
cd '/home/leanne/MEL/MEL-FARM/scripts'
basepath = pwd


% Generate list of all subfolders.
% Unfortunately they'll be all in one big long string, separated by colons.
% allSubFolders = genpath(topLevelFolder); % takes a long time

%Scan through them separating them.
%remain = allSubFolders;
%listOfFolderNames = {};
%while true % Demo code adapted from the help file.
%[singleSubFolder, remain] = strtok(remain, ':');
%if isempty(singleSubFolder), break; end
%listOfFolderNames = [listOfFolderNames singleSubFolder];
%end
%%
% Aims to cycle through snow model output
% SIMID list
% May be an automatic way to do this
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
%%

%load('DirecsnewcompS1mini.mat')
%load('DirecsnewcompS1MEMLSonly.mat')
%load('DirecsnewcompDMRT.mat')
%listOfFolderNames=FileList;
%load('DirecsnewcompHUTMEMLSS2.mat')
load('Direcs_TAUP2DMRTS1.mat')

% Cycle through list of folders 
listOfFolderNames=FileList;

cc=size(listOfFolderNames);
for d=1:size(listOfFolderNames,1) % start at 17
 
d;
    size(listOfFolderNames,1)
    
    folder = listOfFolderNames{d}
    %cd (folder);
    % do stuff
	if ~isempty(dir(strcat(folder,'*.out')))
        % There are output files in these directories
        try
	delete(strcat(folder,'Processed/*.txt'));
	rmdir(strcat(folder,'/Processed/'));
	sprintf('Blah Blah');  
      end
        mkdir (strcat(folder,'Processed'));

        % Process data
       parfor i=1:63
            x = simid{1,i};

            % MOSES
            mos = strcat(folder,'*_',x,'_MOS.dat*.out');
            mosoutput = strcat(folder,'Processed/MOS_',x,'.txt');
            FileList = dir(mos);
            %FileList = evalc('dir(mos)')
            N = size(FileList,1);
            % Initialise TBresults
            TBresults = [];
            for k = 1:N

                % get the file name:
                filename = strcat(folder,FileList(k).name);

                try
                    y=load(filename);
                    tb19v=y(1,3);
                    tb19h=y(1,4);
                    tb37v=y(2,3);
                    tb37h=y(2,4);

                    % Extract date from filename
                     if (FileList(k).name(1) == 'd')
                        % This is a dmrtml output file
                        date = str2double(FileList(k).name(8:15));
                    elseif (FileList(k).name(1) == 'm')
                        % This is a memls output file
                        date = str2double(FileList(k).name(13:20));
                    elseif (FileList(k).name(1) == 'h')
                        % This is a hut output file
                        date = str2double(FileList(k).name(16:23));
                    else
                        % Unknown output file
                        date = NaN;
                    end

                    % Collate results for that day and date
                    TBresults=[TBresults; date tb19v tb19h tb37v tb37h];

              end % try statement
            end

            % Write results to file
            parforsaveacii(mosoutput,TBresults, '-ascii');

            % SNICAR
            sni = strcat(folder,'*_',x,'_SNI.dat*.out');
            snioutput = strcat(folder,'Processed/SNI_',x,'.txt');
            FileList = dir(sni);
            N = size(FileList,1);
            % Initialise TBresults
            TBresults = [];
            for k = 1:N

                % get the file name:
                filename = strcat(folder,FileList(k).name);
               try
                    y=load(filename);
                    tb19v=y(1,3);
                    tb19h=y(1,4);
                    tb37v=y(2,3);
                    tb37h=y(2,4);

                      % Extract date from filename
                     if (FileList(k).name(1) == 'd')
                        % This is a dmrtml output file
                        date = str2double(FileList(k).name(8:15));
                    elseif (FileList(k).name(1) == 'm')
                        % This is a memls output file
                        date = str2double(FileList(k).name(13:20));
                    elseif (FileList(k).name(1) == 'h')
                        % This is a hut output file
                        date = str2double(FileList(k).name(16:23));
                    else
                        % Unknown output file
                        date = NaN;
                    end

                    % Collate results for that day and date
                    TBresults=[TBresults; date tb19v tb19h tb37v tb37h];

                end % try statement

            end
            % Write results to file
            parforsaveacii(snioutput, TBresults, '-ascii');

            % SNTHERM
            snt = strcat(folder,'*_',x,'_SNT.dat*.out');
            sntoutput = strcat(folder,'Processed/SNT_',x,'.txt');
            FileList = dir(snt);
            N = size(FileList,1);
            % Initialise TBresults
            TBresults = [];
            for k = 1:N

                % get the file name:
                filename = strcat(folder,'/',FileList(k).name);
                try
                    y=load(filename);
                    tb19v=y(1,3);
                    tb19h=y(1,4);
                    tb37v=y(2,3);
                    tb37h=y(2,4);

                     % Extract date from filename
                     if (FileList(k).name(1) == 'd')
                        % This is a dmrtml output file
                        date = str2double(FileList(k).name(8:15));
                    elseif (FileList(k).name(1) == 'm')
                        % This is a memls output file
                        date = str2double(FileList(k).name(13:20));
                    elseif (FileList(k).name(1) == 'h')
                        % This is a hut output file
                        date = str2double(FileList(k).name(16:23));
                    else
                        % Unknown output file
                        date = NaN;
                    end
                    % Collate results for that day and date
                    TBresults=[TBresults; date tb19v tb19h tb37v tb37h];

                end % try statement

            end
            % Write results to file
            parforsaveacii(sntoutput, TBresults, '-ascii');

        end % End of processing of one JIM flavour


end % If statement

    % Get back into scripts directory to be able to enter the next directory
    %cd (basepath);

end % Loop over all subdirectories

