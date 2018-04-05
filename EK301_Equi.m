load EK301_Vars.mat

[Cr, Cc] = size(C);
A = zeros(Cr*2, Cc);

A(1:Cr,:) = detCoe(C,X);
A(Cr+1:Cr*2,:) = detCoe(C,Y);
