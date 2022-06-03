%
% point addition function for ECC
%
function R = point_addition(P, Q)
    global p;
    if P(1) == Q(1) && P(2) == Q(2)
        % if P == Q
        R = point_multiplication(P, 2);
    else
        % if P != Q
        for ip = 1 : p-1
            if mod((Q(1) - P(1))*ip, p) == 1
                di = ip;
            end
        end
        delta = mod((Q(2) - P(2))*di, p);
        temp  = P(1);
        
        Rx = mod(delta^2 - P(1) - Q(1), p);
        Ry = mod(delta*(temp - Rx) - P(2), p);
        R = [Rx Ry];
    end
return

