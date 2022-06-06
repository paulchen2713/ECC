%
% Mulplication over B
%
% ref. Guide p.53
%
function out=square_B(a)
global ifx;
cc=2^8;
cc2=cc^2;
c=zeros(2*ifx,1);
for i=1:ifx
    u0=mod(a(i),cc);
    temp=floor(a(i)/cc);
    u1=mod(temp,cc);
    temp=floor(temp/cc);
    u2=mod(temp,cc);
    u3=floor(temp/cc);
    c(2*i-1)=square_pre_B(u0)+square_pre_B(u1)*cc2;
    c(2*i)=square_pre_B(u2)+square_pre_B(u3)*cc2;
end
out=reduction_B163(c);
return

