function [ res ] = LocationToPoint(c, oblate)
    lat = c(1) * pi / 180.0;
    lon = c(2) * pi / 180.0;
    if oblate
        radius = EarthRadiusInMeters(lat);
    else
        radius = 6371009;
    end
    if oblate
        clat = GeocentricLatitude(lat);
    else
        clat = lat;
    end
    
    cosLon = cos(lon);
    sinLon = sin(lon);
    cosLat = cos(clat);
    sinLat = sin(clat);
    x = radius * cosLon * cosLat;
    y = radius * sinLon * cosLat;
    z = radius * sinLat;
    
    cosGlat = cos(lat);
    sinGlat = sin(lat);
    
    nx = cosGlat * cosLon;
    ny = cosGlat * sinLon;
    nz = sinGlat;
    
    x = x + c(3) * nx;
    y = y + c(3) * ny;
    z = z + c(3) * nz;
    res = [x y z nx ny nz radius];
end