function out = rand_col_vector(param, max)
%rand_col_vector return column vector with random number
%   param: parameter of column vector
%   max: maximum value
out = param.S;
for i = 1: length(out)
    out(i) = round(intmax('uint32') * rand);
end
if nargin == 2
    scale = 1;
    while scale == 1
        scale = rand;
    end
    out(end) = round(out(end) * scale);
end
end