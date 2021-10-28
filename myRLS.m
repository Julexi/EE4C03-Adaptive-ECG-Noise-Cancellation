% ------------------------------------------------------------------------
% myRLS.m - least mean squares algorithm
%
% Usage: [e, y, w] = myRLS(d, x, lamda, M)
%
% Inputs:
% d  - the vector of pure noise signal samples of size Ns
% x  - the vector of input signal samples of size Ns
% lamda - the weight parameter (forgetting factors)
% M  - the order of filter
%
% Outputs:
% e - the output error vector of size Ns(which is the signal we want£¡
% y - output coefficients
% w - filter parameters
%
% ------------------------------------------------------------------------
function [e, y, w] = myRLS(d, x,lamda,M)

Ns = length(d);
I = eye(M);
a = 0.01;
p = I/a;
x = x; %padding
w1 = zeros(M,1);
y = zeros(Ns, 1);
e = zeros(Ns, 1);
xx = zeros(M,1);

for n = 1:Ns
    xx = [x(n); xx(1:M-1)];
    k = (p * xx) ./ (lamda + xx' * p * xx);%gain
    y(n) = xx'*w1; %noise prediction
    e(n) = d(n) - y(n);
    w1 = w1 + k * e(n);
    p = (p - k * xx' * p) ./ lamda;
    w(:,n) = w1;
end

end