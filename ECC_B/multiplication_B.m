%
% Mulplication over B
%
% ref. Guide p.49
%
function out=multiplication_B(a,b, param)
word_num = size(param.S, 1);
b(word_num+1)=0;
c=zeros(2*word_num,1);
for k=1:32
    for j=1:word_num
        if bitget(a(j),k)==1
            Cj=c(j:j+word_num);
            Cj=addition_B(Cj,b);
            c(j:j+word_num)=Cj;
        end
    end
    b=special_bitshift_left_B(b, param);
end
out=reduction_B(c, param.m);
return

