function param = produce_ECC_param(series)
%produce_ECC_param produce parameter of ECC
%   series: series of ECC (field-order)
field = series(1);
order = str2double(series(3: end));
switch field
    case 'P'
    case 'B'
        param = produce_ECC_B_param(order);
    case 'K'
end
end

function param = produce_ECC_B_param(order)
%produce_ECC_B_param produce parameter of ECC B series
%   order: order of ECC B series
wordlength = 32;
param.m = order;
switch order
    case 163
        func_power = [0, 3, 6, 7, 163];
        param.S = ['E693A268'; '7553F9D0'; 'DB12016F'; '5C86226C'; '85E25BFE'; '00000000'];
        param.a = ['00000001'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.b = ['4a3205fd'; '512f7874'; '1481eb10'; 'b8c953ca'; '0a601907'; '00000002'];
        param.n = ['a4234c33'; '77e70c12'; '000292fe'; '00000000'; '00000000'; '00000004'];
        param.x = ['e8343e36'; 'd4994637'; 'a0991168'; '86a2d57e'; 'f0eba162'; '00000003'];
        param.y = ['797324f1'; 'b11c5c0c'; 'a2cdd545'; '71a0094f'; 'd51fbc6c'; '00000000'];
    case 233
        func_power = [0, 74, 233];
        param.S = ['049B50C3'; '4B20A2DB'; '0EA14B34'; '7F6B413D'; '74D59FF0'; '00000000'; '00000000'; '00000000'];
        param.a = ['00000001'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.b = ['7D8F90AD'; '81FE115F'; '20E9CE42'; '213B333B'; '0923BB58'; '332C7F8C'; '647EDE6C'; '00000066'];
        param.n = ['03CFE0D7'; '22031D26'; 'E72F8A69'; '0013E974'; '00000000'; '00000000'; '00000000'; '00000100'];
        param.x = ['71FD558B'; 'F8F8EB73'; '391F8B36'; '5FEF65BC'; '39F1BB75'; '8313BB21'; 'C9DFCBAC'; '000000FA'];
        param.y = ['01F81052'; '36716F7E'; 'F867A7CA'; 'BF8A0BEF'; 'E58528BE'; '03350678'; '6A08A419'; '00000100'];
    case 283
        func_power = [0, 5, 7, 12, 283];
        param.S = ['06BB84BE'; '2DFC88CD'; '2A6DD5B6'; '70EB0F83'; '77E2B073'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.a = ['00000001'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.b = ['3B79A2F5'; 'F6263E31'; 'A581485A'; '45309FA2'; 'CA97FD76'; '19A0303F'; 'A5A4AF8A'; 'C8B8596D'; '027B680A'];
        param.n = ['EFADB307'; '5B042A7C'; '938A9016'; '399660FC'; 'FFFFEF90'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; '03FFFFFF'];
        param.x = ['86B12053'; 'F8CDBECD'; '80E2E198'; '557EAC9C'; '2EED25B8'; '70B0DFEC'; 'E1934F8C'; '8DB7DD90'; '05F93925'];
        param.y = ['BE8112F4'; '13F0DF45'; '826779C8'; '350EDDB0'; '516FF702'; 'B20D02B4'; 'B98FE6D4'; 'FE24141C'; '03676854'];
    case 409
        func_power = [0, 87, 409];
        param.S = ['4262210B'; '4C4BCD4D'; '79213D09'; '57F9D69F'; '4099B5A4'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.a = ['00000001'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.b = ['7B13545F'; '4F50AE31'; 'D57A55AA'; '72822F6C'; 'A9A197B2'; 'D6AC27C8'; '4761FA99'; 'F1F3DD67'; '7FD6422E'; '3B7B476B'; '5C4B9A75'; 'C8EE9FEB'; '0021A5C2'];
        param.n = ['D9A21173'; '8164CD37'; '9E052F83'; '5FA47C3C'; 'F33307BE'; 'AAD6A612'; '000001E2'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '01000000'];
        param.x = ['BB7996A7'; '60794E54'; '5603AEAB'; '8A118051'; 'DC255A86'; '34E59703'; 'B01FFE5B'; 'F1771D4D'; '441CDE4A'; '64756260'; '496B0C60'; 'D088DDB3'; '015D4860'];
        param.y = ['0273C706'; '81C364BA'; 'D2181B36'; 'DF4B4F40'; '38514F1F'; '5488D08F'; '0158AA4F'; 'A7BD198D'; '7636B9C5'; '24ED106A'; '2BBFA783'; 'AB6BE5F3'; '0061B1CF'];
    case 571
        func_power = [0, 2, 5, 10, 571];
        param.S = ['7f132310'; '0410c53a'; '486b0f61'; '3a0e33ab'; '2aa058f7'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.a = ['00000001'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'; '00000000'];
        param.b = ['2955727A'; '7FFEFF7F'; '39BACA0C'; '520E4DE7'; '78FF12AA'; '4AFD185A'; '56A66E29'; '2BE7AD67'; '8EFA5933'; '84FFABBD'; '4A9A18AD'; 'CD6BA8CE'; 'CB8CEFF1'; '5C6A97FF'; 'B7F3D62F'; 'DE297117'; '2221F295'; '02F40E7E'];
        param.n = ['2FE84E47'; '8382E9BB'; '5174D66E'; '161DE93D'; 'C7DD9CA1'; '6823851E'; '08059B18'; 'FF559873'; 'E661CE18'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; 'FFFFFFFF'; '03FFFFFF'];
        param.x = ['8EEC2D19'; 'E1E7769C'; 'C850D927'; '4ABFA3B4'; '8614F139'; '99AE6003'; '5B67FB14'; 'CDD711A3'; 'F4C0D293'; 'BDE53950'; 'DB7B2ABD'; 'A5F40FC8'; '955FA80A'; '0A93D1D2'; '0D3CD775'; '6C16C0D4'; '34B85629'; '0303001D'];
        param.y = ['1B8AC15B'; '1A4827AF'; '6E23DD3C'; '16E2F151'; '0485C19B'; 'B3531D2F'; '461BB2A8'; '6291AF8F'; 'BAB08A57'; '84423E43'; '3921E8A6'; '1980F853'; '009CBBCA'; '8C6C27A6'; 'B73D69D7'; '6DCCFFFE'; '42DA639B'; '037BF273'];
end
param.f = func_power2hex(func_power, func_power(end), wordlength);
param.fr = func_power2hex(func_power(1: end - 1), func_power(end), wordlength);
end