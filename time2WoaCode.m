function woaCode = time2woa(t)
% Return the world ocean atlas code fora  given time, t
% TODO: code each month in addition to seasons and annual
switch lower(t)
    case {'year','all','fullyear'}
         woaCode = '00';
    case {'01','jan','january'}
        woaCode = '01';
    case {'02','feb','february'}
        woaCode = '02';    
    case {'03','mar','march'}
        woaCode = '03';
    case {'04','apr','april'}
        woaCode = '04';
    case {'05','may','may'}
        woaCode = '05';
    case {'06','jun','june'}
        woaCode = '06';
    case {'07','jul','july'}
        woaCode = '07';
    case {'08','aug','august'}
        woaCode = '08';
    case {'09','sep','september'}
        woaCode = '09';
    case {'10','oct','october'}
        woaCode = '10';
    case {'11','nov','november'}
        woaCode = '11';
    case {'12','dec','december'}
        woaCode = '12';
    case 'winter'
        woaCode = '13';
    case 'spring'
        woaCode = '14';
    case 'summer'
        woaCode = '15';
    case {'autumn','fall'}
        woaCode = '16';
    
    otherwise
        error('Season must be one of [winter, spring, summer, autumn, all]');
end