% 
% point multiplication for B series
% 
function [outx, outy] = point_multiplication_B(xi, yi, n, param)
word_num = size(param.S, 1);
zero = zeros(word_num, 1);
one = zeros(word_num, 1);
one(1) = 1;

% projective coordinate
nx = xi;
ny = yi;
nz = one;
Px = one;
Py = one;
Pz = zero;
for j = 1: word_num
    for i = 1: 32
        bit = bitget(n(j), i);
        if bit == 1
            if any(Px - one) == 0 && any(Py - one) == 0 && any(Pz - zero) == 0 % infinite point + finite point
                Px = nx;
                Py = ny;
                Pz = nz;
            else % finite point + finite point
                [Px, Py, Pz] = point_addition_B(Px, Py, Pz, nx, ny, nz, param);
            end
            % 下一步的被加數
            [nx, ny, nz] = point_double_B(nx, ny, nz, param);
        end
    end
end

% project to original coordinate
Z = multiplicative_inverse_B(Pz, param);
Z2 =  square_B(Z, param);
Z3 = multiplication_B(Z2, Z, param);
%
outx = multiplication_B(Px, Z2, param);
outy = multiplication_B(Py, Z3, param);
return