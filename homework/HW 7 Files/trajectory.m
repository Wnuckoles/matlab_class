function acceleration=trajectory(x,y,p)

g=p(1);
gamma=p(3);

acceleration=zeros(4,1);

acceleration(1)=[y(3); -(gamma*sqrt(y(3)^2 + y(4)^2)*y(3))];
acceleration(2)= [y(4); -(gamma*sqrt(y(3)^2 + y(4)^2)*y(4))-g];