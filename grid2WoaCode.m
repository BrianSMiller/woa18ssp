function [woaCode, woaSubPathCode] = var2WoaCode(t)
% Return the world ocean atlas code fora  given time, t
% TODO: code each month in addition to seasons and annual
switch lower(t)
    case {5,'5deg','5','5d'}
         woaCode = '5d';
         woaSubPathCode = '5deg';
    case {1,'1','01','1.00'}
        woaCode = '01';
        woaSubPathCode = '1.00';
    case {0.25,'0.25','4','04'}
        woaCode = '04';    
        woaSubPathCode = '0.25';
    otherwise
        error('Grid size must be one of [0.25 1 5] ');
end