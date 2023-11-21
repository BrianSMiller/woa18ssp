function woaCode = time2woa(t)
% Return the world ocean atlas code fora  given time, t
% TODO: code each month in addition to seasons and annual
switch lower(t)
    case {'year','all','fullyear',0,'00','0'}
         woaCode = '00';
    case {'01','jan','january',1}
        woaCode = '01';
    case {'02','feb','february',2}
        woaCode = '02';    
    case {'03','mar','march',3}
        woaCode = '03';
    case {'04','apr','april',4}
        woaCode = '04';
    case {'05','may','may',5}
        woaCode = '05';
    case {'06','jun','june',6}
        woaCode = '06';
    case {'07','jul','july',7}
        woaCode = '07';
    case {'08','aug','august',8}
        woaCode = '08';
    case {'09','sep','september',9}
        woaCode = '09';
    case {'10','oct','october',10}
        woaCode = '10';
    case {'11','nov','november',11}
        woaCode = '11';
    case {'12','dec','december',12}
        woaCode = '12';
    case {'winter','13',13}
        woaCode = '13';
    case {'spring','14',14}
        woaCode = '14';
    case {'summer','15',15}
        woaCode = '15';
    case {'autumn','fall','16',16}
        woaCode = '16';
    
    otherwise
        error('Season must be one of [winter, spring, summer, autumn, all]');
end