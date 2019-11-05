clear all;
clc;
cla;

global y_max;
y_max = 0;

global x_max;
x_max = 0;

stats = zeros(3, 9);

for b=1:3
    [xfin, diametro, angulo, vo, masa, ymax, tmax, vf] = main(b);
    stats(b,:) = [b, diametro, rad2deg(angulo), vo, masa, xfin, ymax, tmax, vf];
end
varnames = {'Particula', 'Diametro (m)', 'angulo (º)', 'Velocidad inicial (m/s)', 'Masa (kg)', 'Alcance (m)', 'Altura maxima (m)', 'Tiempo de vuelo (s)', 'Velocidad final (m/s)'};
table(stats(:,1), stats(:,2), stats(:,3), stats(:,4), stats(:,5), stats(:,6), stats(:,7), stats(:,8), stats(:,9), 'VariableNames', varnames)
hold off;

function [xfin, diametro, angulo, vo, masa, ymax, tmax, vf] = main(iter)
    dt       = 0.01; % s
    cd       = 0.6;
    g        = 9.81; % m/s2
    rho_roca = 2;     % g/cm3
    rho_air  = 1.18;  % kg/m3
    x0       = 0;    % m
    y0       = 367;  % m
    
    global y_max
    global x_max
    
    fprintf("\nValores para el proyectil %d:\n", iter);
    vo       = input("Ingresa la velocidad incial (80-500) m/s: ");
    diametro = input("Ingresa el diametro del objeto (m): ");
    angulo   = deg2rad(input("Ingresa el angulo de tiro (10-80): "));

    volumen = 4/3 * pi * (diametro/2)^3; % m3
    area = pi * (diametro/2)^2;          % m2
    masa = volumen * rho_roca * 1000;    % kg

    b = 0.5 * cd * rho_air * area;

    vox = vo * cos(angulo);
    voy = vo * sin(angulo);

    [x, y, t] = Verlet(x0, y0, vox, voy, b, g, masa, dt);
    
    if max(y) > y_max
        y_max = max(y);
    end
    if max(x) > x_max
        x_max = max(x);
    end
    
    xfin = x(end);
    yfin = y(end);
    
    ymax = max(y);
    tmax = max(t);
    
    vfy = (y(end) - y(end-2)) / (2 * dt);
    vfx = (x(end) - x(end-2)) / (2 * dt);
   
    vf = sqrt(vfy^2 + vfx^2);
    
    graficar(x, y, y_max, x_max, iter)
end