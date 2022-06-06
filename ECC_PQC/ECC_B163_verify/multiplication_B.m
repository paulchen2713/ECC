%
% Mulplication over B
%
% ref. Guide p.49
%
function out=multiplication_B(a,b)
global ifx;
b(ifx+1)=0;
c=zeros(2*ifx,1);
for k=1:32
    for j=1:ifx
        if bitget(a(j),k)==1
            Cj=c(j:j+ifx);
            Cj=addition_B(Cj,b);
            c(j:j+ifx)=Cj;
        end
    end
    b=special_bitshift_left_B(b);
end
out=reduction_B163(c);
return

