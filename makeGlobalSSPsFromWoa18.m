% Create global sound speed profiles using salinity and temperature data
% from the world ocean atlas 2018 (WOA18). 
function makeGlobalSSPsFromWoa18(pathToWoa18data, pathToSaveSsps, decade, gridSize)


% Lists of valid input options
decades = {'5564','6574','7584','8594','95A4','A5B7','decav','all'};
gridSizes = {'1.00','5deg','0.25'};


if ~exist(pathToWoa18data,'dir')
    base = '\\aad.gov.au\files\Ecological_Informatics\data\gridded\data\';
    subFolder  = 'www.ncei.noaa.gov\data\oceans\woa\WOA18\DATA\';
    pathToWoa18data = fullfile(base,subFolder);
end

if nargin<2 || ~exist(pathToSaveSsps,'dir')
    pathToSaveSsps= uigetdir(pwd,'Select folder to save sound speed profiles:');
end

if nargin < 3
    decade = 'decav';
end
if nargin < 4 
    gridSize='0.25';
end

% Check that inputs are valid
if ~any(strcmpi(decade,decades))
    errMessage = [sprintf('Error: decade must be one of:\n'),...
                  sprintf('\t\t%s\n',decades{:})];
    error(errMessage);
end


if ~any(strcmpi(gridSize,gridSizes))
    errMessage = [sprintf('Error: gridSize must be one of:\n'),...
                  sprintf('\t\t%s\n',gridSizes{:})];
    error(errMessage);
end
addpath('c:\analysis\seawater\');

tempSubPath = sprintf('temperature\\netcdf\\%s\\%s\\', decade, gridSize);
salSubPath = sprintf('salinity\\netcdf\\%s\\%s\\', decade, gridSize);
tempPath = fullfile(pathToWoa18data, tempSubPath);
salPath = fullfile(pathToWoa18data, salSubPath);
tempFiles = dir([tempPath '*.nc']);
salFiles = dir([salPath '*.nc']);

if isempty(tempFiles) || isempty(salFiles)
    error('No valid woa18 temperature or salinity netcdf files not found.');
end
% tempFullFile = [tempFiles(1).folder filesep tempFiles(1).name];
% info = ncinfo(tempFullFile);
% ncVars = {info.Variables.Name};

%%
tic;
for f = 1:length(tempFiles)
    tempFullFile = [tempFiles(f).folder filesep tempFiles(f).name];
    salFullFile = [salFiles(f).folder filesep salFiles(f).name];

    [decade, ~, timePeriod, gridSize]= ...
                                    parseWoa18Filename(tempFiles(f).name);
    fieldType = 'an';
    time = ncread(tempFullFile,'time');
    lat = ncread(tempFullFile,'lat');
    lon = ncread(tempFullFile,'lon');
    depth = ncread(tempFullFile,'depth');
    
    tMean = ncread(tempFullFile,['t_' fieldType]);
    sMean = ncread(salFullFile,['s_' fieldType]);
    
    variable = 'c';
    sspFile = makeWoa18Filename(decade,variable,timePeriod,gridSize);
    sspFullFile = fullfile(pathToSaveSsps,sspFile);
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
    toc;
end