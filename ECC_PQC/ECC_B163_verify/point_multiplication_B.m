%
% point multiplication for B
%
function [outx,outy]=point_multiplication_B(xi,yi,n)
global ifx;
zero=zeros(ifx,1);
one=zeros(ifx,1);
one(1)=1;
%
nx=xi;
ny=yi;
nz=one;
Px=one;
Py=one;
Pz=zero;
for j=1:ifx
    for i=1:32
        bit=bitget(n(j),i);
        if bit==1
            if any(Px-one)==0 && any(Py-one)==0 && any(Pz-zero)==0
                Px=nx;
                Py=ny;
                Pz=nz;
            else
                [Px,Py,Pz]=point_addition_B(Px,Py,Pz,nx,ny,nz);
            end
            [nx,ny,nz]=point_double_B(nx,ny,nz);
        end
    end
end
Z=multiplicative_inverse_B(Pz);
Z2=square_B(Z);
Z3=multiplication_B(Z2,Z);
%
outx=multiplication_B(Px,Z2);
outy=multiplication_B(Py,Z3);
return







