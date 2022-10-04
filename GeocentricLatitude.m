function [ clat ] = GeocentricLatitude(lat)
    e2 = 0.00669437999014;
    clat = atan((1.0 - e2) * tan(lat));
end