% This script produces Figure 6 (brightess temperature time series for empirical MEMLS-MOS for all JIM members)
% Aims to cycle through TB output
basepath = pwd;
cd ../TBresults_MainFarm_y1/1p0/MEMLS/4p4/0.0/0p1/0/11/Processed

% Set up xaxis tick labels
% Set up dates (Oct-June 2011-2012)
years = [2011; 2011; 2011; 2012; 2012; 2012; 2012; 2012; 2012];
months = [10 11 12 1 2 3 4 5 6];
days = ones(1,9);
ticksTB37 = [200 210 220 230 240 250];

for k = 1:9
dates(k) = datenum(years(k), months(k), days(k));
end

%Set Tick labels
labels = {'O','N','D','J','F','M','A','M','J'};

FileList = dir('MOS_*.txt');
N = size(FileList,1);

% Create sub-figure 1. This is simid X???: densification


snowparameterloc = 5; % Location of identifier in filename
freqpolloc = 5; % location of frequency / pol in Processed results: date tb19v tb19h tb37v tb37h
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
        y = load(filename);
        % Remove bad datapoint %NO SPIKES
        ydiff = diff(y); % Calculates difference from value above %NO SPIKES
        [irow] = find(ydiff(:,freqpolloc)>20); % Find it %NO SPIKES
        y(irow,freqpolloc) = NaN;  % Remove it (not dates) %NO SPIKES
        % Plot graph
        z = plot (datenum(num2str(y(:,1)),'yyyymmdd'),y(:,freqpolloc));
        set(gca, 'FontSize', 18)
        set(gca,'OuterPosition',[0.05 0.05 0.95 0.95]);
        set(z,'Color','k');
        set(gca, 'XTick', dates);
        set(gca, 'YTick', ticksTB37);
        set(gca,'XTickLabel',labels);
        set(gca, 'FontName', 'ArialMT')
        xlabel('2011-2012');
        hold on;
        % Specify axes properties
        axis([734750,735050,200,250]);



end
text (734725, 210, '36.5H Brightness Temperature (K)', 'rotation', 90, 'FontSize', 18, 'FontName','Helvetica');



hold off;
cd (basepath)
% Print MEMLS graph to png file
%print -deps ../farmpaper/Figs/Fig_snowparams_all.eps
%print -dpng ../Fig_snowparams_all.png % CHANGES HERE
%saveas(z,'../Fig_snowparams.png') % CHANGES HERE