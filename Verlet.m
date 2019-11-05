function [x, y, t] = Verlet(x0, y0, vox, voy, b, g, masa, dt)
    xmin = x0 - (vox * dt);
    ymin = y0 - (voy * dt) - (0.5 * g * dt^2);
    
    t = 0;
    
    x(1) = xmin;
    y(2) = y0;
    
    y(1) = ymin;
    x(2) = x0;
    
    iter_count = 2;
    
    while y(end) >= 0
        iter_count = iter_count + 1;
        m2m2bt = (2 * masa) / ((2 * masa) + (b * dt));
        bdt2m  = (b * dt) / (2 * masa);
        
        x(iter_count) = m2m2bt * ((2 * x(iter_count - 1)) + ((bdt2m -1) * x(iter_count - 2)));
        y(iter_count) = m2m2bt * ((2 * y(iter_count - 1)) + ((bdt2m -1) * y(iter_count - 2) - (g*dt*dt)));
        t = t + dt;
    end
end