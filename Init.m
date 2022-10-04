stationA = [40.46583 49.48842 0.207];
stationB = [39.23728 45.55281 1.077];
d1 = 37430;
d2 = 37539;
% date = [2022 9 26 12 0 0]; % YEAR MONTH DAY HOUR MINUTE SECOND
beta = 45.1;

[ distKm, azimuth, altitude ] = Calculate( stationA, stationB, true );
b = d1;
a = d2;
c = distKm;

stationAecef = lla2eci(stationA, date);
stationBecef = lla2eci(stationB, date);

angleC = rad2deg(acos((a^2 + b^2 -c^2)/(2*a*b)));
angleA = rad2deg(acos((b^2 + c^2 - a^2)/(2*b*c)));
angleB = rad2deg(acos((c^2 + a^2 - b^2)/(2*c*a)));

A = lla2ecef(stationA);
B = lla2ecef(stationB);
AB = B - A;
distKm_v2 = norm(AB);

S = beta;
N_A = stationA(2);
G_A = deg2rad(S - N_A);
L_A = deg2rad(stationA(1));
N_B = stationB(2);
G_B = deg2rad(S - N_B);
L_B = deg2rad(stationB(1));
phi1 = 180 +  rad2deg(atan(tan(G_A) / sin(L_A))); % Azimuth Station A -> SAT
phi2 = 180 + rad2deg(atan(tan(G_B) / sin(L_B))); % Azimuth Station B -> SAT
elevA = rad2deg(atan( (cos(G_A) * cos(L_A) - 0.1512)/ (sqrt(1 - (cos(G_A))^2*(cos(L_A))^2))));
elevB = rad2deg(atan( (cos(G_B) * cos(L_B) - 0.1512)/ (sqrt(1 - (cos(G_B))^2*(cos(L_B))^2))));

% d1ToSat_X = b * cos(deg2rad(elevA)) * cos(deg2rad(phi1));
d1ToSat_Y = b * cos(deg2rad(elevA)) * sin(deg2rad(phi1));
% d1ToSat_Z = b * sin(deg2rad(elevA));
% d2ToSat_X = a * cos(deg2rad(elevB)) * cos(deg2rad(phi2));
d2ToSat_Y = a * cos(deg2rad(elevB)) * sin(deg2rad(phi2));
% d2ToSat_Z = a * sin(deg2rad(elevB))
d1ToSat_X = b * cos(deg2rad(angleA));
d2ToSat_X = -a * cos(deg2rad(angleB));
d1ToSat_Z = b * sin(deg2rad(angleA));
d2ToSat_Z = a * sin(deg2rad(angleB));

d1ToSat = [d1ToSat_X d1ToSat_Y d1ToSat_Z];
d2ToSat = [d2ToSat_X d2ToSat_Y d2ToSat_Z];
OriginToSat1 = stationA + d1ToSat;
OriginToSat2 = stationB + d2ToSat;
resA = norm(OriginToSat1);
resB = norm(OriginToSat2);

% ERROR
r1 = d1;
r2 = d2;
x = d1ToSat(1);
x1 = stationAecef(1);
x2 = stationBecef(1);
y1 = stationAecef(2);
y2 = stationBecef(2);
z1 = stationAecef(3);
z2 = stationBecef(3);
theta1 = elevA;
theta2 = elevB;
sigma_s = 3.5;

E = [ 1/r1^2 0 0 0 0;
    0 1/r2^2 0 0 0;
    0 0 (cos(phi1)^2)/(x-x1)^2 0 0;
    0 0 0 (cos(phi2)^2)/(x-x2)^2 0;
    0 0 0 0 2] *sigma_s^2;
P = trace(E);

% Print Results
cprintf('key', "================== Results ==================\n");
cprintf('green', "Distance Between Stations: "); cprintf('text', distKm + " [km]\n");
% cprintf('green', "Distance Between Stations (v2): "); cprintf('text', distKm_v2/1000 + " [km]\n");
cprintf('green', "Azimuth A (phi1): "); cprintf('text', phi1+ " [deg]\n");
cprintf('green', "Azimuth B (phi2): "); cprintf('text', phi2+ " [deg]\n");
cprintf('green', "Elevation A: "); cprintf('text', elevA+ " [deg]\n");
cprintf('green', "Elevation B: "); cprintf('text', elevB+ " [deg]\n");
cprintf('green', "Result From SatA: "); cprintf('text', resA + " [km]\n");
cprintf('green', "Result From SatB: "); cprintf('text', resB + " [km]\n");
cprintf('green', "Satellite Coords (ECEF) [SatA]: \n");
disp(OriginToSat1);
cprintf('green', "Satellite Coords (ECEF) [SatB]: \n");
disp(OriginToSat2);
cprintf('green', "Error*: "); cprintf('text', P+ " [km]\n");
cprintf('key', "=============================================\n");

