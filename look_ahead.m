function y = look_ahead(loc_act)

ld = 50;
trans =[cos(loc_act(3)) -sin(loc_act(3)) 0; sin(loc_act(3)) cos(loc_act(3)) 0; 0 0 1];

x=0:1:200;
y=path_(x);

e = 1000;
k=1;
X_o =0;
Y_o =0;
l_des =[0 0];

for i=1:1:200
    
    x_dist = x(i)-loc_act(1);
    y_dist = y(i)-loc_act(2);
    
    l = sqrt((x_dist^2+y_dist^2));
    if l<e
        e=l;
        
        X_o = x(i);
        Y_o = y(i);
        k=i;
        l_act = [X_o, Y_o];
%     else 
%        Xo = 0;
%        Yo = 0;
%        k=50;
%        l_act=[Xo, Yo];
    end
    
end

%------------------desired location---------------------------------------------
for j=k+1:1:201    
    x_dist = x(j)-X_o;
    y_dist = y(j)-Y_o;
    
    l = sqrt((x_dist^2+y_dist^2));
    e = abs(l-ld);
    
    if (e<0.1)
        x_ld = x(j);
        y_ld = y(j);
        
        
        l_des = [x(j)-X_o; y(j)-Y_o; 0]; % this is actually the look ahead vector defined in the global coor frame
        l_des = trans*l_des; % this is the look ahead vector defined in the local(vehicle) frame of reference
        %l_des = [x(j), y(j)];
        break
    end   
end

y = l_des;
