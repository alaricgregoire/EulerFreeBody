function PlotsIn2D(t, omega, J)
% PlotsIn2D - Plot of each angular velocity and momentum component
%
% Syntax: PlotsIn2D(t, omega, J)
%
% Inputs:
%    t     - Nx1 or 1xN vector of time sample points
%    omega - 3xN array of angular velocities as [x;y;z]
%    J     - 3x3 Inertia Tensor
%
% Outputs:
%    Figure 1
%
% Other m-files required: N/A
% Subfunctions: repetitiveplotting(title,xlabel,ylabel)
% MAT-files required: N/A
%
% See also: MomentumODE,  PlotsIn3D
% Author: Alaric Gregoire
% agregoire3@gatech.edu
% Last revision: 27-Apr-2020

[r,c] = size(omega);
[r2,c2] = size(J);
if r2~=c2||r2~=3
    disp('Inertia tensor should be a 3 by 3 array')
    return
end
if ~any([r==3 c==3])
    disp('Dimensions of angular velocity are incompatible')
    return
end
if length(t)~=max([r,c])
    disp('Time vector does not match length of angular velocity')
    return
end

% Momentum is calculated as the product of inertia and angular velocity
momentum = J*omega;

f1 = figure(1);
f1.Units = 'normalized';
f1.Position = [0.0972 0.42667 0.7778 0.46667];
subplot(2,3,1)
plot(t,omega(1,:),'r-','LineWidth',1.5)
repetitiveplotting('\omega_x','Time (s)','Rad/s')

subplot(2,3,2)
plot(t,omega(2,:),'g-','LineWidth',1.5)
repetitiveplotting('\omega_y','Time (s)','Rad/s')

subplot(2,3,3)
plot(t,omega(3,:),'b-','LineWidth',1.5)
repetitiveplotting('\omega_z','Time (s)','Rad/s')

subplot(2,3,4)
plot(t,momentum(1,:),'r-','LineWidth',1.5)
repetitiveplotting('H_x','Time (s)','N-m-s')

subplot(2,3,5)
plot(t,momentum(2,:),'g-','LineWidth',1.5)
repetitiveplotting('H_y','Time (s)','N-m-s')

subplot(2,3,6)
plot(t,momentum(3,:),'b-','LineWidth',1.5)
repetitiveplotting('H_z','Time (s)','N-m-s')
end

function repetitiveplotting(titlename,xl,yl)
title(titlename,'FontSize',14)
xlabel(xl,'FontSize',12)
ylabel(yl,'FontSize',12)
end