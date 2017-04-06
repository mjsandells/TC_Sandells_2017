%clearvars -except CF_total_nomelt CF_minima_nomelt CF_overall_nomelt
% Read in observations file
clear all
w = warning ('off','all');

filenamesave='S1_GSF_complex0_DMRTonlyTAUp2.mat'
processobs20112012CF; % there are lines to edit in this file before execution
load('GSFnames.mat')

% TB_Subset_Obs is date, 19V, 19H, 37V, 37H
% Simulations are in form date tb19v tb19h tb37v tb37h;

%%%% ALSO REMEMEMBER TO SWEEP THE CODE FOR DIALECTRIC VALUE AND CHANGE
%%%% DEPENDANT ON SEASON
% Define some top-level folder.
topLevelFolder = '/home/leanne/MEL/MEL-FARM/TAUp2/TBresults_MainFarm_2011-2012/';


%gsffolders = dir(topLevelFolder);
for k = length(gsffolders):-1:1
    % remove non-folders
    if ~gsffolders(k).isdir
        gsffolders(k) = [ ];
    continue
    end

    % remove folders starting with .
    fname = gsffolders(k).name;
    if fname(1) == '.'
        gsffolders(k) = [ ];
    end
end

% Directory Structure is now hard-coded

% DMRT_non = 'DMRT/4p6/0.0/1e6/Processed/';
% DMRT_sticky = 'DMRT/4p6/0.0/0p1/Processed/';
DMRT_TAUp2 = 'DMRT/4p4/0.0/0p2/Processed/'
% MEMLS_IBA = 'MEMLS/4p6/0.0/0p1/0/12/Processed/';
% MEMLS_EMP = 'MEMLS/4p6/0.0/0p1/0/11/Processed/';
% HUT_H87 = 'HUT/4p6/0.0/0p1/0/Processed/';
% HUT_R04 = 'HUT/4p6/0.0/0p1/1/Processed/';
% HUT_K10 = 'HUT/4p6/0.0/0p1/2/Processed/';
% 

% Initialize cost function for each gsf
% REMEMBER: cost function row will be (DMRT-non, DMRT-sticky, MEMLS-IBA, MEMLS-EMP, HUT-H87, HUT-R04, HUT-K10) for SNT, MOS, SNI
% cost function columns will be gsf in order
% CF_total=zeros(21,size(gsffolders));
% CF_num_data=zeros(21,size(gsffolders)); % Need to know how many data points there are to normalize cost function
 
%LMW
CF_total=zeros(21,length(gsffolders));
CF_num_data=zeros(21,length(gsffolders)); % Need to know how many data points there are to normalize cost function


% Get into results Directory
cd (topLevelFolder);


% Loop over gsffolders
for gsf=1:size(gsffolders)
    % Reset cost function row
    costfnrow = 1;
