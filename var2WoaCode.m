function woaCode = var2WoaCode(t)
% Return the world ocean atlas code fora  given time, t
% TODO: code each month in addition to seasons and annual
switch lower(t)
    case {'temperature','temp','t'}
         woaCode = 't';
    case {'salinity','sal','s'}
        woaCode = 's';
    case {'oxygen','o',}
        woaCode = 'o';    
    case {'nitrate','n'}
        woaCode = 'n';
    case {'phosphate','p'}
        woaCode = 'p';
    case {'silicate'}
        woaCode = 'i';
    case {'conductivity','c'}
        woaCode = 'C';
    case {'density'}
        woaCode = 'I';
    case {'mixed layer depth','mixed','mld'}
        woaCode = 'M';
    
    otherwise
        error('Variable must be one of {t, s, o, n, p, i, C, I, M}');
end