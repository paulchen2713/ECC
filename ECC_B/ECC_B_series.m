% ECC B series ElGamal crytographic systems
clear; 
clc;

series = 'B-233'; % 163, 233, 283, 409, 571
param = produce_ECC_param(series);
dec_param = ECC_B_param2dec(param);
word_num = size(dec_param.S, 1);
zero = zeros(word_num, 1);
one = zeros(word_num, 1);
one(1) = 1;

% polynomial test
% ref: Guide, p.81
left = addition_B(square_B(dec_param.y, dec_param), multiplication_B(dec_param.x, dec_param.y, dec_param));
right = addition_B(multiplication_B(square_B(dec_param.x, dec_param), addition_B(dec_param.x, dec_param.a), dec_param), dec_param.b);
check = any(left - right);

% ECC cryptographic system
% A sends message to B
%
% preprocess for B
% private key: nb (nb < n)
% public key: G = [Gx, Gy], Pb = G * nb
op_time = cputime; % get cpu time
nb = rand_col_vector(dec_param, dec_param.n);
[Pbx, Pby] = point_multiplication_B(dec_param.x, dec_param.y, nb, dec_param);

% encryption
% message: M
% private key: na
na = rand_col_vector(dec_param);
M = 'ECC B series ElGamal crytographic systems';
M_len = length(M);
M_dec = double(M);
Pmx = zeros(word_num, M_len);
Pmy = zeros(word_num, M_len);

load('M');

for im = 1: M_len
    Pmx(:, im) = Mx(:, M_dec(im) - 31);
    Pmy(:, im) = My(:, M_dec(im) - 31);
end
% Pa = na * G
[Pax, Pay] = point_multiplication_B(dec_param.x, dec_param.y, dec_param.a, dec_param);
% naPb = na * Pb
[naPbx, naPby] = point_multiplication_B(Pbx, Pby, dec_param.a, dec_param);
% PmnaPb = Pm + naPb
PmnaPbx = zeros(word_num, M_len);
PmnaPby = zeros(word_num, M_len);
for im = 1: M_len
    [PmnaPbx(:, im), PmnaPby(:, im), Z] = point_addition_B(Pmx(:, im), Pmy(:, im), one, naPbx, naPby, one, dec_param);
    % project to original coordinate
    Z = multiplicative_inverse_B(Z, dec_param);
    Z2 = square_B(Z, dec_param);
    Z3 = multiplication_B(Z2, Z, dec_param);
    %
    PmnaPbx(:, im) = multiplication_B(PmnaPbx(:, im), Z2, dec_param);
    PmnaPby(:, im) = multiplication_B(PmnaPby(:, im), Z3, dec_param);
end

%
% decryption
% recerved message: Pa, PmnaPb
%
% nbPa = nb * Pa
[nbPax, nbPay] = point_multiplication_B(Pax, Pay, nb, dec_param);
% R_Pm = PmnaPb - nbPa(attetion: - not +)
R_Pmx = zeros(word_num, M_len);
R_Pmy = zeros(word_num, M_len);
for im = 1: M_len
    % ref. Guide, p.81
    [PmnaPbx(:, im), PmnaPby(:, im), Z] = point_addition_B(PmnaPbx(:, im), PmnaPby(:, im), one, nbPax, addition_B(nbPax, nbPay), one, dec_param);
    % project to original coordinate
    Z = multiplicative_inverse_B(Z, dec_param);
    Z2 =  square_B(Z, dec_param);
    Z3 = multiplication_B(Z2, Z, dec_param);
    %
    R_Pmx(:, im) = multiplication_B(PmnaPbx(:, im), Z2, dec_param);
    R_Pmy(:, im) = multiplication_B(PmnaPby(:, im), Z3, dec_param);
end
% decode message
R_M_dec = zeros(1, M_len);
for im = 1: M_len
    R_M_dec(im) = floor(R_Pmx(1, im) / 100);
end
R_M = char(R_M_dec);

fprintf('the original message: %s\n', M);
fprintf('the recovery message: %s\n', R_M);
op_time = cputime - op_time;
fprintf('time = %d\n', op_time);


