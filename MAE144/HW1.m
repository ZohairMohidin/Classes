%% MAE 144 Homework 1 Zohair Mohidin
% See Github page here:
% https://github.com/ZohairMohidin/Classes.git

clear all;
clc;
syms s;

%% Problem 2a
% define plant G(s) = b(s)/a(s)
a = RR_poly([1 -1 3 -3 6 -6],1);
b = RR_poly([2 -2 5 -5],1);

% define function f (roots are at desired pole location)
f = RR_poly([1 1 3 3 6 6],1);

[x,y] = RR_diophantine(a,b,f);

test=trim(a*x+b*y);

%check if residual is zero
residual=norm(f-test);

% CONTROLLER
D  = y/x;

%% Problem 2b
% Controller D is not proper. Add more poles.
fsNew = ((s+1)^2)*((s+3)^2)*((s+6)^2)*((s+20)^6);

fNew = RR_poly([1 1 3 3 6 6 20 20 20 20 20],1);

[x2,y2] = RR_diophantine(a,b,fNew);

% test=a*x+b*y
test2=trim(a*x2+b*y2);
residual2=norm(fNew-test2);
DNew=y2/x2;

if (x2.n>=y2.n)
    disp("Controller D is proper")
else
    disp("Controller D is NOT proper")
end



