%
% bit left-shift by one
%
function out = bitshift_right_B(a, param)
    word_num = size(param.S, 1);
    bit_old = 0;
    for i = 1:word_num
        bit = bitget(a(word_num - i + 1), 1);
        a(word_num - i + 1) = bitshift(a(word_num - i + 1), -1);
        a(word_num - i + 1) = bitset(a(word_num - i + 1), 32, bit_old);
        bit_old = bit;
    end
    out = a;
return

