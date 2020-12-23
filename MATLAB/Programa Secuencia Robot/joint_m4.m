function joint_m4(degrees, s)

steps = (degrees*12)/11.25;

if degrees > 0
    motor_enable = 67;
else
    motor_enable = 65;
end

write(s, motor_enable, "uint8")
    while true
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
flush(s)
    
write(s, steps, "uint8")
    while true
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
flush(s)    
    
end
