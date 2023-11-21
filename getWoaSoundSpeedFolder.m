function woaFolder = getWoaSoundSpeedFolder(decade)
woaFolder = 'S:\data\woa18\mat\';

if nargin < 1 || ~exist(fullfile(woaFolder,decade,'\'),'dir')
    decade = 'A5B7';
end
woaFolder = fullfile(woaFolder,decade,'\');

if ~exist(woaFolder,'dir')
    errorStr = ['World Ocean Atlas folder, %s does not exist.\n'...
        'Please edit line 2 of %s to point to the correct WOA2018',...
        'data folder'];
    error(errorStr, woaFolder, which('getWoaSoundSpeedFolder'));
end