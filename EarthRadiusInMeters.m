function [ EarthRadius ] = EarthRadiusInMeters(latitudeRadians)
    a = 6378137.0;  % equatorial radius in meters
    b = 6356752.3;  % polar radius in meters
    cosins = cos(latitudeRadians);
    sins = sin(latitudeRadians);
    t1 = a * a * cosins;
    t2 = b * b * sins;
    t3 = a * cosins;
    t4 = b * sins;
    EarthRadius = sqrt ((t1*t1 + t2*t2) / (t3*t3 + t4*t4));
end