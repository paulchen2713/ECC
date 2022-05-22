%
% ECC B571 cryptographic system
%
clear;
clc;
%
% global f fr ifx a b f_dec fr_dec a_dec b_dec;
m = 571; % B-m == B-571
% split the large number into 6 row, each row is a 8-digit hexadecimal, 
% cause the number is too large to be represent or store in single byte
f  = ['00000425';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'08000000']; % f = z^571 + z^10 + z^5 + z^2 + z^0
fr = ['00000425';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000']; % fr = z^10 + z^5 + z^2 + z^0
a  = ['00000001';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000']; % a=1
b =  ['2955727A';'7FFEFF7F';'39BACA0C';'520E4DE7';'78FF12AA';'4AFD185A';
      '56A66E29';'2BE7AD67';'8EFA5933';'84FFABBD';'4A9A18AD';'CD6BA8CE';
      'CB8CEFF1';'5C6A97FF';'B7F3D62F';'DE297117';'2221F295';'02F40E7E']; % B
n =  ['2FE84E47';'8382E9BB';'5174D66E';'161DE93D';'C7DD9CA1';'6823851E';
      '08059B18';'FF559873';'E661CE18';'FFFFFFFF';'FFFFFFFF';'FFFFFFFF';
      'FFFFFFFF';'FFFFFFFF';'FFFFFFFF';'FFFFFFFF';'FFFFFFFF';'03FFFFFF']; % n
Gx = ['8EEC2D19';'E1E7769C';'C850D927';'4ABFA3B4';'8614F139';'99AE6003';
      '5B67FB14';'CDD711A3';'F4C0D293';'BDE53950';'DB7B2ABD';'A5F40FC8';
      '955FA80A';'0A93D1D2';'0D3CD775';'6C16C0D4';'34B85629';'0303001D']; % X
Gy = ['1B8AC15B';'1A4827AF';'6E23DD3C';'16E2F151';'0485C19B';'B3531D2F';
      '461BB2A8';'6291AF8F';'BAB08A57';'84423E43';'3921E8A6';'1980F853';
      '009CBBCA';'8C6C27A6';'B73D69D7';'6DCCFFFE';'42DA639B';'037BF273']; % Y
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
% testing
%
% by using equation in Guide to ECC textbook, p.81
% y^2 + xy = x^3 + ax^2 + b
%
% perform the squre, and multiplication operation through the subfunction
% left hand side == y^2 + xy
left = addition_B(square_B(Gy_dec), multiplication_B(Gx_dec, Gy_dec));
% right hand side == x^3 + ax^2 + b
right = addition_B(multiplication_B(square_B(Gx_dec), addition_B(Gx_dec, a_dec)), b_dec);
check = any(left - right); % any( if != 0 ) return 1, else return 0
%
% ECC cryptographic system
%
% Alice sends a message to Bob
%
% preparation process for Bob
%    private key: nb
%    public key: G = [Gx, Gy], Pb = nb*G
%
% ECC_B163_ElGama1 = cputime;
starting_time = cputime; % fetch the current time at the starting time
nb = ['919e16e9';'6aa70df5';'d81ca48a';'4b042071';'a1d03123';'285b93a8';
      'f1df1777';'0918d96a';'58018ecb';'725f7254';'edce083c';'6efad910';
      'd4b71bf1';'53ebf5ec';'f07d0421';'21d04d62';'3921370b';'f2824467'];
nb_dec = hex2dec(nb);
[Pbx, Pby] = point_multiplication_B(Gx_dec, Gy_dec, nb_dec);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Encryption process
%   message: M
%   private key: na
%
M = 'Someday';
% M = 'Do not judge a book by its cover. Do not judge me from my outside.';
M_len = length(M);
M_dec = double(M);
% (Pmx, Pmy) point on elliptic curve of M
Pmx = zeros(ifx, M_len);
Pmy = zeros(ifx, M_len);
%
% y^2 + xy = x^3 + ax^2 + b, if we know x then we can compute the LHS as C
% y^2 + xy = C, C = Right Hand Side compute result
% y^2/x^2 + y/x = C/x^2 = C'
% (y')^2 + y' = C', y' = y/x, C' = C/x^2
%
% using Algorithm 3.85 to slove (y')^2 + y' = C', Guide to ECC, p.133
% y' = H(C')
%    = C' + (C')^4 + (C')^16 + ... + (C')^{(m-1)/2}
%    = sigma{(C')2^2i}, i=0~(m-1)/2
%
load M_B571; % load the output data from M_B571.mat that we have computed previously
for im = 1 : M_len
    Pmx(:, im) = Mx(:, M_dec(im) - 31);
    Pmy(:, im) = My(:, M_dec(im) - 31);
end
%
% Pa = na * G
%
na = ['2b425680';'03db2785';'a86549df';'9087a100';'51e1456b';'c4d0668f';
      '20eda167';'b1d6a938';'c6911b5a';'175ddad5';'2521356e';'3790cfb8';
      'bf164ec4';'29829bf1';'9bf7c212';'6f60988a';'1f0fb31d';'1e7645f0'];
na_dec = hex2dec(na);
[Pax, Pay] = point_multiplication_B(Gx_dec, Gy_dec, na_dec);
%
% naPb = na * Pb
%
[naPbx, naPby] = point_multiplication_B(Pbx, Pby, na_dec);
%
% Pm_naPb =  Pm + naPb
%
Pm_naPbx = zeros(ifx, M_len);
Pm_naPby = zeros(ifx, M_len);
for im = 1 : M_len
    [Pm_naPbx(:, im), Pm_naPby(:, im), Z] = point_addition_B(Pmx(:, im), Pmy(:, im), one, naPbx, naPby, one);
    % turn the result back to 2D
    Z = multiplicative_inverse_B(Z);
    Z2 = square_B(Z);
    Z3 = multiplication_B(Z2, Z); % Z^3
    %
    Pm_naPbx(:, im) = multiplication_B(Pm_naPbx(:, im), Z2);
    Pm_naPby(:, im) = multiplication_B(Pm_naPby(:, im), Z3);
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Decryption process
%   received message: Pa, Pm_naPb
%
% nbPa = nb * Pa
%
[nbPbx, nbPby] = point_multiplication_B(Pax, Pay, nb_dec);
%
% R_Pm = Pm_naPb - nbPa ("-" for substraction) 
%
R_Pmx = zeros(ifx, M_len);
R_Pmy = zeros(ifx, M_len);
for im = 1 : M_len
    % ref. Guide ro ECC, p.81 Negative
    [Pm_naPbx(:, im), Pm_naPby(:, im), Z] = ...
        point_addition_B(Pm_naPbx(:, im), Pm_naPby(:, im), one, nbPbx, addition_B(nbPbx, nbPby), one);
    % turn the result back to 2D
    Z = multiplicative_inverse_B(Z);
    Z2 = square_B(Z);             
    Z3 = multiplication_B(Z2, Z); % Z^3
    %
    R_Pmx(:, im) = multiplication_B(Pm_naPbx(:, im), Z2);
    R_Pmy(:, im) = multiplication_B(Pm_naPby(:, im), Z3);
end
%
R_M_dec = zeros(1, M_len);
for im = 1 : M_len
    R_M_dec(im) = floor(R_Pmx(1, im) / 100);
end
R_M = char(R_M_dec);
%
%
ending_time = cputime;
ECC_B571_ElGama1 = ending_time - starting_time; % running time = ending - starting time
% ECC_B163_ElGama1 = cputime - ECC_B163_ElGama1; 
%
fprintf('the original message is:  %s\n', M);
fprintf('the recovered message is: %s\n', R_M);
fprintf('the computation time is:  %s\n', ECC_B571_ElGama1);
%
%

