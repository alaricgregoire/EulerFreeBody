function [t,omega,rotvec] = MomentumODE(J, attitude_0, omega_0, NSamples, tmax)
% MomentumODE - Determine behavior of a rotating object in a torque-free
% environment using Euler's rotation equations
%
% Syntax: MomentumODE(J, attitude_0, omega_0, NSamples, tmax)
%
% Inputs:
%    J         - 3x3 Inertia Tensor
%    attitude0 - Rotation vector for the initial attitude
%    omega0    - inital angular velocity in rad/s
%    NSamples  - Number of time data points in output vector
%    tmax      - Length of the simulation in seconds
%
% Outputs:
%    t         - time vector
%    omega     - angular velocity at times in t
%    rotvec    - rotation vector representing attitude at times in t
%
% Other m-files required: N/A
% Subfunctions: ODE(t,State,JP)
% MAT-files required: N/A
%
% See also: Animate3D,  PlotsIn3D
% Author: Alaric Gregoire
% agregoire3@gatech.edu
% Last revision: 27-Apr-2020

% For smooth animations with no data skipping, the currently applied plot
% objects can be adjusted at 200 fps including the 0.001 pause.
%
% As an estimate, NSamples should be 200 times the length of the goal 
% animation when the skiprate variable is set to 1. Using skiprate higher
% than 1 will have a "fast forward" effect


State = [attitude_0;omega_0];
% Conserved quantities
options = odeset('RelTol',1e-13,'AbsTol',1e-13);
% Principal Inertia values
JP = 1./linsolve(J,ones(3,1));
[t,States] = ode113(@(t,State) ODE(t,State,JP),linspace(0,tmax,NSamples),State,options);
rotvec = States(:,1:3)';
omega = States(:,4:6)';
end

function dState = ODE(t,State,JP)
dState = zeros(size(State));
omega = State(4:6);
dState(1:3) = omega;
J1 = JP(1);        J2 = JP(2);        J3 = JP(3);
w1 = omega(1);     w2 = omega(2);     w3 = omega(3);
dState(4) = ((J2-J3)/J1)*w2*w3;
dState(5) = ((J3-J1)/J2)*w3*w1;
dState(6) = ((J1-J2)/J3)*w1*w2;
end