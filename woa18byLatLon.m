function [d, woaLocation] = woa18byLatLon(woaData,woaLon,woaLat,woaDepths,lon,lat,depths)

if nargin < 7
    depths = [0:10:200,250:25:500,600:50:1000, 1250:250:4000 4500:500:5500];
end

for i = 1:length(lon)
    depth = woaDepths;
    [~, lonIx] = min(abs(lon(i)-woaLon));
    [~, latIx] = min(abs(lat(i)-woaLat));
    woaLocation(i).lon = woaLon(lonIx);
    woaLocation(i).lat = woaLat(latIx);
    data = squeeze(woaData(lonIx,latIx,:));

    % remove nans
%     ix = isnan(data);
%     data(ix)=[];
%     depth(ix)=[];
    woaLocation(i).depth = depth;
    d{i} = interp1(depth,data,depths,'nearest');
    
end