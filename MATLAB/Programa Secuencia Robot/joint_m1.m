function joint_m1(degrees, s, ui)

if ishandle(ui)

    steps = (degrees*4)/3.75;

    steps = round(steps);

    if degrees < 0
        motor_enable = 2;
        steps = steps*-1;
    else
        motor_enable = 3;
    end
    
    joint(motor_enable, steps, s, ui);

end    
    
end
