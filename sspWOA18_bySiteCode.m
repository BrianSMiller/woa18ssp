%% Find nearest CTD profile for a given sitecode
function [ss, depth, ssp, labels, sspFiles] = ...
    sspWOA18_bySiteCode(siteCode, outFolder, showPlot)
if nargin < 2 || isempty(outFolder)
    outFolder = [pwd 'TL\woa2018\'];
end

if nargin < 3
    showPlot = false;
end

if ~exist(outFolder,'dir')
    mkdir(outFolder);
end

timeCodes = [0 13:16]; % Get all available time codes
seasonType = 'aus';
m = loadRecorderMetaData(siteCode);
switch lower(seasonType)
    case {'biological','bio','austral','aus'}
    % Full year
    [ss, depth, ssp, sspFiles, labels]=sspWOA18(m.longitude,m.latitude,0);
    
    % Austral summer (Dec, Jan, Feb)
    seasons{1} = [12 1 2];  % summer
    seasons{2} = [3 4 5];   % autumn
    seasons{3} = [6 7 8];   % winter
    seasons{4} = [9 10 11]; % spring
    seasonNames = {'summer','autumn','winter','spring'};
    for i = 1:length(seasons)
        j = i + 1;
        tcSum = seasons{i};
        labels{j} = seasonNames{i};
        [sSum, depthSum, sspSum, sspInputsSum, labelSum]=sspWOA18( ...
            m.longitude, m.latitude, tcSum);

        ssp{j} = ssp{1};
        ss{j} = mean(cell2mat(sSum'));
        depth{j} = mean(cell2mat(depthSum'));
        ssp{j}.c = ss{j}';
        ssp{j}.z = -depth{j}';
        
    end

    otherwise
        % Use WOA seasons
        %   13 to 16 – seasonal statistics:
        %   Season 13 – North Hemisphere winter (January - March);
        %   Season 14 – North Hemisphere spring (April - June);
        %   Season 15 – North Hemisphere summer (July - September);
        %   Season 16 – North Hemisphere autumn (October - December);

        [ss, depth, ssp, sspFiles, labels]=sspWOA18(m.longitude,m.latitude,...
            timeCodes);
    end
  
for i = 1:length(labels)
    sspFile = sprintf('woa18_A5B7_c%s_%s.csv',time2WoaCode(labels{i}),siteCode);  
    writetable(ssp{i},[outFolder sspFile]);
end

if showPlot
    figure;
    for i = 1:length(labels)
        plot(ss{i},-depth{i},'lineWidth',0.5);
        hold on;
    end
    legend(labels,'Interpreter','none','location','southwest');
    grid on;
end