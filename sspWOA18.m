function [ssp, sspFiles, labels] = sspWOA18(siteLon,siteLat,timePeriod)
% Derive a sound speed profile for a latitude and longitude from the World
% Ocean Atlas 2018 salinity and temperature as a function of depth. 
% Time periods follow the WOA coding and should be a vector containing
% integers from 0-16
% 1-12 are months of the year;
% 0 is the whole year
% 13-16 are the Austral seasons: Summer (Jan-Mar), Autumn (Apr-Jun), 
%       Winter (Jul-Sep), Spring (Oct-Dec) respectively.
woaFolder = getWoaSoundSpeedFolder;

% If timeperiod is number between 0 and 16
if all(isnumeric(timePeriod)) && all(timePeriod >=0) && all(timePeriod <= 16)
    tp = cell(size(timePeriod));
    for i = 1:length(timePeriod)
        tp{i} = sprintf('%02u',round(timePeriod(i)));
    end
    timePeriod = tp;
elseif ischar(timePeriod)
    timePeriod = cellstr(timePeriod);
end
timePeriod = cellfun(@time2WoaCode,timePeriod,'UniformOutput',false);

for i = 1:length(timePeriod)
    sspFiles(i) = dir(fullfile(getWoaSoundSpeedFolder,...
                              sprintf('woa18_*_c%s_*.mat',timePeriod{i})));
end

ss = cell(size(sspFiles));
ssp = cell(size(sspFiles));

for i = 1:length(sspFiles)
    [decade, variable, timePeriod, gridSize] = ...
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
