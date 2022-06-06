%
% Reduction for B571, similar to module operation, B163 only
%
function out = reduction_B571(C)
%
% ref. Guide to ECC textbook, p.56
% f = z^571 + z^10 + z^5 + z^2 + 1
% C = a + b is consist of 12 sections of 32-bit words
% first, compute the result of 11~6 sections(12~7 in matlab indecies)
% 
for i = 36 : -1 : 19
    T = uint32(C(i));
    C(i-18) = addition_B(C(i-18), addition_B(addition_B(bitshift(T, 5), bitshift(T, 7)), addition_B(bitshift(T, 10), bitshift(T, 15))));
    C(i-17) = addition_B(C(i-17), addition_B(addition_B(bitshift(T, -27),bitshift(T, -25)), addition_B(bitshift(T, -22),bitshift(T, -17))));
end
T = uint32(C(18));
T = bitshift(T, -27);
C(1) = addition_B(C(1), addition_B(addition_B(bitshift(T, 10), bitshift(T, 5)), addition_B(bitshift(T, 2), T)));
C(2) = addition_B(addition_B(C(2), bitshift(T, -22)), addition_B(bitshift(T, -27), bitshift(T, -29)));
C(18) = bitand(C(18), 134217727);
out = C(1:18);
return

