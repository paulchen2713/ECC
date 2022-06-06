%
% ECC B163 coefficient data
%
m = 163; % B-m == B163
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
f_dec  = hex2dec(f);
fr_dec = hex2dec(fr);
a_dec  = hex2dec(a);
b_dec  = hex2dec(b);
n_dec  = hex2dec(n);
Gx_dec = hex2dec(Gx);
Gy_dec = hex2dec(Gy);
%
nb = ['00000065';'00000000';'00000000';'ffffffff';'ffffffff';'00000000'];
na = ['00000029';'00000000';'ffffffff';'ffffffff';'ffffffff';'00000000'];
M = 'Someday';


