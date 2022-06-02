%
% ECC(Elliptic Curve Cryptography)
%
% example_p331: Stallings, 7th-edition, p.326
%
clear;
clc;
global p a;
p = 257;
a = 0;
b = -4;
b = mod(b, p);
%
%
XY = zeros(1, 2);
index = 0;
for ix = 0 : p-1
    y2 = mod(ix^3+a*ix+b,p);
    for iy=0:p-1
        if mod(iy^2,p)==y2
            index=index+1;
            XY(index,1)=ix;
            XY(index,2)=iy;
        end
    end
end
plot(XY(:,1),XY(:,2),'o');
axis([0,p,0,p]);
grid on;
xlabel('x');
ylabel('y');
%
% ECC cryptographic system
%
% Alice sends a message to Bob
%
% preprocess for Bob
% private key: nb
% public key: Pb = (nb*G), G
G = [2, 2];
nb = 101;
Pb = point_multiplication(G, nb);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Encryption process
% message: Pm
% private key: k
%
Pm = [112, 26];
k = 41;
%
% C1 = k*G
C1 = point_multiplication(G, k);
%
% kPb = k*Pb
kPb = point_multiplication(Pb, k);
%
% C2 = Pm + kPb
C2 = point_addition(Pm, kPb);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Decryption
%
% message received: C1, C2
% 
% C1*nb
nbC1 = point_multiplication(C1, nb); % multiplication order cannot be change
%
% recovered message: R_Pm = C2 - nbC1
nbC1(2) = -nbC1(2); % acquire '-nbC1'
R_Pm = point_addition(C2, nbC1);



