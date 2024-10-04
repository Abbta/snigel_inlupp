G=0; %larger value increases imaginary
R=1; %larger value decreases imaginary
C=1; %larger value decreases imaginary
R2_R3=200; %larger value decreases real, %Moves cutoff further apart
%H3=-s^2/(s^2+R2G/RC s+G^2/(RC)^2)

s=tf('s');
H3=-1/((1+((R2_R3)*G/(R*C)*(1/s))+(G/(R*C)*1/s)^2));
H2=H3*(1/s*G/(R*C));
H1=H2*(1/s*G/(R*C));

figure;
title("H3");
subplot(3,1,1);
iopzplot(H3)
subplot(3,1,2);
impulse(H3)
subplot(3,1,3);
bode(H3)



% figure;
% title("H2");
% subplot(3,1,1);
% iopzplot(H2)
% subplot(3,1,2);
% impulse(H2)
% subplot(3,1,3);
% bode(H2)
% 
% figure;
% title("H1");
% subplot(3,1,1);
% iopzplot(H1)
% subplot(3,1,2);
% impulse(H1)
% subplot(3,1,3);
% bode(H1)

%H3 is HP
%H2 is BP
%H1 is LP
