%
% Reduction for B163
%
function out=reduction_B163(C)
%
% ref. Guide p.55
%
for i=12:-1:7
    T=uint32(C(i));
    C(i-6)=addition_B(C(i-6),bitshift(T,29));
    C(i-5)=addition_B(addition_B(addition_B(C(i-5),bitshift(T,4)),addition_B(bitshift(T,3),bitshift(T,-3))),T);
    C(i-4)=addition_B(addition_B(C(i-4),bitshift(T,-28)),bitshift(T,-29));
end
T=uint32(C(6));
T=bitshift(T,-3);
C(1)=addition_B(addition_B(addition_B(C(1),bitshift(T,7)),addition_B(bitshift(T,6),bitshift(T,3))),T);
% C(2)=addition_B(addition_B(C(2),bitshift(T,-25)),bitshift(T,-26));
C(2)=addition_B(addition_B(addition_B(C(2),bitshift(T,-25)),bitshift(T,-26)),bitshift(T,-29));
C(6)=bitand(C(6),7);
out=C(1:6);
return