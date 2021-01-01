function joint_m4(degrees, s, ui)

if ishandle(ui)
    
    if abs(degrees) > 90 %s
    
        error("Ángulo inváido para la articulación 4");
    
    else

        steps = degrees/0.9;

        steps = round(steps);

        if degrees < 0
            
            motor_enable = 32;
            
            steps = steps*-1;
            
        else
            
            motor_enable = 33;
            
        end

        joint(motor_enable, steps, s, ui);
    
    end

end
    
end
