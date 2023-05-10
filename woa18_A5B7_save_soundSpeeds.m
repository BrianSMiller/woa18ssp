%% Load woa2018 temperature and salinity and calculate speed of sound
addpath('C:\analysis\woa18\');
addpath('c:\analysis\seawater\');


aadShare = '\\aad.gov.au\files\Ecological_Informatics\data\gridded\data\';
woaURL = 'www.ncei.noaa.gov\data\oceans\woa\WOA18\DATA\'
tempSubPath = 'temperature\netcdf\A5B7\0.25\';
salSubPath = 'salinity\netcdf\A5B7\0.25\';
tempPath = [aadShare woaURL tempSubPath];
salPath = [aadShare woaURL salSubPath];
tempFiles = dir([tempPath '*.nc']);
salFiles = dir([salPath '*.nc']);
tempFullFile = [tempFiles(1).folder filesep tempFiles(1).name];
salFullFile = [salFiles(1).folder filesep salFiles(1).name];

info = ncinfo(tempFullFile);
ncVars = {info.Variables.Name};

%%
tic;
for f = 1:length(tempFiles)
    tempFullFile = [tempFiles(f).folder filesep tempFiles(f).name];
    salFullFile = [salFiles(f).folder filesep salFiles(f).name];

    [decade, ~, timePeriod, gridSize] = ...
        parseWoa18NetcdfFilename(tempFiles(f).name);
    fieldType = 'an';
    
    time = ncread(tempFullFile,'time');
    lat = ncread(tempFullFile,'lat');
    lon = ncread(tempFullFile,'lon');
    depth = ncread(tempFullFile,'depth');
    
    tMean = ncread(tempFullFile,['t_' fieldType]);
    sMean = ncread(salFullFile,['s_' fieldType]);
    
    variable = 'c';
    sspFile = sprintf('woa18_%s_%s%s%s%s.mat',decade,variable,...
        timePeriod,fieldType,gridSize);
    sspFullFile = [getWoaSoundSpeedFolder sspFile];
    fprintf('Working on file %s (%g/%g)',sspFullFile,f,length(tempFiles));
    %%
    c = nan(size(tMean));
    for i = 1:length(lon)
        for j = 1:length(lat)
            c(i,j,:) = sw_svel(squeeze(sMean(i,j,:)),squeeze(tMean(i,j,:)),...
                depth);
        end
    end
    save(sspFullFile,'c','time','lon','lat','depth');

    % visualize the data
    % s = slice(c,360,720,1,'nearest'); 
    % set(s,'lineStyle','none');
    toc;
end