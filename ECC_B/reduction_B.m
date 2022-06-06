function out = reduction_B(C, order)
% reduction_B reduce C modulo f
switch order
    case 163
        out = reduction_B163(C);
    case 233
        out = reduction_B233(C);
    case 283
        out = reduction_B283(C);
    case 409
        out = reduction_B409(C);
    case 571
        out = reduction_B571(C);
end
end
%
% Reduction for B163
%
function out=reduction_B163(C)
%
% ref. Guide p.55
%
for i=11:-1:7
    T=uint32(C(i));
    C(i-6)=addition_B(C(i-6),bitshift(T,29));
    C(i-5)=addition_B(addition_B(addition_B(C(i-5),bitshift(T,4)),addition_B(bitshift(T,3),bitshift(T,-3))),T);
    C(i-4)=addition_B(addition_B(C(i-4),bitshift(T,-28)),bitshift(T,-29));
end
T=uint32(C(6));
T=bitshift(T,-3);
C(1)=addition_B(addition_B(addition_B(C(1),bitshift(T,7)),addition_B(bitshift(T,6),bitshift(T,3))),T);
% C(2)=addition_B(addition_B(C(2),bitshift(T,-25)),bitshift(T,-26));
C(2)=addition_B(addition_B(addition_B(C(2),bitshift(T,-25)),bitshift(T,-26)),bitshift(T,-29));
C(6)=bitand(C(6),7);
out=C(1:6);
end

function out = reduction_B233(C)
%reduction_B233 reduce C modulo f
for i = 16: -1: 9
    T = uint32(C(i));
    C(i - 8) = addition_B(C(i - 8), bitshift(T, 23));
    C(i - 7) = addition_B(C(i - 7), bitshift(T, -9));
    C(i - 5) = addition_B(C(i - 5), bitshift(T, 1));
    C(i - 4) = addition_B(C(i - 4), bitshift(T, -31));
end
T = bitshift(uint32(C(8)), -9);
C(1) = addition_B(C(1), T);
C(3) = addition_B(C(3), bitshift(T, 10));
C(4) = addition_B(C(4), bitshift(T, -22));
C(8) = bitand(C(8), hex2dec('1FF'));
out = C(1: 8);
end

function out = reduction_B283(C)
%reduction_B283 reduce C modulo f
for i = 18: -1: 10
    T = uint32(C(i));
    C(i - 9) = addition_B(addition_B(addition_B(C(i - 9), bitshift(T, 5)), addition_B(bitshift(T, 10), bitshift(T, 12))), bitshift(T, 17));
    C(i - 8) = addition_B(addition_B(addition_B(C(i - 8), bitshift(T, -27)), addition_B(bitshift(T, -22), bitshift(T, -20))), bitshift(T, -15));
end
T = bitshift(uint32(C(9)), -27);
C(1) = addition_B(addition_B(addition_B(C(1), T), addition_B(bitshift(T, 5), bitshift(T, 7))), bitshift(T, 12));
C(9) = bitand(C(9), hex2dec('7FFFFFF'));
out = C(1: 9);
end

function out = reduction_B409(C)
%reduction_B409 reduce C modulo f
for i = 26: -1: 14
    T = uint32(C(i));
    C(i - 13) = addition_B(C(i - 13), bitshift(T, 7));
    C(i - 12) = addition_B(C(i - 12), bitshift(T, -25));
    C(i - 11) = addition_B(C(i - 11), bitshift(T, 30));
    C(i - 10) = addition_B(C(i - 10), bitshift(T, -2));
end
T = bitshift(uint32(C(13)), -25);
C(1) = addition_B(C(1), T);
C(3) = addition_B(C(3), bitshift(T, 23));
C(13) = bitand(C(13), hex2dec('1FFFFFF'));
out = C(1: 13);
end

function out = reduction_B571(C)
%reduction_B571 reduce C modulo f
for i = 36: -1: 19
    T = uint32(C(i));
    C(i - 18) = addition_B(addition_B(addition_B(C(i - 18), bitshift(T, 5)), addition_B(bitshift(T, 7), bitshift(T, 10))), bitshift(T, 15));
    C(i - 17) = addition_B(addition_B(addition_B(C(i - 17), bitshift(T, -27)), addition_B(bitshift(T, -25), bitshift(T, -22))), bitshift(T, -17));
end
T = bitshift(uint32(C(18)), -27);
C(1) = addition_B(addition_B(addition_B(C(1), T), addition_B(bitshift(T, 2), bitshift(T, 5))), bitshift(T, 10));
C(18) = bitand(C(18), hex2dec('7FFFFFFF'));
out = C(1: 18);
end
