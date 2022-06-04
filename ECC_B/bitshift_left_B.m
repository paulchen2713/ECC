%
% bit left-shift by one
%
function out = bitshift_left_B(a, param)
    word_num = size(param.S, 1);
    a=uint32(a);
    bit_old=0;
    for i=1:word_num
        bit=bitget(a(i),32);
        a(i)=bitshift(a(i),1);
        a(i)=bitset(a(i),1,bit_old);
        bit_old=bit;    
    end
    out=double(a);
return
