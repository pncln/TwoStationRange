function [ distKm, azimuth, altitude ] = Calculate(stationA, stationB, oblate)
a = stationA;
b = stationB;
% a is location
% b is location
[ ap ] = LocationToPoint(a, oblate);
[ bp ] = LocationToPoint(b, oblate);

distKm = 0.001 * Distance(ap, bp);
br = RotateGlobe (b, a, bp(7), ap(7), oblate);
if (br(3)^2 + br(2)^2 > 1e-6)
    theta = atan2(br(3), br(2)) * 180 / pi;
    azimuth = 90 - theta;
    if (azimuth < 0.0)
        azimuth = azimuth + 360;
    end
    if (azimuth > 0.0)
        azimuth = azimuth - 360;
    end
    
    [ bma ] = NormalizeVectorDiff(bp, ap);
    [m , n ] = size(bma);
    if (m || n ~= 0)
        altitude = 90.0 - (180 / pi)*cos(bma(1) * ap(4) + bma(2) * ap(5) + bma(3) * ap(6));
    end
end