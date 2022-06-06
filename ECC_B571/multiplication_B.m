%
% Mulplication over B function
%
% ref. Guide to ECC textbook, p.49
%
% Algorithm 2.34 Right-to-left comb method for polynomial multiplication
function out = multiplication_B(a, b)
% global ifx;
% f = z^571 + z^10 + z^5 + z^2 + z^0
f = ['00000425';'00000000';'00000000';'00000000';'00000000';'00000000';
     '00000000';'00000000';'00000000';'00000000';'00000000';'00000000';
     '00000000';'00000000';'00000000';'00000000';'00000000';'08000000'];
%
ifx = size(f, 1);
%
b(ifx + 1) = 0;
c = zeros(2*ifx, 1); % 12 sections of 
for k = 1 : 32
    for j = 1 : ifx
        % if the bit == 1(exist) then perform operation
        if bitget(a(j), k) == 1
            Cj = c(j : j+ifx);
            Cj = addition_B(Cj, b);
            c(j : j+ifx) = Cj;
        end
    end
    % special case for 
    b = special_bitshift_left_B(b);
end
out = reduction_B571(c);
return
