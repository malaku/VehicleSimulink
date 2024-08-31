clear;

% Four_Bar_Link_version_B    % Loads variables which are necessery for 
% the 4-Bar linkage solution

% -----Choose car model-------------
% (1) for 3DOF bicycle model
% (2) for 4DOF Roll Model
% (3) for 10DOF model

Model = 3;
select

%--------------------------------------------------------------------------
% Here the path is defined through the 'track.m' file. The track file would
% have to be defined accordingly. Set track 1 for the sinosoidal, double 
% lane change(DLC), track or 2 for the constant radius track.

set_track = 1;
path1              %calls the 'path.m' file

%------------Initial position and orientation of vehicle-------------------
% Set according to the track
Xo =  0; 
Yo =  0;
THETAo =0;

hold on;
plot(Xo,Yo,'.','MarkerSize',20);

%---------------Set initial velocities-------------------------------------

vxo= 10;    % Initial longitudinal speed (m/s)
vyo= 0;     % Initial lateral velocity (m/s)
ro= 0;      % Initial yaw rate (rad/s)

%------Open/Closed loop steering toggle------------------------------------
% Select 1 to use the FWS controller or 0 to define FWS angle from a
% time series

sw_delta_f = 1;

%------------------Front wheel-steer angle time series---------------------
% As defined for the ISO 4138 step steering input

t=0:0.01:5.8;
st=zeros(size(t,2),1);

st_ss = 0.024; % steady state front wheel steering angle
Dt = 0.18;
dt = 0.01;

d_st_dt = st_ss/Dt;

for i=302:1:319
    st(i) = st(i-1)+ (d_st_dt)*0.01;
end

for i=320:1:size(st,1)
    st(i) = st_ss;
end

delta_f = timeseries(st,t);

%---------------Open/Closed loop throttle toggle---------------------------
% Select 1 to use the accelerator/brake controller or 0 to define the
% tractive forces manually through atime series
% 
 sw_FX = 0;

%----------------------Traction force time series--------------------------
% Fx1 = 600;      % Traction force on wheels as limited by mu
% Fx2 = 600;      
% Fx3 = 0;      
% Fx4 = 0;      
% Fx = [Fx1; Fx2; Fx3; Fx4];
% 
% t=0:0.01:10;
% Fx=zeros(size(t,2),4);
% 
% for i=1:1:size(t,2)
%     %if i<=601
%     Fx(i,1) = 0;
%     Fx(i,2) = 0;
%     Fx(i,3) = 0;
%     Fx(i,4) = 0;    
%     %end
% end
%     %Fx(t) = [2250;2250;2250;2250];
% 
% FTS = timeseries(Fx,t);

%--------------------------------------------------------------------------
% The 'model_10DOF_revised' defines provides the vehicle specifications

model_10DOF_revised
Allan_Param
randn(1)


cp=0.2;
tpo=cp/6;
%% Extract time and data values from the timeseries object
% Extract time and data values from the timeseries object
% Extract time and data values from the timeseries object
time = out.simout5.Time; % Extracts the time values
data_values =squeeze( out.simout5.Data); % Extracts the data values


