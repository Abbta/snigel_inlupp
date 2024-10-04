t=0:1/1e4:0.1; %sampling 10 kHz during 0.1s
X=square(2*pi*t*50); %50 Hz square wave

L=1/100;
f=@(x) 4./pi.*(sin(pi*x./L)+1/3.*sin(3*pi*x./L));%+1/5.*sin(5*pi*x./L)+1/7.*sin(7*pi*x./L)); 

R2_R3=0.32;
G=10;
C=1/1e6;
R=10400;

s=tf('s');
H3=-1/((1+((R2_R3)*G/(R*C)*(1/s))+(G/(R*C)*1/s)^2));
H2=H3*(1/s*G/(R*C));
H1=H2*(1/s*G/(R*C));

Y=lsim(H1, X, t);
plot(t, Y);
hold on
plot(t, X);
hold on
plot(t, f(t), "LineStyle","--")