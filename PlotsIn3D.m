function PlotsIn3D(omega, J)
% PlotsIn3D - Project the angular velocity and momentum onto their
% respective conserved constructs. Omega on energy conservation and
% momentum on momentum conservation
%
% Syntax: PlotsIn3D(omega,J)
%
% Inputs:
%    omega  - angular velocity (rad/s)
%    J      - Inertia Tensor
%
% Outputs:
%    Figure 2 and 3
%
% Other m-files required: N/A
% Subfunctions: N/A
% MAT-files required: N/A
%
% See also: MomentumODE,  PlotsIn2D
% Author: Alaric Gregoire
% agregoire3@gatech.edu
% Last revision: 27-Apr-2020

f = figure(2);
if f.Children~=0
    clf
end
f.Units = 'normalized';
f.Position = [0.0972 0.42667 0.3889 0.46667];
H = J*omega;
Ek = 0.5*omega(:,1)'*J*omega(:,1);

% Principal Moments of Inertia
JP = ordeig(J);
J1 = JP(1); J2 = JP(2); J3 = JP(3);

% Energy Ellipsoid
% Semimajor axes
XR = sqrt((2*Ek)/J1);
YR = sqrt((2*Ek)/J2);
ZR = sqrt((2*Ek)/J3);

[X,Y,Z] = ellipsoid(0,0,0,XR,YR,ZR,100);
EnergyEllipsoid = surf(X,Y,Z);
EnergyEllipsoid.FaceColor = 'g';
EnergyEllipsoid.FaceAlpha = 0.4;
EnergyEllipsoid.LineStyle = 'none';
hold on
% Plot Origin and Axes
scatter3(0,0,0,40,'ko','filled')
plot3([-XR XR],[0 0],[0 0],'k--','LineWidth',1.5)
plot3([0 0],[-YR YR],[0 0],'k--','LineWidth',1.5)
plot3([0 0],[0 0],[-ZR ZR],'k--','LineWidth',1.5)
% Simply plot angular velocity values, and they should lie on the ellipsoid
% when energy is conserved
plot3(omega(1,:),omega(2,:),omega(3,:),'r-','LineWidth',2.5)
title('Path of Angular Velocity Vector on Poisson Construct','FontSize',12)
xlabel('X-(N-m)','FontSize',12)
ylabel('Y-(N-m)','FontSize',12)
zlabel('Z-(N-m)','FontSize',12)
R = max([XR YR ZR]);
axis([-R R -R R -R R])
a = gca;
a.Projection = "perspective";

f = figure(3);
if f.Children~=0
    clf
end
f.Units = 'normalized';
f.Position = [0.4868 0.42666 0.3889 0.46667];
% Momentum Sphere
[x,y,z] = sphere(100);
Hn1 = vecnorm(H(:,1));
% Normalize sphere default points to momentum size
x = x*Hn1;  y = y*Hn1;  z = z*Hn1;
MomentumSphere = surf(x,y,z);
MomentumSphere.LineStyle = 'none';
MomentumSphere.FaceAlpha = 0.4;
MomentumSphere.FaceColor = 'g';
hold on
% Plot Origin and Axes
scatter3(0,0,0,40,'ko','filled')
plot3([-Hn1 Hn1]*1.3,[0 0],[0 0],'k--','LineWidth',1.5)
plot3([0 0],[-Hn1 Hn1]*1.3,[0 0],'k--','LineWidth',1.5)
plot3([0 0],[0 0],[-Hn1 Hn1]*1.3,'k--','LineWidth',1.5)
% Projection of angular momentum onto sphere

plot3(H(1,:),H(2,:),H(3,:),'r-','LineWidth',2.5)
title('Path of Angular Momentum Vector on Inertial Sphere','FontSize',12)
xlabel('X-(N-m-s)','FontSize',12)
ylabel('Y-(N-m-s)','FontSize',12)
zlabel('Z-(N-m-s)','FontSize',12)
axis equal
a = gca;
a.Projection = "perspective";


end