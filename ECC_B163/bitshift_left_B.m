%
% bit left-shift by one function
%
function out = bitshift_left_B(a)
% global ifx;
%
f = ['000000c9';'00000000';'00000000';'00000000';'00000000';'00000008'];
%
ifx = size(f, 1);
%
a = uint32(a);
bit_old = 0; % temp for msb in each row
for i = 1 : ifx
    bit = bitget(a(i), 32);
    a(i) = bitshift(a(i), 1);
    a(i) = bitset(a(i), 1, bit_old);
    bit_old = bit;    
end
out = double(a);
return
