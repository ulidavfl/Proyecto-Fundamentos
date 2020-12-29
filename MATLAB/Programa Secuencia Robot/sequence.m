s = serialport("COM1", 10250);

ui = create_ui();

while ishandle(ui)

    joint_m1(30, s, ui);
    joint_m2(20, s, ui);
    joint_m3(55, s, ui);
    joint_m4(45, s, ui);
    joint_m1(-30, s, ui);
    joint_m2(-20, s, ui);
    joint_m3(-55, s, ui);
    joint_m4(-45, s, ui);
    
end

clear;
clc;