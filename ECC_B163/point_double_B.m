%
% ECC (Elliptic Curve Cryptography) B
%
% point double function
%
% ref. Handbook of E&HECC, p.293
%
function [X3, Y3, Z3] = point_double_B(X1, Y1, Z1)
% global ifx b_dec;
%
f = ['000000c9';'00000000';'00000000';'00000000';'00000000';'00000008'];
b = ['4a3205fd';'512f7874';'1481eb10';'b8c953ca';'0a601907';'00000002'];
%
ifx = size(f, 1);
zero = zeros(ifx, 1); % the 0 for BigNumber computation
one  = zeros(ifx, 1); % the 1 for BigNumber computation
one(1) = 1;
%
b_dec  = hex2dec(b);
%
if any(X1 - one) == 0 && any(Y1 - one) == 0 && any(Z1 - zero) == 0
    X3 = one;
    Y3 = one;
    Z3 = zero;
else
    A  = square_B(X1);
    B  = square_B(A);
    C  = square_B(Z1);
    C2 = square_B(C);
    C4 = square_B(C2);
    bC4 = multiplication_B(b_dec, C4);
    X3 = addition_B(B, bC4);
    Z3 = multiplication_B(X1, C);
    Y1Z1 = multiplication_B(Y1, Z1);
    SUM = addition_B(addition_B(A, Y1Z1), Z3);
    SUMX3 = multiplication_B(SUM, X3);
    BZ3 = multiplication_B(B, Z3);
    Y3 = addition_B(BZ3, SUMX3);
end
return
