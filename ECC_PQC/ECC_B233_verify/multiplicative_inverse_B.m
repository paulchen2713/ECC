%
% Multiplicative inverse module f(x)
%
function out=multiplicative_inverse_B(a)
global f_dec ifx;
one=zeros(ifx,1);
one(1)=1;
zero=zeros(ifx,1);
%
% ref. Guide p.59
%
u=a;
v=f_dec;
g1=one;
g2=zero;
while any(u-one) && any(v-one)
    while bitget(u(1,:),1)==0
        u=bitshift_right_B(u);
        if bitget(g1(1,:),1)==0
            g1=bitshift_right_B(g1);
        else
            g1=bitshift_right_B(addition_B(g1,f_dec));
        end
    end
    while bitget(v(1,:),1)==0
        v=bitshift_right_B(v);
        if bitget(g2(1,:),1)==0
            g2=bitshift_right_B(g2);
        else
            g2=bitshift_right_B(addition_B(g2,f_dec));
        end
    end
    i=ifx;
    while u(i)==0
        i=i-1;
    end
    j=32;
    while bitget(u(i),j)==0
        j=j-1;
    end
    deg_u=(i-1)*32+j;
    i=ifx;
    while v(i)==0
        i=i-1;
    end
    j=32;
    while bitget(v(i),j)==0
        j=j-1;
    end
    deg_v=(i-1)*32+j;
    if deg_u > deg_v
        u=addition_B(u,v);
        g1=addition_B(g1,g2);
    else
        v=addition_B(u,v);
        g2=addition_B(g1,g2);
    end
end
if any(u-one)==0
    out=g1;
else
    out=g2;
end
return