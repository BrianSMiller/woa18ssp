function [decade, variable, timePeriod, gridSize] = ...
                                        parseWoa18Filename(filename)
% Excerpt from WOA18 documentation
% File naming convention
% All files, except netcdf, follow the same naming convention:
% woa18_[DECA]_[v][tp][ft][gr].[form_end]
% Netcdf files follow the format: woa18_[DECA]_[v][tp]_[gr].nc
% Where:
% [DECA] represents decade, the time span (years) represented by the
%   objectively analyzed means and other statistical fields as listed in
%   Table 1: 
% [v] represents the oceanographic variable using one-letter code
%   as listed in Table 4;
% [tp] represents the averaging period, two digit code as follows:
%   00 – annual statistics, all data used;
%   01 to 12 – monthly statistics (starting with 01 – Jan, to 12 – Dec);
%   13 to 16 – seasonal statistics:
%   Season 13 – North Hemisphere winter (January - March);
%   Season 14 – North Hemisphere spring (April - June);
%   Season 15 – North Hemisphere summer (July - September);
%   Season 16 – North Hemisphere autumn (October - December);
% [ft] represents field type, describing the calculated statistic
%   represented in the file, as listed in Table 2 [gr] represents the grid
%   size, two digit code as follows:
% 04 – quarter-degree grid resolution
% 01 – one-degree grid resolution
% 5d – five-degree grid resolution
% [form_end] format suffix (filename extension), dependent on format as
%  follows:
%   csv – comma-separated value format
%   nc – netCDF format
%   dbf, shp, shx – shapefiles (when downloaded will be in a .tar file)
%   dat – compact grid data format (legacy WOA ASCII format)
% Example: woa18_95A4_s02an01.nc is a file containing World Ocean Atlas
% 2018, February objectively analyzed salinity on one-degree grid
% resolution for the years 1995-2004 in netCDF format.

[~, filename, ext] = fileparts(filename);
if any(strcmpi(ext,{'.nc','.mat'})) %netcdf file
    if contains(filename,'decav')
        formatSpec = 'woa18_%5c_%1c%2c_%2c.*';
    else
        formatSpec = 'woa18_%4c_%1c%2c_%2c.*';
    end
    codes = textscan(filename,formatSpec);
end

decade = codes{1};
variable = codes{2};
timePeriod = codes{3};
gridSize = codes{4};