%
% ECC (Elliptic Curve Cryptography)
%
% example_1: Stallings, 7th-edition, p.326
%
clear;
clc;
%
global p a;
p = 8831;
a = 3;
b = 45;
%
%
XY = zeros(1, 2);
index = 0;
for ix = 0 : p-1
    y2 = mod(ix^3 + a*ix + b, p);
    for iy = 0:p-1
        if mod(iy^2, p) == y2
            index = index + 1;
            XY(index, 1) = ix;
            XY(index, 2) = iy;
        end
    end
end
%
% plot(XY(:, 1), XY(:, 2), 'o');
axis([0, p, 0, p]);
grid on;
xlabel('x');
ylabel('y');
%
%
GT = ones(index+2, 3*index);
for ii = 1:index 
    G = XY(ii,:);
    GT(1, (ii-1)*3+1:ii*3-1) = G;
    for n = 2 : index+2
        P = point_multiplication(G,n);
        GT(n, (ii-1)*3+1:ii*3-1) = P;
    end
end
%
%
