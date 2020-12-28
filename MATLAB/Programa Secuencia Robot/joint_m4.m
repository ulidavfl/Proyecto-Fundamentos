function joint_m4(degrees, s)

disp(degrees)

steps = (degrees*12)/11.25;

if degrees < 0
    motor_enable = 32;
    disp("Negativo")
else
    motor_enable = 33;
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
