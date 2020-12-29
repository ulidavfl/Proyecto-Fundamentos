function joint(motor_enable, steps, s, ui)

if ishandle(ui)
    
    if mod(steps, 2) == 0
        steps = steps/2;
        flag = 0;
    else
        steps = (steps-1)/2;
        flag = 1;
    end

    write(s, motor_enable, "uint8")
    while ishandle(ui)
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
    disp("Recibido")    
    flush(s)

    write(s, flag, "uint8")
    while ishandle(ui)
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
    disp("Recibido")    
    flush(s)

    write(s, steps, "uint8")
    while ishandle(ui)
        received = read(s, 1, "uint8");
        if received == 1
            break
        end    
    end
    disp("Recibido")
    flush(s)
    
end    
    
end
