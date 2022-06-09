%
% ECC (Elliptic Curve Cryptography)
%
% example_p331_key exchange: Stallings, 7th-edition, p.326
%
clear;
clc;
%
global p a;
p = 8831;
a = 3;
b = 45;
%
%
XY = zeros(1, 2); % store every points solution
index = 0;        % total number of points == index + 1
for ix = 0 : p-1
    % y^2 = x^3 + ax + b
    y2 = mod(ix^3 + a*ix + b, p); % y2 <-- y^2
    for iy = 0 : p-1
        if mod(iy^2, p) == y2
            index = index + 1;
            XY(index, 1) = ix;
            XY(index, 2) = iy;
        end
    end
end
%
% plot(XY(:, 1), XY(:, 2), 'o');
% axis([0, p, 0, p]);
% grid on;
% xlabel('x');
% ylabel('y');
%
% Diffie-Hellman Key Exchange
%
G = [4, 11]; % based point
%
% user A:
%     private key: na
%     public key: Pa(na*G)
na = 121;
Pa = point_multiplication(G, na);
%
% user B:
%     private key: nb
%     public key: Pb(nb*G)
nb = 203;
Pb = point_multiplication(G, nb);
%
% key generation of A
%
key_A = point_multiplication(Pb, na);
%
% key generation of B
%
key_B = point_multiplication(Pa, nb);
%
% ECC cryptographic system
%
% Alice sends a message to Bob
%
% preprocess for Bob
% private key: nb
% public key: Pb = (nb*G), G
%
G = [4, 11];
nb = 3;
Pb = point_multiplication(G, nb);
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Encryption process for Alice
% message: Pm
% private key: k
%
Pm = [5, 1473];
k = 8;
%
% C1 = k*G
C1 = point_multiplication(G, k);
%
% kPb = k*Pb
kPb = point_multiplication(Pb, k);
%
% C2 = Pm + kPb
C2 = point_addition(Pm, kPb);
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Decryption prcoess for Bob
%
% received message: C1, C2
% 
% C1*nb
nbC1 = point_multiplication(C1, nb); % multiplication order cannot be change
%
% recovered message: R_Pm = C2 + (-nbC1)
nbC1(2) = -nbC1(2); % acquire '-nbC1'
R_Pm = point_addition(C2, nbC1);
