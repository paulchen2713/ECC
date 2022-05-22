%
% point multiplication for ECC
%
function out = point_multiplication(G, n)
    global p a;
    if G(2) == 0
        nGx = 0;
        nGy = 0;
        nG = [nGx nGy];
    else
        di=0;
        for ip=1:p-1
            if mod(2*G(2)*ip,p)==1
                di=ip;
            end
        end
        delta=mod((3*G(1)^2+a)*di,p);
        nGx=mod(delta^2-2*G(1),p);
        nGy=mod(delta*(G(1)-nGx)-G(2),p);
        nG=[nGx nGy];
    end
    for in=1:n-2
        if nGx == 0 && nGy == 0
            nGx=G(1);
            nGy=G(2);
            nG=[nGx nGy];
        elseif nGx==G(1) && nGy==G(2)
            if G(2)==0
                nGx=0;
                nGy=0;
                nG=[nGx nGy];
            else
                for ip=1:p-1
                    if mod(2*G(2)*ip,p)==1
                        di=ip;
                    end
                end
                delta=mod((3*G(1)^2+a)*di,p);
                nGx=mod(delta^2-2*G(1),p);
                nGy=mod(delta*(G(1)-nGx)-G(2),p);
                nG=[nGx nGy];
            end
        elseif nGx==G(1) && nGy==mod(-G(2),p)
            nGx=0;
            nGy=0;
            nG=[nGx nGy];
        else
            for ip=1:p-1
                if mod((G(1)-nGx)*ip,p)==1
                    di=ip;
                end
            end
            delta=mod((G(2)-nGy)*di,p);
            temp=nGx;
            nGx=mod(delta^2-nGx-G(1),p);
            nGy=mod(delta*(temp-nGx)-nGy,p);
            nG=[nGx nGy];
        end
    end
    out=nG;
return



