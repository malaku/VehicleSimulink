g=  9.81;           % acceleration due to gravity (m/s^2)
MT = 1792.23;       % car total mass             (kg)
muf = 99;           % total forward unsprung mass             (kg)
mur = 84;           % total rear unsprung mass             (kg)

m = MT-(muf+mur);   % total sprung mass                 (kg)

mu1 = muf/2;    mu2=mu1;    % unsprung masses (kg)
mu3 = mur/2;    mu4=mu3;

h=0.5378144918;

L=   2.72;          % Variables are based on Adams/Car library sedan model
Bf = 1.552;
Br = 1.56;

l1= 1.12695753;     % Distance of front wheel and CG  (m)  
l2= L-l1;           % Distance of rear wheel and CG   (m)
 
if Model == 1
    b1 = 0; b2=0;
    b3 = 0; b4=0;
else    
    b1 = Bf/2; b2=b1;
    b3 = Br/2; b4=b3;
end

hzrc = 0.05;        % roll centre height (m)
hzpc = 0.05;        % pitch centre height (m)

drc = h-hzrc;       % distance from c.g_sprung to RC (m)
dpc = h-hzpc;

nu_x = 0.8; 
nu_y = 0.8;

mu=0.8;             % Traction co-efficient

%--------------------------------------------------------------------------

ks1 = 265000 ;       % wheel rates (Calculated from Adams) (N/m)
ks2 = 265000;
ks3 = 52500 ;
ks4 = 52500 ;

cs1 = 4500 ;         %  Suspension damping (obtained from Adams)
cs2 = 4500  ;
cs3 = 11207  ;
cs4 = 11207  ;

k1t = 200000;       % Tire stiffness (Obtained from Adams)
k2t = 200000;
k3t = 200000;
k4t = 200000;

%--------------------------------------------------------------------------

Ws = m*g;                   % Total weight of sprung mass (N)

Ws1 = (l2*Ws)/(2*L);        % Weight on front wheels (N)
Ws2 = (l2*Ws)/(2*L);     
Ws3 = (l1*Ws)/(2*L);     
Ws4 = (l1*Ws)/(2*L);     

W1 = Ws1 + mu1*g;
W2 = Ws2 + mu2*g;
W3 = Ws3 + mu3*g;
W4 = Ws4 + mu4*g;

Wf = Ws1+Ws2;
Wr = Ws3+Ws4;

mf = Wf/g;                      % Front and rear sprung masses (kg)
mr = Wr/g;

Iz=1187;                        % Moment of Inertia about yaw axis(kgm^2)
Iy = 1086 + m*dpc^2;            % Moment of Inertia about pitch axis(kgm^2)
Ix = 233.072773102 + m*drc^2;   % Moment of Inertia about roll axis(kgm^2)

Iy_Iz = Iy -Iz;
Iz_Ix = Iz -Ix;
Ix_Iy = Ix -Iy;

zu1_0 = -W1/k1t;                 % Static displacements of sprung masses
zu2_0 = -W2/k2t;
zu3_0 = -W3/k3t;
zu4_0 = -W4/k4t;

zs_0 = (Ws)/(ks1+ks2+ks3+ks4);

%--------------------------------------------------------------------------
kus = ((W1+W2)/(123000)) - ((W3+W4)/(115200)); % understeer 
%kus = 0.0078;

%% New
Leq=1.5e-3;
Req=0.5;
Ka=0.05;
Ke=0.168;
Kp=10/pi;
Jeq=0.00025;
Beq=0.0001;
gr=(10/32)^2;

T20=0;
K_v=00;
K_theta=00;
% Sensor model
wn = 100*2*pi;
wm= 12.5 *2*pi;
zeta = sqrt(2)/2;
z=zeta;
bias=80;