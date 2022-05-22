%
% ECC(Elliptic Curve Cryptography)
%
% example_p326: Stallings, 7th-edition, p.326
% y^2 = x^3 + ax + b
%
clear;
clc;
%
global p a;
p = 8831; % 23 % 8831
a = 3;    % 1  % 3
b = 45;   % 1  % 45
%
%
XY = zeros(1, 2); % store every points solution
index = 0;        % total number of points == index + 1
for ix = 0 : p-1
    % y^2 = x^3 + ax + b
    y2 = mod(ix^3 + a*ix+b, p); % y2 <-- y^2
    for iy = 0 : p-1
        if mod(iy^2, p) == y2
            index = index+1;
            XY(index, 1) = ix;
            XY(index, 2) = iy;
        end
    end
end
%
% plot(XY(:, 1), XY(:, 2), 'o');
% axis([0, p, 0, p]);
% grid on;     % plot dotted grid line mode "on"
% xlabel('x');
% ylabel('y');
%
%
% ECC cryptographic system
%
% Alice sends a message to Bob
%
% preprocess for Bob
% private key: nb
% public key:  Pb = (nb*G), G
% 
G = [4, 11]; 
nb = 3;
Pb = point_multiplication(G, nb);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Encryption process for Alice
%
% number mode:
%   message: Pm
%   private key: k
%   Pm = [5, 1473];
%   k = 5;
% 
% string mode:
%   message: M
%   private key: k
%
M = 'Someday';     % message to be encrypted
M_len = length(M); % length of the message
M_dec = double(M); % message in double decimal(0~255)
Pm = zeros(M_len, 2);
k = 5;
%
for im = 1 : M_len
    % 970 ~ 979
    for ix = M_dec(im)*10 : M_dec(im)*10 + 9
        % y^2 = x^3 + ax + b
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
C1 = point_multiplication(G, k);   % number mode == string mode
%
% kPb = k*Pb
%
kPb = point_multiplication(Pb, k); % number mode == string mode
%
% C2 = Pm + kPb
%
% C2 = point_addition(Pm, kPb); % number mode
C2 = zeros(M_len, 2);           % string mode
for im = 1 : M_len
    C2(im, :) = point_addition(Pm(im, :), kPb);
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Decryption process for Bob
%
% received message: C1, C2
% 
% C1*nb
% 
% number mode == string mode
nbC1 = point_multiplication(C1, nb); % multiplication order cannot be change
%
% recovered message: R_Pm = C2 + (-nbC1)
%
nbC1(2) = -nbC1(2); % acquire negative nbC1 '-nbC1'
% R_Pm = point_addition(C2, nbC1); % number mode
R_Pm = zeros(M_len, 2);            % string mode
for im = 1 : M_len
    R_Pm(im, :) = point_addition(C2(im, :), nbC1);
end
%
% recover the message by fetching the x coordinates
% e.g. 630~639 all are 63
R_M = (char(floor(R_Pm(:, 1)/10)))'; % ()' will transpose the vector
%
% print out the resulting data
%
fprintf('\n The original message is:   %s\n', M);
fprintf('\n The recovered message is: %s\n', R_M);





