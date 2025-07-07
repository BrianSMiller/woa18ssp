function t = woaCode2time(woaCode)
% Return the time-period, t for a given world-ocean atlas code
% TODO: code each month in addition to seasons and annual
if iscell(woaCode) 
    t = cellfun(@woaCode2time, woaCode,'UniformOutput',false);
    return;
end

if isnumeric(woaCode)
    woaCode=sprintf('%02g',woaCode);
end

switch lower(woaCode)
    case '00'
         t = 'year';
    case '01'
        t = 'jan';
    case '02'
        t = 'feb';
    case '03'
        t = 'mar';
    case '04'
        t = 'apr';
    case '05'
        t = 'may';
    case '06'
        t = 'jun';
    case '07'
        t = 'jul';
    case '08'
        t = 'aug';
    case '09'
        t = 'sep';
    case '10'
        t = 'oct';
    case '11'
        t = 'nov';
    case '12'
        t = 'dec';    
    case '13'
        t = 'winter';
    case '14'
        t = 'spring';
    case '15'
        t = 'summer';
    case '16'
        t = 'autumn';
    otherwise
        error(...
            ['Time code must be a two character array of numbers between\n',...
            '00 and 16 corresponding to full year 00, months 01-12, or \n',...
            'austral seasons 13=winter, 14=spring, 15=summer, 16=autumn']);
end