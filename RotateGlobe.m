function [ res ] = RotateGlobe(b, a, bradius, aradius, oblate)
    br = [b(1) (b(2) - a(2)) b(3)];
    brp = LocationToPoint(br, oblate);

    alat = -a(1) * pi / 180.0;
    if (oblate) 
        alat = GeocentricLatitude(alat);
    end
    acos = cos(alat);
    asin = sin(alat);

    bx = (brp(1) * acos) - (brp(3) * asin);
    by = brp(2);
    bz = (brp(1) * asin) + (brp(3) * acos);

    x = bx;
    y = by;
    z = bz;
    radius = bradius;
    res = [x y z radius];
end