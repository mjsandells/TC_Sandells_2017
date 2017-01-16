% This script produces figure 7
% Aims to cycle through TB output
basepath = pwd;
cd ../TBresults_MainFarm_y1/1p0/MEMLS/4p4/0.0/0p1/0/11/Processed


ticksTB37 = [200 210 220 230 240 250];
ticksmod = [0.5 1.5 2.5];
%Set Tick labels
modlabels = {'0','1','2'};

FileList = dir('MOS_*.txt');
N = size(FileList,1);

% Create sub-figure 1. This is simid X???: densification

h=figure('position', [0, 0, 1200, 1200])  % create new figure with specified size
subplot(2,2,1)%,'position',[0,0,0.5,0.5])

snowparameterloc = 5; % Location of identifier in filename
freqpolloc = 5; % location of frequency / pol in Processed results: date tb19v tb19h tb37v tb37h
datesearch = 20120201;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'k','MarkerSize', 12);
        set(gca, 'XTick', ticksmod);
        set(gca, 'YTick', ticksTB37);
        set(gca,'XTickLabel',modlabels);
        set(gca, 'FontName', 'ArialMT')
        set(gca, 'FontSize', 12)
        ylabel('36.5H Brightness Temperature (K)');
        title('Snow densification')
        hold on;
        % Specify axes properties
        axis([0,3,200,250]);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    end



end

% Do it all again for a different date: 1st May
datesearch = 20120501;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    end



end

% -------------- Manual Legend ---------------------------------------------------

%text (1, 245, "1st Feb", 'color','k','fontname','arial', 'fontsize',12);
%text (2, 245, "1st May", 'color','r','fontname','arial', 'fontsize',12);


% Create sub-figure 2. This is simid ?X??:
subplot(2,2,2)%,'position',[0,0.5,0.5,1])

snowparameterloc = 6; % Location of identifier in filename
freqpolloc = 5; % location of frequency / pol in Processed results: date tb19v tb19h tb37v tb37h
datesearch = 20120201;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'k','MarkerSize', 12);
        set(gca, 'XTick', ticksmod);
        set(gca, 'YTick', ticksTB37);
        set(gca,'XTickLabel',modlabels);
        set(gca, 'FontName', 'ArialMT')
        set(gca, 'FontSize', 12)
        %ylabel('36.5H Brightness Temperature (K)');
        %xlabel('2011-2012');
        title('Thermal Conductivity')
        hold on;
        % Specify axes properties
        axis([0,3,200,250]);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    end



end

% Do it all again for a different date: 1st May
datesearch = 20120501;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    end



end

% Create sub-figure 3. This is simid ??X?:
subplot(2,2,3)%,'position',[0.5,0.5,0,0.5])

snowparameterloc = 7; % Location of identifier in filename
freqpolloc = 5; % location of frequency / pol in Processed results: date tb19v tb19h tb37v tb37h
datesearch = 20120201;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'k','MarkerSize', 12);
        set(gca, 'XTick', ticksmod);
        set(gca, 'YTick', ticksTB37);
        set(gca,'XTickLabel',modlabels);
        set(gca, 'FontName', 'ArialMT')
        set(gca, 'FontSize', 12)
        ylabel('36.5H Brightness Temperature (K)');
        xlabel('Model Parameterization');
        title('Fresh Snow Density')
        hold on;
        % Specify axes properties
        axis([0,3,200,250]);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    end



end

% Do it all again for a different date: 1st May
datesearch = 20120501;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    end



end




% Create sub-figure 4. This is simid ???X:
h4=subplot(2,2,4)%,'position',[0.5,0.5,0,0.5];

snowparameterloc = 8; % Location of identifier in filename
freqpolloc = 5; % location of frequency / pol in Processed results: date tb19v tb19h tb37v tb37h
datesearch = 20120201;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'k','MarkerSize', 12);
        set(gca, 'XTick', ticksmod);
        set(gca, 'YTick', ticksTB37);
        set(gca,'XTickLabel',modlabels);
        set(gca, 'FontName', 'ArialMT')
        set(gca, 'FontSize', 12)
        %ylabel('36.5H Brightness Temperature (K)');
        xlabel('Model Parameterization');
        title('Snow Hydrology')
        hold on;
        % Specify axes properties
        axis([0,3,200,250]);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'k','MarkerSize', 12);
    end



end

% Do it all again for a different date: 1st May
datesearch = 20120501;
for k = 1:N
    % This loops over all MOS files
    filename = FileList(k).name;
    % Look at compaction group 0
    if (str2num(filename(snowparameterloc)) == 0)
        y = load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (0.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    elseif (str2num(filename(snowparameterloc)) == 1)
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (1.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    else
        y=load(filename);
        % Find date
        [irow,icolumn] = find(y==datesearch);
        % Plot graph
        z = plot (2.5,y(irow,freqpolloc),'r','MarkerSize', 12);
    end



end

set(h, 'color', 'w');

hold off;
cd (basepath)
% Print MEMLS graph to png file
print -dpng ../farmpaper/Figs/Fig_cluster_analysis.png % CHANGES HERE
%saveas(h,'../farmpaper/Figs/Fig_snowparams.png') % CHANGES HERE