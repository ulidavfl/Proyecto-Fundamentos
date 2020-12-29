function joint_m3(degrees, s, ui)

if ishandle(ui)

    steps = (degrees*12)/11.25;

    steps = round(steps);

    if degrees < 0
        motor_enable = 16;
        steps = steps*-1;
    else
        motor_enable = 17;
    end

    joint(motor_enable, steps, s, ui);
    
end    
    
end
