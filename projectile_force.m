% projectile_force.m
function [force_x, force_y] = projectile_force(lin_drag_coef,...
    quad_drag_coef,velocity_horizontal, velocity_vertical, mass)
%
%   Purpose:
%       This function will take in the linear and quadratic drag 
%       coefficients, along with the velocity and mass of the particle and
%       returns the force vector.
%
%   Record of Revisions:
%       Date        Programmer      Description of changes
%       ====        ==========      ======================
%       2022/07/06  N. J. Blair     Original code
%

% Data Dictionary
% Inputs
% REAL :: lin_drag_coef % coefficient of linear drag Ns/m
% REAL :: quad_drag_coef % coefficient of quadratic drag N(s/m)^2
% REAL :: velocity_horizontal % current horizontal velocity in m/s
% REAL :: velocity_vertical % current vertical velocity in m/s
% REAL :: mass % mass of projectile in kg

% Parameters for calculation
velocity_coef = lin_drag_coef + ...
    quad_drag_coef * sqrt(velocity_horizontal^2 + velocity_vertical^2); 
% coefficient in front of velocity vector for force in Ns/m
grav = 9.8; % gravitational acceleration in m/s^2

% Output variables

force_x = - velocity_coef * velocity_horizontal; % horizontal force in N
force_y = - (velocity_coef * velocity_vertical) - (mass * grav); 
    % vertical force in N

end