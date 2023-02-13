% projectile.m
function [range, max_height, flight_time] = projectile(launch_velocity,...
    launch_angle, launch_height, projectile_length, projectile_mass)
%
%   Purpose:
%       This function will take in the launch velocity, initial height,
%       projectile size, and projectile mass. And will output the range, 
%       maximum height, and flight time.
%       This method currently uses the euler method to solve the equations
%       of motion. This may be modified in a future version.
%
%   Record of Revisions:
%       Date        Programmer      Description of changes
%       ====        ==========      ======================
%       2022/07/06  N. J. Blair     Original code
%

% Data Dictionary
% Inputs
% REAL :: launch_velocity % Initial velocity in meters per second
% REAL :: launch_angle % Launch angle in degrees (must be between 0 and 90)
% REAL :: launch_height % Initial height that object was launched in meters
% REAL :: projectile_lenght % linear dimension of projectile

% Outputs
range = 0. ; % Double, range of projectile in meters
max_height = launch_height ; % Double, max height of projectile in meters
flight_time = 0. ; % Double, time that object is in air in meters 

% Parameters and intermediate variables
vel_x = launch_velocity * cosd(launch_angle); 
    % Horizontal component of initial velocity m/s
vel_y = launch_velocity * sind(launch_angle); 
    % Vertical component of initial velocity m/s

beta = 1.6E-4 ; % Beta coefficient (for linear drag) at STP in N*s/m^-2
gamma = 0.25; % Gamma coefficient (for quadratic drag) at STP in N*s^2/m^-2

lin_coeff = beta * projectile_length; % coefficient of linear drag in N*s/m
quad_coeff = gamma * (projectile_length ^ 2); 
    % coefficient of quadratic drag in N(s/m)^2

% Variables used in solving equations of motion
current_height = launch_height; 
time_step = 1.E-1; % time step for numerical integration

% Numerical integration

% Continue integration until particle hits the ground
    % Assumes spherical object
while current_height > 0.0
    
    % Update the range, current height, and flight time
    current_height = current_height + (vel_y * time_step);
    range = range + (vel_x * time_step);
    flight_time = flight_time + time_step;
    
    % Check if the current height is greater than the maximum height.
    % If so, set the max height to the current height.
    if current_height > max_height
        max_height = current_height;
    end
    
    % Calculate the forces
    [force_horizontal, force_vertical] = projectile_force(lin_coeff,...
    quad_coeff, vel_x, vel_y, projectile_mass);

    % Use the forces to calculate the new velocity
    vel_x = vel_x + (force_horizontal / projectile_mass);
    vel_y = vel_y + (force_vertical / projectile_mass);
    
end
% End once the projectile hits ground

end