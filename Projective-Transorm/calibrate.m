function [scale, tform] = calibrate(filename)
    %Calibrates the camera.
    %   Calls the various functions that calibrate the kinect.
    
    clc
    
    I = imread(filename);    % Read in the calibration image.
    scale = 1; %find_scale(I);    % Find the scale.
    tform = projective_transform_calibration(I, scale, 0, 0, 1); % Find Control Points.
    input('Ready?');
    tform = projective_transform_calibration(I, scale, evalin('base', 'in'), evalin('base', 'base'), 0); % Find the transform.
end

