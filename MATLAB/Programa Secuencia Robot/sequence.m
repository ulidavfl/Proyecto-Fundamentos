s = serialport("COM1", 10250);

ui = create_ui();

while ishandle(ui)

    joint_m1(120, s, ui);
    joint_m2(30, s, ui);
    joint_m3(60, s, ui);
    joint_m4(45, s, ui);
    joint_m1(-120, s, ui);
    joint_m2(-30, s, ui);
    joint_m3(-60, s, ui);
    joint_m4(-45, s, ui);
    
end

clear;
clc;