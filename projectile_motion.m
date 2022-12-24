% projectile_motion.m
%
%   Purpose:
%       This program tests the projectile function.
%
%   Record of Revisions:
%       Date        Programmer      Description of changes
%       ====        ==========      ======================
%       2022/07/06  N. J. Blair     Original code
%

% These are test inputs for the function
launch_speed = 100.0; % launch speed in m/s
launch_angle = 30; % launch angle in degrees
launch_height = 0.1; % launch height in meters
diameter = 0.025; % diameter of sphere in meters
m = 10.0; % mass in kilograms

% Call the projectile function with the above parameters
[range, max_height, flight_time] = projectile(launch_speed,...
    launch_angle, launch_height, diameter, m);

% Print the range, maximum height, and flight time
range
max_height
flight_time