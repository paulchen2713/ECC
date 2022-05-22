function dec_param = ECC_B_param2dec(param)
%ECC_B_param2dec change parameter of ECC B series to decimal
%   ECC_B_param: parameter of ECC B series of ECC
dec_param = param;

dec_param.f = hex2dec(dec_param.f);
dec_param.fr = hex2dec(dec_param.fr);
dec_param.S = hex2dec(dec_param.S);
dec_param.a = hex2dec(dec_param.a);
dec_param.b = hex2dec(dec_param.b);
dec_param.n = hex2dec(dec_param.n);
dec_param.x = hex2dec(dec_param.x);
dec_param.y = hex2dec(dec_param.y);
end
