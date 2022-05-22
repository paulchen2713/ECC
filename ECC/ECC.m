%
% ECC(Elliptic Curve Cryptography)
%
% example_1: Stalling 7th-edition, p.326
%
clear;
clc;
%
global p a;
p = 23;
a = 1;
b = 1;
%
%
XY = zeros(1, 2); %  using 2-d vector XY to store all points
% number of points, except for the infinite point
index = 0; % total number of points == index + 1
for ix = 0 : p-1
    y2 = mod(ix^3 + a*ix + b, p);
    for iy = 0 : p-1
        % if the point is on the curve
        if mod(iy^2, p) == y2
            index = index + 1;
            XY(index, 1) = ix;
            XY(index, 2) = iy;
        end
    end
end
% the only single point in the plot is the vertex of the curve
plot(XY(:, 1), XY(:, 2), 'O');
axis([0, p, 0, p]); % restrict the upper bound to p on x, y axis
grid on;            % add grid lines
xlabel('x');
ylabel('y');
%
%
GT = ones(index + 2, 3 * index); % (row, col)
for ii = 1 : index
    G = XY(ii, :); % one point
    GT(1, ((ii - 1)*3 + 1):(ii*3 - 1)) = G;
    for n = 2 : index+2
        P = point_multiplication(G, n);
        GT(n, ((ii - 1)*3 + 1):(ii*3 - 1)) = P;
    end
end