gsf
    % get into GSF folder
    cd (gsffolders(gsf).name);
    returnfolder = pwd;

    % Loop over 7 EM model combinations
    for em=8
        % Decide which folder to switch into
        if em==1
            mkdir(DMRT_non)
            cd (DMRT_non)
        elseif em==2
            mkdir(DMRT_sticky)
            cd (DMRT_sticky)
        elseif em==3
            mkdir(MEMLS_IBA)
            cd (MEMLS_IBA)
        elseif em==4
            mkdir(MEMLS_EMP)
            cd (MEMLS_EMP)
        elseif em==5
            mkdir(HUT_H87)
            cd (HUT_H87)
        elseif em==6
            mkdir(HUT_R04)
            cd (HUT_R04)
        elseif (em==7)
            mkdir(HUT_K10)
            cd (HUT_K10)
        elseif (em==8)
                mkdir(DMRT_TAUp2)
                cd(DMRT_TAUp2)
        else
            disp ('problem with EM model case');
        end

        % Calculate COST FUNCTION for SNT runs
        FileList = dir('SNT_*.txt');
        N = size(FileList,1);

        for k = 1:N
            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
            if (isempty(y) == 1 )
            disp('ERRRRROORRRRR WITH EMPTY FILE')
            end
                      CFnumberstruct=0;
            CFstruct=0;

            % Loop over rows (dates) in processed files
            for jj = 1:size(y,1)
                % Identify date
                search_date = y(jj,1);
                % Try to look for it in the TB_Subset_Obs matrix
                if any(TB_Subset_Obs(:,1)==search_date)
                    % can use data in cost function
                    % Find out where it is
                    [irow,icolumn] = find(TB_Subset_Obs==search_date);
                    cf_error_term = nansum((y(jj,2:5)-TB_Subset_Obs(irow,2:5))./2).^2;
                    num_terms = sum(~isnan(y(jj,2:5)- TB_Subset_Obs(irow,2:5)));
                    %[num_terms,jj,TB_Subset_Obs(irow,1),y(jj,1) ];
                    % Only add if cf_error_term is not NaN
                    if ~isnan(cf_error_term)
                        CF_total(costfnrow,gsf) = CF_total(costfnrow,gsf) + cf_error_term;
                        CF_num_data(costfnrow,gsf) = CF_num_data(costfnrow,gsf) + num_terms;
                             CFnumberstruct=CFnumberstruct+1;
                        CFstruct=CFstruct+cf_error_term;
                    end % cf_error_term is not NaN
                end % if date exists
            end %loop over dates within SNT file
          SNT_CFvalues(em).f(k,gsf,:)=CFstruct./CFnumberstruct;
          SNT_CFnumterms(em).f(k,gsf,:)=CFnumberstruct;
        end % loop over SNT files

 % Calculate COST FUNCTION for MOS runs
        FileList = dir('MOS_*.txt');
        N = size(FileList,1);
        for k = 1:N
            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
            % Loop over rows (dates) in processed files
            CFnumberstruct=0;
            CFstruct=0;
            for jj = 1:size(y,1)
                % Identify date
                search_date = y(jj,1);
                % Try to look for it in the TB_Subset_Obs matrix
                if any(TB_Subset_Obs(:,1)==search_date)
                    % can use data in cost function
                    % Find out where it is
                    [irow,icolumn] = find(TB_Subset_Obs==search_date);
                    cf_error_term = nansum((y(jj,2:5)- TB_Subset_Obs(irow,2:5))./2).^2;
                    num_terms = sum(~isnan(y(jj,2:5)- TB_Subset_Obs(irow,2:5)));
                    % Only add if cf_error_term is not NaN
                    if ~isnan(cf_error_term)
                        CF_total(costfnrow+7,gsf) = CF_total(costfnrow+7,gsf) + cf_error_term;
                        CF_num_data(costfnrow+7,gsf) = CF_num_data(costfnrow+7,gsf) + num_terms;
                        CFnumberstruct=CFnumberstruct+1;
                        CFstruct=CFstruct+cf_error_term;
                    end % cf_error_term is not NaN
                end % if date exists
            end %loop over dates within SNT file
          MOS_CFvalues(em).f(k,gsf,:)=CFstruct./CFnumberstruct;
          MOS_CFnumterms(em).f(k,gsf,:)=CFnumberstruct;

        end % loop over SNT files

        
 % Calculate COST FUNCTION for SNI runs
        FileList = dir('SNI_*.txt');
        N = size(FileList,1);
        for k = 1:N
            % get the file name:
            filename = FileList(k).name;
            y = load(filename);
                      CFnumberstruct=0;
            CFstruct=0;
            % Loop over rows (dates) in processed files
            for jj = 1:size(y,1)
                % Identify date
                search_date = y(jj,1);
                % Try to look for it in the TB_Subset_Obs matrix
                if any(TB_Subset_Obs(:,1)==search_date)
                    % can use data in cost function
                    % Find out where it is
                    [irow,icolumn] = find(TB_Subset_Obs==search_date);
                    cf_error_term = nansum((y(jj,2:5)- TB_Subset_Obs(irow,2:5))./2).^2;
                    num_terms = sum(~isnan(y(jj,2:5)- TB_Subset_Obs(irow,2:5)));                 
                    % Only add if cf_error_term is not NaN
                    if ~isnan(cf_error_term)
                        CF_total(costfnrow+14,gsf) = CF_total(costfnrow+14,gsf) + cf_error_term;
                        CF_num_data(costfnrow+14,gsf) = CF_num_data(costfnrow+14,gsf) + num_terms;
                           CFnumberstruct=CFnumberstruct+1;
                        CFstruct=CFstruct+cf_error_term;
                    end % cf_error_term is not NaN
                end % if date exists
            end %loop over dates within SNT file
          SNI_CFvalues(em).f(k,gsf,:)=CFstruct./CFnumberstruct;
          SNI_CFnumterms(em).f(k,gsf,:)=CFnumberstruct;

        
        end % loop over SNT files

        
        
        
        cd (returnfolder);

        % Next cost function
        costfnrow = costfnrow + 1;
    end % loop over EM model

    % last thing: get back into topLevelFolder
    cd ..
