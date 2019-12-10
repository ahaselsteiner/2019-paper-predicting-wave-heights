% Creates Fig. 2 of https://arxiv.org/pdf/1911.12835.pdf

fig2 = figure('Position', [100 100 400 250]);

datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

MEASUREMENT_POI(1).Geometry = 'Point';
MEASUREMENT_POI(1).Lat = 43.525;
MEASUREMENT_POI(1).Lon = -70.141;
MEASUREMENT_POI(1).Name = 'A, buoy';% NDBC 44007'; https://www.ndbc.noaa.gov/station_page.php?station=44007

MEASUREMENT_POI(2).Geometry = 'Point';
MEASUREMENT_POI(2).Lat = 28.508;
MEASUREMENT_POI(2).Lon = -80.185;
MEASUREMENT_POI(2).Name = 'B, buoy'; %NDBC 41009'; https://www.ndbc.noaa.gov/station_page.php?station=41009

MEASUREMENT_POI(3).Geometry = 'Point';
MEASUREMENT_POI(3).Lat = 25.897;
MEASUREMENT_POI(3).Lon = -89.668;
MEASUREMENT_POI(3).Name = 'C, buoy'; %NDBC 42001'; https://www.ndbc.noaa.gov/station_page.php?station=42001

MEASUREMENT_POI(4).Geometry = 'Point';
MEASUREMENT_POI(4).Lat = 54.00; %54.0148 would be FINO 1;
MEASUREMENT_POI(4).Lon = 6.575; %6.5876 would be FINO 1;
MEASUREMENT_POI(4).Name = 'D, hindcast'; %Germany, https://www.fino1.de/en/location.html

MEASUREMENT_POI(5).Geometry = 'Point';
MEASUREMENT_POI(5).Lat = 55.000;
MEASUREMENT_POI(5).Lon = 1.175;
MEASUREMENT_POI(5).Name = 'E, hindcast'; %United Kingdom

MEASUREMENT_POI(6).Geometry = 'Point';
MEASUREMENT_POI(6).Lat = 59.500;
MEASUREMENT_POI(6).Lon = 4.325;
MEASUREMENT_POI(6).Name = 'F, hindcast'; %Norway

LAT_LIM = [20 65];
LON_LIM = [-95 10];

% Use mapdata from the map_toolbox, see also
% https://de.mathworks.com/help/map/ref/gshhs.html .
shorelines = gshhs('gshhs_c.b', LAT_LIM, LON_LIM);
levels = [shorelines.Level];
land = (levels == 1);

tick = 10;
h = axesm('robinson','MapLatLimit',LAT_LIM,'MapLonLimit',LON_LIM,...
    'Frame','on','Grid','off','MeridianLabel','on','ParallelLabel','on');
setm(gca,'mlabellocation',tick,'plabellocation',tick,'mlinelocation',tick,'plinelocation',tick)
geoshow(shorelines(land),  'FaceColor', [0.8 0.8 0.8]);
setm(gca, 'FFaceColor', 'white');


myColors = distinguishable_colors(6);
for i = 1:6
    plotHandles.hPoiMarkers = geoshow(MEASUREMENT_POI(i), 'Marker', 'o', ...
        'MarkerEdgeColor', 'black', 'MarkerFaceColor', myColors(i,:), 'MarkerSize', 6);
    textm(MEASUREMENT_POI(i).Lat, MEASUREMENT_POI(i).Lon + 1.5, datasets{i});
end
axis off
set(findall(h,'Tag','PLabel'),'visible','off')
set(findall(h,'Tag','MLabel'),'visible','off')