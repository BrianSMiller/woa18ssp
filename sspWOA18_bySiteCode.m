%% Find nearest CTD profile for a given sitecode
function [ss, depth, ssp, sspFiles, labels] = ...
    sspWOA18_bySiteCode(siteCode, outFolder, showPlot)
if nargin < 2 || isempty(outFolder)
    outFolder = [pwd '\woa2018\'];
end

if nargin < 3
    showPlot = false;
end

if ~exist(outFolder,'dir')
    mkdir(outFolder);
end

m = loadRecorderMetaData(siteCode);
[ss, depth, ssp, sspInputs, labels]=sspWOA18(m.longitude,m.latitude);
  
for i = 1:length(labels)
    sspFile = sprintf('woa18_A5B7_c%s_%s.csv',time2WoaCode(labels{i}),siteCode);  
    writetable(ssp{i},[outFolder sspFile]);
    if showPlot
        
    end
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