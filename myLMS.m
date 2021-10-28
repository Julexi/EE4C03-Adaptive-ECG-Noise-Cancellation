% myLMS.m - least mean squares algorithm
%
% Usage: [e, y, w] = myLMS(d, x, mu, M)
%
% Inputs:
% d  - the vector of pure noise signal samples of size Ns
% x  - the vector of input signal samples of size Ns
% mu - the stepsize parameter
% M  - the order of filter
%
% Outputs:
% e - the output error vector of size Ns(which is the signal we want£¡
% y  = output coefficients
% w - filter parameters
%
% ------------------------------------------------------------------------
function [e, y, w] = myLMS(d, x, mu, M)

Ns = length(d);
x = x; 
xx = zeros(M,1);
w1 = zeros(M,1);
y = zeros(Ns,1);
e = zeros(Ns,1);

for n = 1:Ns
    xx = [xx(2:M);x(n)];
    y(n) = w1' * xx;
    e(n) = d(n) - y(n);
    w1 = w1 + mu * e(n) * xx;
    w(:,n) = w1;
end

end