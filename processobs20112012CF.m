% Read in observations file
basepath = pwd;
addpath(basepath);

%%%%%%%%%%%%%%%%%%%%% User modified section
% Change directory into where results are held
cd('/home/leanne/MEL/MEL-FARM/observations/')
% get the file name:
%%%% Not need to change lines 35-38 to yyyy/mm/dd HH:MM:SS for 2012-2013 season.
%%%% 2011-2012 just is  dd/mm/yy HH:MM
fid = fopen('NOSREX_sodrad_tb_avgs_2011_2012.csv','rt');  % YR1 CHANGES HERE
inputstartdate='011111'
inputenddate='310312'
%%%%%%%%%%%%%%%%%%%%% User modified section

% Specify format of input file
nNumberCols = 64;
format = ['%s' repmat('%f', [1 nNumberCols])];
a = textscan(fid, format,'Delimiter',',','CollectOutput',1,'HeaderLines',1);
fclose(fid);

% Determine which columns are needed.
% Currently only looking at 50 deg incidence, 19, 37 GHz
% Column numbers are one less than in excel file due to the way the information
% is read in and stored by code above
% 19H is column 35
% 19V is column 36
% 37H is column 39
% 37V is column 40


% Reformat data from observation file
% Not entirely sure why but a{1} contains the date and a{2} contains TB
% x in a{2}(:,x) relates to column numbers above
M19H = [datenum(a{1},'dd/mm/yy HH:MM') a{2}(:,35)]; % YR 1 CHANGES HERE
M19V = [datenum(a{1},'dd/mm/yy HH:MM') a{2}(:,36)]; % YR 1 CHANGES HERE
M37H = [datenum(a{1},'dd/mm/yy HH:MM') a{2}(:,39)]; % YR 1 CHANGES HERE
M37V = [datenum(a{1},'dd/mm/yy HH:MM') a{2}(:,40)]; % YR 1 CHANGES HERE
M19H(M19H== 99999) = NaN;
M19V(M19V== 99999) = NaN;
M37H(M37H== 99999) = NaN;
M37V(M37V== 99999) = NaN;



Time1=10/24;
Time2=14/24;

Datestart=datenum(inputstartdate,'ddmmyy')+Time1;
Dateend=datenum(inputenddate,'ddmmyy')+Time2;

j=0;

for i=1:length(M19H)
    Currentdate=M19H(i,1);

    if Currentdate >= Datestart && Currentdate <= Dateend
        Currenthour=(Currentdate-floor(Currentdate));
        if abs(Currenthour-10/24) < 1/48 % tolerance
            % keep
            j=j+1;
%            TB_Subset_Obs(j,1)=floor(Currentdate) + 0.5; % THIs is good for plotting
            TB_Subset_Obs(j,1)=str2num(datestr(floor(Currentdate),'yyyymmdd')); % This is good for cost function
            both19V = [M19V(i,2),M19V(i+1,2)];
            TB_Subset_Obs(j,2)=nanmean(both19V);
            both19H = [M19H(i,2),M19H(i+1,2)];
            TB_Subset_Obs(j,3)=nanmean(both19H);
            both37V = [M37V(i,2),M37V(i+1,2)];
            TB_Subset_Obs(j,4)=nanmean(both37V);
            both37H = [M37H(i,2),M37H(i+1,2)];
            TB_Subset_Obs(j,5)=nanmean(both37H);
        end
    end


end

% TB_Subset_Obs is date, 19V, 19H, 37V, 37H

cd (basepath);

