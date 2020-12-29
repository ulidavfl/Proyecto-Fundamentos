function joint_m1(degrees, s)

steps = (degrees*12)/11.25;

steps = round(steps);

if degrees < 0
    motor_enable = 2;
    steps = steps*-1;
else
    motor_enable = 3;
end

if mod(steps, 2) == 0
    steps = steps/2;
    flag = 0;
else
    steps = (steps-1)/2;
    flag = 1;
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

write(s, flag, "uint8")
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
