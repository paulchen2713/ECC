%
% ECC ( Elliptic Curve Cryptography ) B
% point double
%
% ref. Handbook of E & H p.293
%
function [X3,Y3,Z3]=point_double_B(X1,Y1,Z1, param)
word_num = size(param.S, 1);
zero=zeros(word_num,1);
one=zeros(word_num,1);
one(1)=1;
%
if any(X1-one)==0 && any(Y1-one)==0 && any(Z1-zero)==0
    X3=one;
    Y3=one;
    Z3=zero;
else
    A=square_B(X1, param);
    B=square_B(A, param);
    C=square_B(Z1, param);
    C2=square_B(C, param);
    C4=square_B(C2, param);
    bC4=multiplication_B(param.b,C4, param);
    X3=addition_B(B,bC4);
    Z3=multiplication_B(X1,C, param);
    Y1Z1=multiplication_B(Y1,Z1, param);
    SUM=addition_B(addition_B(A,Y1Z1),Z3);
    SUMX3=multiplication_B(SUM,X3, param);
    BZ3=multiplication_B(B,Z3, param);
    Y3=addition_B(BZ3,SUMX3);
end
return
