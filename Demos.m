function Demos(num)

% Demo 1 is a tame rotation about the axis of minimum inertia. The
% projection on the conserved constructs are small, and there are only
% wobbles in the angular velocity. This is formally axisymmetric rotation
% with an oblate rigid body.

% Demo 2  uses the case of  axisymmetric rotation about a prolate 
% rigid body. The angular velocity will instead be about the axis of
% minimum inertia. It is visibly more susceptible to off-axis perturbations

% Demo 3 is the classic "Tennis Racket" example of flipping about the
% intermediate axis

% Demo 4 is a spinning top
close all


if num == 1
    tmax = 9000;
    NSamples = 3E4;
    J = diag([1 10 1]);
    attitude_0 = [0; 0; 0];
    omega_0 = [0.001; -0.01; 0.001];
    [t,omega,rotvec] = MomentumODE(J, attitude_0, omega_0, NSamples, tmax);
    PlotsIn2D(t, omega, J)
    input('Press Enter to Continue to 3D plots')
    PlotsIn3D(omega, J)
    input('Press Enter to Continue to 3D Animation')
    Animate3D(t,rotvec,J,5)
elseif num == 2
    tmax = 9000;
    NSamples = 3E4;
    J = diag([10 1 10]);
    attitude_0 = [0; 0; 0];
    omega_0 = [0.001; -0.01; 0.001];
    [t,omega,rotvec] = MomentumODE(J, attitude_0, omega_0, NSamples, tmax);
    PlotsIn2D(t, omega, J)
    input('Press Enter to Continue to 3D plots')
    PlotsIn3D(omega, J)
    input('Press Enter to Continue to 3D Animation')
    Animate3D(t,rotvec,J,5)
elseif num == 3
    tmax = 10000;
    NSamples = 3E4;
    J = diag([10 1 20]);
    attitude_0 = [0; 0; 0];
    omega_0 = [0.01; 0.00001;  0];
    [t,omega,rotvec] = MomentumODE(J, attitude_0, omega_0, NSamples, tmax);
    PlotsIn2D(t, omega, J)
    input('Press Enter to Continue to 3D plots')
    PlotsIn3D(omega, J)
    input('Press Enter to Continue to 3D Animation')
    Animate3D(t,rotvec,J,5)
elseif num == 4
    tmax = 9000;
    NSamples = 5E3;
    J = diag([100 100 1]);
    attitude_0 = [0; 0; 0];
    omega_0 = [ 0.00001; 0.00001;   0.02];
    
    [t,omega,rotvec] = MomentumODE(J, attitude_0, omega_0, NSamples, tmax);
    PlotsIn2D(t, omega, J)
    input('Press Enter to Continue to 3D plots')
    PlotsIn3D(omega, J)
    input('Press Enter to Continue to 3D Animation')
    Animate3D(t,rotvec,J,1)
end
end