end % loop over gsf

% Get back into scripts folder
cd (basepath);

% Calculate overall CF
CF_overall = CF_total ./ CF_num_data;

CF_minima = zeros(21,1);
% find minimum
%for ii = 1:length(CF_overall(:,1),1)
for ii = 1:7:size(CF_overall(:,1),1) % Jump of 7 for DMRTML only
    min_val = min(CF_overall(ii,:));
    [minrow,mincol]= find(CF_overall(ii,:)==min_val);
    CF_minima(ii) = mincol;
end



for mm=1:7
        Mean_per_GSF_SNI(mm,:)=nanmean(SNI_CFvalues(mm).f);
        MStd_per_GSF_SNI(mm,:)=nanstd(SNI_CFvalues(mm).f);
        Mean_per_GSF_SNT(mm,:)=nanmean(SNT_CFvalues(mm).f);
        MStd_per_GSF_SNT(mm,:)=nanstd(SNT_CFvalues(mm).f);
        Mean_per_GSF_MOS(mm,:)=nanmean(MOS_CFvalues(mm).f);
        MStd_per_GSF_MOS(mm,:)=nanstd(MOS_CFvalues(mm).f);
        Nobs_per_GSF_SNI(mm,:)=nansum(SNI_CFnumterms(mm).f);
        Nobs_per_GSF_SNT(mm,:)=nansum(SNT_CFnumterms(mm).f);
        Nobs_per_GSF_MOS(mm,:)=nansum(MOS_CFnumterms(mm).f);
        min_val_SNI(mm) = min(Mean_per_GSF_SNI(mm,:));
        [SNIminrow(mm),SNImincol(mm)]=find(Mean_per_GSF_SNI(mm,:)==min_val_SNI(mm));
        min_val_SNT(mm) = min(Mean_per_GSF_SNT(mm,:));
        [SNTminrow(mm),SNTmincol(mm)]=find(Mean_per_GSF_SNT(mm,:)==min_val_SNT(mm));
        min_val_MOS(mm) = min(Mean_per_GSF_MOS(mm,:));
        [MOSminrow(mm),MOSmincol(mm)]=find(Mean_per_GSF_MOS(mm,:)==min_val_MOS(mm));
        
        % do ttest against other values. All we are doing is comparing
        % means in an unpaired test. We hope there is Normality!
        SNIminimavalmean(mm)=min_val_SNI(mm);
        SNIminimalvalstd(mm)=MStd_per_GSF_SNI(SNImincol(mm));
        MOSminimavalmean(mm)=min_val_MOS(mm);
        MOSminimalvalstd(mm)=MStd_per_GSF_MOS(MOSmincol(mm));
        SNTminimavalmean(mm)=min_val_SNT(mm);
        SNTminimalvalstd(mm)=MStd_per_GSF_SNT(SNTmincol(mm));    
        for gsf=1:length(gsffolders);
        TTEST_SNI_vs_MINIMA(mm,gsf)=ttest2(SNI_CFvalues(mm).f(:,gsf,:),SNI_CFvalues(mm).f(:,SNImincol(mm)));
        TTEST_SNT_vs_MINIMA(mm,gsf)=ttest2(SNT_CFvalues(mm).f(:,gsf,:),SNT_CFvalues(mm).f(:,SNTmincol(mm)));
        TTEST_MOS_vs_MINIMA(mm,gsf)=ttest2(MOS_CFvalues(mm).f(:,gsf,:),MOS_CFvalues(mm).f(:,SNTmincol(mm)));
        end

end
   


    
    
    
cd(topLevelFolder)
cd('../scripts/')

save(filenamesave)
