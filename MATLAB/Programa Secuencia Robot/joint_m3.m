function joint_m3(degrees, s)

steps = (degrees*12)/22.5;

steps = round(steps);

if degrees < 0
    motor_enable = 16;
    steps = steps*-1;
else
    motor_enable = 17;
end

write(s, motor_enable, "uint8")
while true
    received = read(s, 1, "uint8");
    if received == 1
        break
    end    
end
disp("Recibido")    
flush(s)
    
write(s, steps, "uint8")
while true
    received = read(s, 1, "uint8");
    if received == 1
        break
    end    
end
disp("Recibido")
flush(s)     
    
end
