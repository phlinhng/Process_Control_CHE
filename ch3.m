%3-3
x=1+2i;y=2+3i;z=exp(1)^(pi*i/3);
a=x*y/z
b=x^2*y^1.5*z^(-3)
%3-4 (1)
p=[i 1-5i -1+8i];roots(p)
%3-4 (2)
syms m
M=solve((3+8i)^2-4*2^2*(-(m+4i)) >= 0,m)
q=[2 -(3+8i) -(M+4i)];roots(q)