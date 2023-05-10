function [ss, depths, ssp, sspFiles, labels] = sspWOA18(siteLon,siteLat)

addpath('c:\analysis\seawater\');
woaFolder = getWoaSoundSpeedFolder;
sspFiles = dir([woaFolder 'woa18_*.mat']);

ss = cell(size(sspFiles));
ssp = cell(size(sspFiles));

for i = 1:length(sspFiles)
    [decade, variable, timePeriod, fieldType, gridSize] = ...
                                      parseWoa18Filename(sspFiles(i).name);
    load(fullfile(sspFiles(i).folder, sspFiles(i).name),...
        'time','lat','lon','depth','c');
    labels{i} = char(woaCode2time(timePeriod));
    
    [~, lonIx] = min(abs(siteLon-lon));
    [~, latIx] = min(abs(siteLat-lat));
    ssLev = squeeze(c(lonIx,latIx,:));
    
    % remove nans
    ix = isnan(ssLev);
    ssLev(ix)=[];
    depth(ix)=[];

    depths{i} = [0:10:200,250:25:500,600:50:1000, 1250:250:4000 4500:500:5500];
    ss{i} = interp1(depth,ssLev,depths{i},'linear','extrap');

    ssp{i} = table(ss{i}',-depths{i}','variableNames',{'c','z'});
end
