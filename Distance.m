function [ res ] = Distance(ap, bp)
    dx = ap(1) - bp(1);
    dy = ap(2) - bp(2);
    dz = ap(3) - bp(3);
    res = sqrt(dx^2 + dy^2 + dz^2);
end