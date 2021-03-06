% code to produce Sodankyla meteorological figure for Model Farm paper
% nick.rutter@northumbria.ac.uk
% 14 March 2016

%% Import raw data from a scv file
% Import data from text file.

% Script for importing data from the following text file:
%
%    C:\Nick\Mel\met_2007-10-01_2014-09-30.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/03/14 15:47:39

% Initialize variables.
filename = 'C:\Nick\Mel\met_2007-10-01_2014-09-30.csv';
delimiter = ',';
startRow = 3;

% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

% Close the text file.
fclose(fileID);

% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

% Allocate imported array to column variable names
year2 = dataArray{:, 1};
month2 = dataArray{:, 2};
day2 = dataArray{:, 3};
hour2 = dataArray{:, 4};
SWradiation1 = dataArray{:, 5};
LWradiation1 = dataArray{:, 6};
snowfall1 = dataArray{:, 7};
rainfall1 = dataArray{:, 8};
airtemperature1 = dataArray{:, 9};
relativehumidity1 = dataArray{:, 10};
windspeed1 = dataArray{:, 11};
airpressure1 = dataArray{:, 12};


% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%%
% Create matlab timestamp
DateNumber = datenum(year2,month2,day2,hour2, 0, 0);

% convert air temp from K to C
airtemperature1_degC = airtemperature1 - 273.15; 

% create start and end date vectors to provide limits for plotting graphs
start2011 = datenum('1-Oct-2011');
end2012 = datenum('1-Jun-2012');
start2012 = datenum('1-Oct-2012');
end2013 = datenum('1-Jun-2013');

%%
% plot Ta, SW and precip for winters 2011-12 and 2012-13
figure(1);subplot(3,2,1),plot(DateNumber, airtemperature1_degC, '-k');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([-40 40]);
title('2011-12');
ylabel('Air Temperature (^\circC)','FontSize', 8');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(3,2,2),plot(DateNumber, airtemperature1_degC, '-k');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([-40 40]);
title('2012-13');
ylabel('Air Temperature (^\circC)','FontSize', 8');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(3,2,3),plot(DateNumber, SWradiation1, '-k');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0 800]);
ylabel('SW radiation (W m^{-2})','FontSize', 8');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(3,2,4),plot(DateNumber, SWradiation1, '-k');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0 800]);
ylabel('SW radiation (W m^{-2})','FontSize', 8');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(3,2,5),plot(DateNumber, snowfall1, '-k',...
                              DateNumber, rainfall1, '-b');
tk = datelist(start2011, end2012, 1:1:12);
set(gca, 'xlim', [start2011 end2012], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0 0.002]);
legend('snow','rain','Location','NorthEast');
ylabel('Precipitation (kg m^{-2} s^{-1})','FontSize', 8');
%print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');

figure(1);subplot(3,2,6),plot(DateNumber, snowfall1, '-k',...
                              DateNumber, rainfall1, '-b');
tk = datelist(start2012, end2013, 1:1:12);
set(gca, 'xlim', [start2012 end2013], 'xtick', tk);
datetick('x', 'm', 'keepticks', 'keeplimits');
ylim ([0 0.002]);
legend('snow','rain','Location','NorthEast');
ylabel('Precipitation (kg m^{-2} s^{-1})','FontSize', 8');
print('-r300', '-dpng', 'C:\Nick\Mel\farm_Ta.png');








