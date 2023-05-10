function woaFolder = getWoaSoundSpeedFolder()
woaFolder = 'c:\analysis\woa18ssp\mat\';
if ~exist(woaFolder,'file')
    error(sprintf(['World Ocean Atlas folder, %s does not exist.\n'...
        'Please edit line 2 of %s to point to the correct WOA2018 data folder'],...
        woaFolder, which('getWoaFolder')));
end