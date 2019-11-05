function graficar(x, y, y_axis, x_axis, iter)
    hold on;
    axis([0 x_axis+100 0 y_axis+100])
    if iter == 1
        h = animatedline('Color', 'r');
    elseif iter == 2
        h = animatedline('Color', 'g');
    else
        h = animatedline('Color', 'b');
    end
    
    for i = 1:3:length(x)
        addpoints(h, x(i), y(i));
        pause(0.001);
        drawnow limitrate;
    end
    
    ymax      = max(y);
    
    ymax_indx = y==ymax; %para obtener el indice donde esta la y maxima
    x_ymax    = x(ymax_indx);
    
    plot(x_ymax, ymax, "o");

    title("Tiro volcanico con resistencia del aire");
    xlabel("x")
    ylabel("y")
end