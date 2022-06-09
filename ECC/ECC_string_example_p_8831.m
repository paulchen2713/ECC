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
XY = zeros(1, 2);
index = 0; % total number of points == index + 1
for ix = 0 : p-1
    y2 = mod(ix^3 + a*ix + b, p);
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
G = [4, 11];
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
G = [4, 11];
nb = 3;
Pb = point_multiplication(G, nb);
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Encryption process
% message: M
% private key: k
%
M = 'The message to be encrypted'; % message to be encrypted
M_len = length(M); % length of the message
M_dec = double(M); % message in double decimal(0~255)
Pm = zeros(M_len, 2);
k = 8;
%
for im = 1 : M_len
    for ix = M_dec(im)*10 : M_dec(im)*10 + 9
        y2 = mod(ix^3 + a*ix + b, p); 
        for iy = 0 : p-1
            if mod(iy^2, p) == y2
                % if iy^2 == y2 means the point do exist
                % then can store the result into Pm
                Pm(im, 1) = ix;
                Pm(im, 2) = iy;
            end
        end
    end
end
%
% C1 = k*G
%
C1 = point_multiplication(G, k);
%
% kPb = k*Pb
%
kPb = point_multiplication(Pb, k);
%
% C2 = Pm + kPb
%
C2 = zeros(M_len, 2);
for im = 1 : M_len
    C2(im, :) = point_addition(Pm(im, :), kPb); 
end
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Decryption
%
% message received: C1, C2
% 
% C1*nb
%
nbC1 = point_multiplication(C1, nb); % multiplication order cannot be change
%
% recovered message: R_Pm = C2 + (-nbC1)
%
nbC1(2) = -nbC1(2); % acquire '-nbC1'
R_Pm = zeros(M_len, 2);
for im = 1 : M_len
    % R_Pm = point_addition(C2, nbC1); % original number mode
    R_Pm(im, :) = point_addition(C2(im, :), nbC1);
end
% e.g. 630~639 all are 63
R_M = (char(floor(R_Pm(:, 1)/10)))'; % ()' will transpose the vector
%
% print out the resulting data
%
fprintf('\n Original message is:   %s\n', M);
fprintf('\n Recovered message is: %s\n', R_M);
%
