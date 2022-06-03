%
% point multiplication function for ECC
%
function out = point_multiplication(G, n)
global p a;
p = 23;
a = 1;
% 
if G(2) == 0
    % point addition
    nGx = 0;
    nGy = 0;
    % nG represent the outcome of point G x n times
    nG = [nGx, nGy];
else
    % point doubling
    di = 0; %nmultiplicative inverse
    for ip = 1 : p
        if mod(2*G(2)*ip, p) == 1
            di = ip;
        end
    end
    delta = mod((3*G(1)^2 + a) * di, p);
    nGx = mod(delta^2 - 2*G(1), p);
    nGy = mod(delta*(G(1) - nGx) - G(2), p);
    nG = [nGx, nGy];
end
%
for in = 1 : n-2
    if nGx == 0 && nGy == 0
        % first condition, infinite point addition
        nGx = 0;
        nGy = 0;
        nG = [nGx, nGy];
    elseif nGx == G(1) && nGy == G(2)
        % second condition, 
        if G(2) == 0
            % point addition
            nGx = 0;
            nGy = 0;
            nG = [nGx, nGy];
        else
            % point doubling
            di = 0; % multiplicative inverse
            for ip = 1 : p
                if mod(2*G(2)*ip, p) == 1
                    di = ip;
                end
            end
            delta = mod((3*G(1)^2 + a) * di, p);
            nGx = mod(delta^2 - 2*G(1), p);
            nGy = mod(delta*(G(1) - nGx) - G(2), p);
            nG = [nGx, nGy];
        end
    elseif nGx == G(1) && nGy == mod(-G(2), p)
        % third condition, 
        nGx = 0;
        nGy = 0;
        nG = [nGx, nGy];
    else
        % fourth condition, normal addition of 2 diff point
        % find multiplicative inverse
        % P(xP, yP), Q(xQ, yQ), R(xR, yR)
        for ip = 1 : p
            if mod((G(1) - nGx) * ip, p) == 1
                di = ip;
            end
            delta = mod((G(2) - nGy)*di, p);
            temp = nGx; 
            % xR = delta^2 - xP - xQ
            nGx = mod(delta^2 - nGx - G(1), p);
            % yR = dleta*(xP-xR) - xP
            nGy = mod(delta*(temp - nGx) - nGy, p);
            nG = [nGx, nGy];
        end
    end
end
out = nG;

return
