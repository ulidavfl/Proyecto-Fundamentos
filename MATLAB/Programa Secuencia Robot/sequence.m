s = serialport("COM1", 10250);

while true

    joint_m1(30, s);
    joint_m2(30, s);
    joint_m3(20, s);
    joint_m4(55, s);
    joint_m1(-30, s);
    joint_m2(-30, s);
    joint_m3(-20, s);
    joint_m4(-55, s);
    
end