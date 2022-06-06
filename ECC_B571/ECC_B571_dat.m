%
% ECC B571 coefficient data
%
m = 571; % B-m == B-571
% split the large number into 6 row, each row is a 8-digit hexadecimal, 
% cause the number is too large to be represent or store in single byte
f =  ['00000425';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'08000000']; % f = z571 +z10 +z5 +z2 +1Z0
fr = ['00000425';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
      '00000000';'00000000';'00000000';'00000000';'00000000';'00000000']; % fr = z10 +z5 +z2 +Z0
a =  ['00000001';'00000000';'00000000';'00000000';'00000000';'00000000';
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
nb = ['e4b83106';'0c7100a5';'d7eb9bf5';'1f4cd113';'6f74e0d3';'aca8f794';
      'f8d7fea8';'d0dcb7ef';'c3f3f292';'fd4c5206';'f8055fd4';'800d273f';
      'af576352';'918b5231';'dff1ae21';'eebbd74b';'2b38a063';'e75e0a1e'];
nb_dec = hex2dec(nb);
na = ['ef4fd305';'7bf0b8ae';'1b79593d';'b0ae6233';'a9d6a89f';'a5287c8c';
      '175cd82c';'64535e7a';'0284dfce';'ceb9aa12';'965a99d5';'8ad7300b';
      '27747554';'d33fdb8b';'68f117b0';'9af0b1b6';'8f8aab1d';'ab1216c7'];
na_dec = hex2dec(na);
M = 'Someday';


