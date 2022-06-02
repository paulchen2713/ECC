%
% ECC (Elliptic Curve Cryptography)
%
% example_p326: Stallings, 7th-edition, p.326
% y^2 = x^3 + ax + b
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
XY = zeros(1, 2); % store every points solution
index = 0;        % total number of points == index + 1
for ix = 0 : p-1
    % y^2 = x^3 + ax + b
    y2 = mod(ix^3 + a*ix+b, p); % y2 <-- y^2
    for iy = 0 : p-1
        if mod(iy^2, p) == y2
            index=index+1;
            XY(index,1)=ix;
            XY(index,2)=iy;
        end
    end
end
%
plot(XY(:, 1), XY(:, 2), 'o');
axis([0, p, 0, p]);
grid on;     % plot dotted grid line mode "on"
xlabel('x');
ylabel('y');
%
%
%
GT = ones(index + 2, 3*index);
for ii = 1 : index 
    G = XY(ii, :);
    GT(1, (ii-1)*3 + 1 : ii*3 - 1) = G;
    for n = 2 : index+2
        P = point_multiplication(G, n);
        GT(n, (ii - 1)*3 + 1 : ii*3 - 1) = P;
    end
end



