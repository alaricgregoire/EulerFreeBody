function Animate3D(t,rotvec,J,skiprate)
% Animate3D - Animate the rotation of the body from MomentumODE
%
% Syntax: Animate3D(t,rotvec,J,skiprate)
%
% Inputs:
%    t         - time vector
%    rotvec    - Rotation vector representing attitude at time t
%    J         - Inertia Tensor
%    skiprate  - Rate at which samples are shown (1 = All,10 = Every Tenth)
%
% Outputs:
%    Figure 4
%
% Other m-files required: N/A
% Subfunctions: hgt = moveprism(hgt,rvec)
%               S = createPrism0(x,y,z,rvec,ax)
% MAT-files required: N/A
%
% See also: MomentumODE,  PlotsIn3D
% Author: Alaric Gregoire
% agregoire3@gatech.edu
% Last revision: 27-Apr-2020

% For smooth animations with no data skipping, the currently applied plot
% objects can be adjusted at 200 fps including the 0.001 pause.
%
% As an estimate, NSamples should be 200 times the length of the goal 
% animation when the skiprate variable is set to 1. Using skiprate higher
% than 1 will have a "fast forward" effect


% The J values are used to make a proportionally sized prism
Jsize = diag(J)/vecnorm(diag(J));
x = Jsize(1);
y = Jsize(2);
z = Jsize(3);


maxl = max([x,y,z]);

figure(4)
clf(4)
ax = gca;
ax.XLim = [-maxl maxl];
ax.YLim = [-maxl maxl];
ax.ZLim = [-maxl maxl];
ax.Projection = "perspective";
ax.DataAspectRatio = [1 1 1];
hold on
hgt = hgtransform('Parent',ax);
hold(ax,'on')
S = createPrism0(x,y,z,rotvec(:,1),ax);
view(120, 10)
set(S,'Parent',hgt)
t1 = text(0.8,0.8,'X_B_o_d_y','Units','normalized','Color','r','FontSize',14);
t2 = text(0.8,0.75,'Y_B_o_d_y','Units','normalized','Color','g','FontSize',14);
t3 = text(0.8,0.7,'Z_B_o_d_y','Units','normalized','Color','b','FontSize',14);
ts = title(sprintf('Simulation Time %8.2f',t(1)),'FontSize',14);
xlabel('True X')
ylabel('True Y')
zlabel('True Z')
for i = 2:skiprate:length(t)
    pause(0.001)
    hgt = moveprism(hgt,rotvec(:,i));   
    ts.String = sprintf('Simulation Time %8.2f',t(i));
end
end

function R = q2Rmat(q)
q = q/norm(q);
q123 = q(1:3);
q1 = q(1);  q2 = q(2);  q3 = q(3);  q4 = q(4);
q4I = q4*eye(3);
qS = [ 0 -q3  q2 ;
       q3  0 -q1 ;
      -q2  q1  0];
Psi = [q4I-qS; -q123'];
Xi =  [q4I+qS; -q123'];
R = Xi'*Psi;
end

function S = createPrism0(x,y,z,rvec,ax)
angle = mod(vecnorm(rvec),2*pi);
if all(rvec==0)
    a = [0; 0; 0];
else
    a = rvec/norm(rvec);
end
q = [a*sin(angle/2);cos(angle/2)];

R = q2Rmat(q);
xyz = eye(3)*max([x y z]);
xyz = xyz*R;

c = [0.6 0.6 0.6];
xs = [0 0 0 0; x x x x;
      0 x x 0; 0 x x 0;
      0 x x 0; 0 x x 0];
ys = [0 0 y y; 0 0 y y;
      0 0 0 0; y y y y;
      0 0 y y; 0 0 y y];
zs = [0 z z 0; 0 z z 0;
      0 0 z z; 0 0 z z;
      0 0 0 0; z z z z];
xs = xs-x/2;
ys = ys-y/2;
zs = zs-z/2;

S(1) = fill3(ax,xs(1,:), ys(1,:), zs(1,:), c);
S(2) = fill3(ax,xs(2,:), ys(2,:), zs(2,:), c);
S(3) = fill3(ax,xs(3,:), ys(3,:), zs(3,:), c);
S(4) = fill3(ax,xs(4,:), ys(4,:), zs(4,:), c);
S(5) = fill3(ax,xs(5,:), ys(5,:), zs(5,:), c);
S(6) = fill3(ax,xs(6,:), ys(6,:), zs(6,:), c);
S(7) = plot3(ax,[0 xyz(1,1)],[0 xyz(2,1)],[0 xyz(3,1)],'r--','LineWidth',1.5);
S(8) = plot3(ax,[0 xyz(1,2)],[0 xyz(2,2)],[0 xyz(3,2)],'g--','LineWidth',1.5);
S(9) = plot3(ax,[0 xyz(1,3)],[0 xyz(2,3)],[0 xyz(3,3)],'b--','LineWidth',1.5);
end

function hgt = moveprism(hgt,rvec)
if all(rvec==0)
    R = makehgtform('axisrotate',[1 1 1],0);
    set(hgt,'Matrix',R)
    return
else
    c = cos(mod(rvec,2*pi)/2);
    s = sin(mod(rvec,2*pi)/2);
    angle = 2*acos(prod(c)+prod(s));
    ax1 = [s(1)*c(2)*c(3)-c(1)*s(2)*s(3);
           c(1)*s(2)*c(3)+s(1)*c(2)*s(3);
           c(1)*c(2)*s(3)-s(1)*s(2)*c(3)];
    ax1 = ax1/norm(ax1);  
    R = makehgtform('axisrotate',[ax1(1) ax1(2) ax1(3)],angle);
    set(hgt,'Matrix',R)
end
end