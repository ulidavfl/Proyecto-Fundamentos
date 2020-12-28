s = serialport("COM1", 10250);

while true

    joint_m1(-30, s);
    joint_m2(20, s);
    joint_m4(55, s);
    joint_m3(70, s);
    joint_m1(30, s);
    joint_m4(-15, s);
    joint_m3(10, s);
    joint_m2(36, s);
    
end