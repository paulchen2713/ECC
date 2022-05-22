%
% ECC B163 Elgama cryptographic system
%
clera;
clc;
%
global f fr ifx a b f_dec fr_dec a_dec b_dec;
m = 163; % B-m == B163
% split the large number into 6 row, cause the number is too large to
% be represent in single byte
f  = ['000000c9';'00000000';'00000000';'00000000';'00000000';'00000008'];
fr = ['000000c9';'00000000';'00000000';'00000000';'00000000';'00000000'];
a  = ['00000001';'00000000';'00000000';'00000000';'00000000';'00000000'];
b  = ['4a3205fd';'512f7874';'1481eb10';'b8c953ca';'0a601907';'00000002'];
n  = ['a4234c33';'77e70c12';'000292fe';'00000000';'00000000';'00000004'];
Gx = ['e8343e36';'d4994637';'a0991168';'86a2d57e';'f0eba162';'00000003'];
Gy = ['797324f1';'b11c5c0c';'a2cdd545';'71a0094f';'d51fbc6c';'00000000'];
%
ifx = size(f, 1);
zero = zeros(ifx, 1); % the 0 for BigNumber computation
one  = zeros(ifx, 1); % the 1 for BigNumber computation
one(1) = 1;
%
f_dec = double(f);
fr_dec = double(fr);
a_dec = double(a);
b_dec = double(b);
n_dec = double(n);
Gx_dec = double(Gx);
Gy_dec = double(Gy);
%
% testing
%
% by using equation in Guide to ECC textbook, p.81
% y^2 + xy = x^3 + ax^2 + b
%
% perform the squre, and multiplication operation through the subfunction
left = addition_B(square_B(Gy_dec), multipliaction_B(Gx_dec, Gy_dec));
right = addition_B(multiplication_B(square_B(Gx_dec), addition_B(Gx_dec, a_dec)), b_dec);
check = any(left - right); % any( if != 0 ) return 1
%
%
nb = ['00000065';'00000000';'00000000';'ffffffff';'ffffffff';'00000000'];
na = ['00000029';'00000000';'ffffffff';'ffffffff';'ffffffff';'00000000'];
M = 'Do not judge a book by its cover. Do not judge me from my outside.';
%
%


