% Read data from Wolrd Ocean Atlas from locally stored netcdf file
function [data,lon,lat,depth] = readWoa18Local(variable, decade, time, gridSize)

pathToWoa18data = getAADWoa18Path();

% Lists of valid input options
variables = {'AOU','conductivity','density','mld','nitrate','o2sat',...
    'oxygen','phosphate','salinity','silicate','temperature'};
decades = {'5564','6574','7584','8594','95A4','A5B7','decav','all'};
gridSizes = {'1.00','01','1','5deg','0.25'};

if nargin < 2
    decade = 'decav';
end

timeCode = time2WoaCode(time);


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

if ~any(strcmpi(variable,variables))
    errMessage = [sprintf('Error: variable must be one of:\n'),...
                  sprintf('\t\t%s\n',variables{:})];
    error(errMessage);
end
varCode = var2WoaCode(variable);
[gridCode, gridPathCode] = grid2WoaCode(gridSize);


% Chemistry variables don't follow the decade subfolder structure and are
% just stored under all. Also they only have gridsizes of 1 or 5 degree
if any(strcmp(variable,{'AOU','nitrate','phosphate','silicate','oxygen','o2sat'}))
    decade = 'all'
    if gridCode=='04'
        error('Chemistry variables do not have 0.25 degree resolution.\n Please use 1 or 5 degree instead')
    end
end
    
subPath = sprintf('%s\\netcdf\\%s\\%s\\',variable, decade, gridPathCode);
fullPath = fullfile(pathToWoa18data, subPath);
files = dir([fullPath '*.nc']);

file = makeWoa18Filename(decade,varCode,timeCode,gridCode);

f = fullfile(fullPath,[file '.nc']); 
if ~exist(f,'file')
    error(sprintf('Looking for %s, but file found.',f));
end

%%
tic;

[decade, ~, timePeriod, gridSize]= parseWoa18Filename(f);
fieldType = 'an';
time = ncread(f,'time');
lat = ncread(f,'lat');
lon = ncread(f,'lon');
depth = ncread(f,'depth');
data = ncread(f,[varCode '_' fieldType]);

toc;
