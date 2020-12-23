function [H] = H(link)

H01=[cos(link(1,1)) -sin(link(1,1))*cos(link(1,4)) sin(link(1,1))*sin(link(1,4)) link(1,3)*cos(link(1,1));
   sin(link(1,1)) cos(link(1,1))*cos(link(1,4)) -cos(link(1,1))*sin(link(1,4)) link(1,3)*sin(link(1,1));
   0 sin(link(1,4)) cos(link(1,4)) link(1,2);
   0 0 0 1];

H12=[cos(link(2,1)) -sin(link(2,1))*cos(link(2,4)) sin(link(2,1))*sin(link(2,4)) link(2,3)*cos(link(2,1));
   sin(link(2,1)) cos(link(2,1))*cos(link(2,4)) -cos(link(2,1))*sin(link(2,4)) link(2,3)*sin(link(2,1));
   0 sin(link(2,4)) cos(link(2,4)) link(2,2);
   0 0 0 1];

H23=[cos(link(3,1)) -sin(link(3,1))*cos(link(3,4)) sin(link(3,1))*sin(link(3,4)) link(3,3)*cos(link(3,1));
   sin(link(3,1)) cos(link(3,1))*cos(link(3,4)) -cos(link(3,1))*sin(link(3,4)) link(3,3)*sin(link(3,1));
   0 sin(link(3,4)) cos(link(3,4)) link(3,2);
   0 0 0 1];

H34=[cos(link(4,1)) -sin(link(4,1))*cos(link(4,4)) sin(link(4,1))*sin(link(4,4)) link(4,3)*cos(link(4,1));
   sin(link(4,1)) cos(link(4,1))*cos(link(4,4)) -cos(link(4,1))*sin(link(4,4)) link(4,3)*sin(link(4,1));
   0 sin(link(4,4)) cos(link(4,4)) link(4,2);
   0 0 0 1];

H=H01*H12*H23*H34;
end

