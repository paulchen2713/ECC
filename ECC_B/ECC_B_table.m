% ECC B series ElGamal crytographic systems
% ref. Guide, p.132
clear; clc;

% set variable
series = 'B-233'; % 163, 233, 283, 409, 571
param = produce_ECC_param(series);
dec_param = ECC_B_param2dec(param);
word_num = size(dec_param.S, 1);
zero = zeros(word_num, 1);
one = zeros(word_num, 1);
one(1) = 1;

%
displayable_num = 126 - 31;
Mx = zeros(word_num, displayable_num);
My = zeros(word_num, displayable_num);
for im = 32: 126
    X = im * 100;
    flag = 1;
    while flag == 1
        x = zero;
        x(1) = X;
        right = addition_B(multiplication_B(square_B(x, dec_param), addition_B(x, dec_param.a), dec_param), dec_param.b);
        x2 = multiplicative_inverse_B(square_B(x, dec_param), dec_param);
        c = multiplication_B(right, x2, dec_param);
        H = zero;
        c4 = c;
        for i = 0: (dec_param.m - 1) / 2
            H = addition_B(H, c4);
            c4 = square_B(square_B(c4, dec_param), dec_param);
        end
        y = multiplication_B(H, x, dec_param);
        left = addition_B(square_B(y, dec_param), multiplication_B(x, y, dec_param));
        if any(left - right) == 0
            Mx(:, im - 31) = x;
            My(:, im - 31) = y;
            flag = 0;
        else
            X = X + 1;
        end
    end
end
save 'M.mat' Mx My;
