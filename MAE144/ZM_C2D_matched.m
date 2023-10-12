function [Gz] = ZM_C2D_matched(Gs,h,omega)
% This function converts a Continuos time transfer function to a Discrete
% time transfer function using the C2D Matched method
syms s z1 p1;

num = [1 1];
den = [1 10 0];

Gs = RR_tf(num,den);

zeros = roots(Gs.num.poly);
poles = roots(Gs.den.poly);

% Match poles and zeros to z domain
newZeros = [exp(zeros*h)];
newPoles = exp(poles*h);

% Add infinite zeros to make strictly proper
while size(Gs.num.poly,2) < size(Gs.den.poly,2)-1
    newZeros = [newZeros -1];
end

% Get DC Gain from transfer function using input omega
DCGain = RR_evaluate(Gs,omega);
% check for division by zero and throw an error if DCGain is infinity
if isinf(DCGain)
    error("Division by zero try another value for omega");
end

%Create new transfer function using matched poles method
Gz = DCGain * RR_tf(newZeros,newPoles);
Gz.h = h;
end
