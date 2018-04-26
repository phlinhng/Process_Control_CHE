%4-1
y=[1+i  0.5+2.3i  0.5i  pi]
abs(y) 
angle(y) 
real(y) 
imag(y) 
conj(y) 
exp(y)
y(1:3) 
y(3:-1:1) 
y([4 1 2]) 
z=[y([3 1]) 1 3]
%4-2
x=2:5
y=4:-1:1
x.^y   
x.*y   
x./y   
x.\y
x.^3   
x([1 3 4])+y(1:3)  
x*y' 
%4-4
a=3;b=0.1;x=(0:0.1:1)
y=x.*(1-x)/(a.*(1-x).^2+(1-x)+b.*x)