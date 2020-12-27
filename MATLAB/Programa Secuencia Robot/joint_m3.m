function joint_m3(degrees, s)

steps = (degrees*12)/11.25;

if degrees < 0
    motor_enable = 16;
    disp("Negativo")
else
    motor_enable = 17;
    disp("Positivo")
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
