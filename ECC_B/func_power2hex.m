function hex_fp = func_power2hex(func_power, order, wordlength)
%func_power2hex change power of function to hexidecimai
%   func_power: double array of function power
%   order: order of function
%   wordlength: wordlength of binary representation
fp_word_num = ceil((order + 1) / wordlength);  % length of binary representation
bin_fp = blanks(fp_word_num * wordlength);
bin_fp(:) = '0';
for i = 1: length(func_power)
    bin_fp(func_power(i) + 1) = '1';
end
bin_fp = fliplr(bin_fp);
hex_fp = dec2hex(bin2dec(reshape(bin_fp, 4, []).')).';
hex_fp = flipud(reshape(hex_fp, wordlength / 4, []).');
end