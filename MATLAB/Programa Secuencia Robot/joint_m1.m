function joint_m1(degrees, s)

steps = (degrees*12)/11.25;

if degrees > 0
    motor_enable = 5;
else
    motor_enable = 4;
end

write(s, motor_enable, "uint8")
    while true
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
flush(s)
disp("Recibido")
    
write(s, steps, "uint8")
    while true
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
flush(s)    
    
end
