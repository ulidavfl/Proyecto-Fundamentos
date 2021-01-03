syms q0 l0 d0 alfa0
syms q1 l1 d1 alfa1
syms q2 l2 d2 alfa2
syms q3 l3 d3 alfa3

link=[q0 111.51 130.48 0; q1 0 203.6 0; q2 0 152.88 0; q3 0 20 0];

H = H(link)
x = H(1,4)
y = H(2,4)
z = H(3,4)