%
% ECC B163 ElGamal cryptographic systems
%
clear;
clc;
global f fr ifx a b f_dec fr_dec a_dec b_dec;
m=163;
f=['000000c9';'00000000';'00000000';'00000000';'00000000';'00000008'];
fr=['000000c9';'00000000';'00000000';'00000000';'00000000';'00000000'];
a=['00000001';'00000000';'00000000';'00000000';'00000000';'00000000'];
b=['4a3205fd';'512f7874';'1481eb10';'b8c953ca';'0a601907';'00000002'];
n=['a4234c33';'77e70c12';'000292fe';'00000000';'00000000';'00000004'];
Gx=['e8343e36';'d4994637';'a0991168';'86a2d57e';'f0eba162';'00000003'];
Gy=['797324f1';'b11c5c0c';'a2cdd545';'71a0094f';'d51fbc6c';'00000000'];
%
ifx=size(f,1);
zero=zeros(ifx,1);
one=zeros(ifx,1);
one(1)=1;
%
f_dec=hex2dec(f);
fr_dec=hex2dec(fr);
a_dec=hex2dec(a);
b_dec=hex2dec(b);
n_dec=hex2dec(n);
Gx_dec=hex2dec(Gx);
Gy_dec=hex2dec(Gy);
%
% test
% equation: Guide, p.81
%
left=addition_B(square_B(Gy_dec),multiplication_B(Gx_dec,Gy_dec));
right=addition_B(multiplication_B(square_B(Gx_dec),addition_B(Gx_dec,a_dec)),b_dec);
check=any(left-right)
%
% ECC cryptographic system
% A sends message to B
%
% preprocess for B
% private key: nb
% public key: G=[Gx,Gy], Pb(=nb*G)
%
ECC_B163_ElGamal=cputime;
nb=['00000065';'00000000';'00000000';'ffffffff';'ffffffff';'00000000'];
nb_dec=hex2dec(nb);
[Pbx,Pby]=point_multiplication_B(Gx_dec,Gy_dec,nb_dec);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% encryption
% message: Pm
% private key: na
%
% M='Someday you will cry for me like I cried for you. Someday you will miss me like I missed you,';
M='Someday';
M_leng=length(M);
M_dec=double(M);
Pmx=zeros(ifx,M_leng);
Pmy=zeros(ifx,M_leng);
load M;
for im=1:M_leng
    Pmx(:,im)=Mx(:,M_dec(im)-31);
    Pmy(:,im)=My(:,M_dec(im)-31);
end
na=['00000029';'00000000';'ffffffff';'ffffffff';'ffffffff';'00000000'];
na_dec=double(na);
%
% Pa=na*G;
%
[Pax,Pay]=point_multiplication_B(Gx_dec,Gy_dec,na_dec);
%
% naPb=na*Pb
%
[naPbx,naPby]=point_multiplication_B(Pbx,Pby,na_dec);
%
% PmnaPb=Pm+naPb
%
PmnaPbx=zeros(ifx,M_leng);
PmnaPby=zeros(ifx,M_leng);
for im=1:M_leng
    [PmnaPbx(:,im),PmnaPby(:,im),Z]=point_addition_B(Pmx(:,im),Pmy(:,im),one,naPbx,naPby,one);
    Z
    Z=multiplicative_inverse_B(Z);
    Z2=square_B(Z);
    Z3=multiplication_B(Z2,Z);
    %
    PmnaPbx(:,im)=multiplication_B(PmnaPbx(:,im),Z2);
    PmnaPby(:,im)=multiplication_B(PmnaPby(:,im),Z3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% decryption
% received message: Pa, PmnaPb
%
% nbPa=nb*Pa
%
[nbPax,nbPay]=point_multiplication_B(Pax,Pay,nb_dec);
%
% R_Pm=PmnaPb-nbPa (attention: - not +)
%
R_Pmx=zeros(ifx,M_leng);
R_Pmy=zeros(ifx,M_leng);
for im=1:M_leng
    [R_Pmx(:,im),R_Pmy(:,im),Z]= ...
        point_addition_B(PmnaPbx(:,im),PmnaPby(:,im),one,nbPax,addition_B(nbPax,nbPay),one);
    Z=multiplicative_inverse_B(Z);
    Z2=square_B(Z);
    Z3=multiplication_B(Z2,Z);
    %
    R_Pmx(:,im)=multiplication_B(R_Pmx(:,im),Z2);
    R_Pmy(:,im)=multiplication_B(R_Pmy(:,im),Z3);
end
%
R_M_dec=zeros(1,M_leng);
for im=1:M_leng
    R_M_dec(im)=floor(R_Pmx(1,im)/100);
end
R_M=char(R_M_dec);
%
%
fprintf('\nthe original message: %s\n',M);
fprintf('\nthe recovery message: %s\n',R_M);



ECC_B163_ElGamal=cputime-ECC_B163_ElGamal;



nb=['00000065';'00000000';'00000000';'ffffffff';'ffffffff';'00000000'];
na=['00000029';'00000000';'ffffffff';'ffffffff';'ffffffff';'00000000'];
M='Do not judge a book by its cover. Do not judge me from my outside.';


