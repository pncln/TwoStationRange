function [ res ] = NormalizeVectorDiff(b, a)
    dx = b(1) - a(1);
    dy = b(2) - a(2);
    dz = b(3) - a(3);
    dist2 = dx^2 + dy^2 + dz^2;
    if (dist2==0)
        return;
    end
    dist = sqrt(dist2);
    x = dx / dist;
    y = dy / dist;
    z = dz / dist;
    radius = 1.0;
    res = [ x y z radius ];
end