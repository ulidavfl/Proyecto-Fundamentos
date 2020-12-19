syms q0 l0 d0 alfa0
syms q1 l1 d1 alfa1
syms q2 l2 d2 alfa2
syms q3 l3 d3 alfa3

link=[q0 d0 l0 -pi/2; q1 0 l1 0; q2 d2 0 pi/2; q3 0 0 0];

H = H(link)
x = H(1,4)
y = H(2,4)
z = H(3,4)