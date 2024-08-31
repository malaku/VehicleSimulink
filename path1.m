if set_track ==1 % sinosoidal
    
%-------------------sinosoidal track definition----------------------------

x=0:0.25:200; %  x coordinate
x=x(:);

y=sinosoidal(x);
radius=60;

n=size(x,1);

%plot(x,y,out.simout.Data,out.simout1.Data)

 ylim([-1,5]);

curve = zeros(n,1);

for i=1:1:n  % loop which calculates the curvature of the track
    
   if i==1
    curve(i) = curv(i,x(i),0,x(i+1),y(i),0,y(i+1),n);
    elseif i==n
    curve(i) = curv(i,x(i),x(i-1),0,y(i),y(i-1),0,n);
    else
    curve(i) = curv(i,x(i),x(i-1),x(i+1),y(i),y(i-1),y(i+1),n);
    end
end

elseif set_track ==2% constant radius
    
%-------------------Constant radius circular track definition---------------

x_center=0; 
y_center=0;
radius=40;
th = 0:pi/200:2*pi;
x = radius * cos(th) + x_center;
x=x(:);
y = radius * sin(th) + y_center;
plot(x, y);

n=size(x,1);

curve = (1/radius).* ones(length(x),1);

else %--------- Straight line track----------------------------------------

x=0:0.5:1100; 
x=x(:);

y=zeros(size(x));

n=size(x,1);

radius = 40;
plot(x,y);
ylim([-5,30]);

curve = zeros(n,1);

for i=1:1:n  % loop which calculates the curvature of the track
    
   if i==1
    curve(i) = curv(i,x(i),0,x(i+1),y(i),0,y(i+1),n);
    elseif i==n
    curve(i) = curv(i,x(i),x(i-1),0,y(i),y(i-1),0,n);
    else
    curve(i) = curv(i,x(i),x(i-1),x(i+1),y(i),y(i-1),y(i+1),n);
    end
end   
    
end

%----------------defines the coordinate (s) along the path-----------------

s = zeros(n,1);
for i=2:1:n   
   s(i) = s(i-1)+ sqrt((x(i)-x(i-1))^2+(y(i)-y(i-1))^2); % 
end

%-----------------------------------------------------------------------------------------