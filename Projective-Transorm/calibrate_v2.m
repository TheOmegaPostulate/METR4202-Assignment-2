function [scale, tform] = calibrate2(filename)
    %Calibrates the camera.
    %   Calls the various functions that calibrate the kinect.
    
    clc
    
    I = imread(filename);    % Read in the calibration image.
    scale = 1; %find_scale(I);    % Find the scale.
    
    %% Create Transform
    if first_time
        cpselect(I_gray, checkerboard);
    end
    
    function [tform] = projective_transform_calibration(I, scale, in, base)
    % Takes in an image and scales it, then creates a transform.
    %   Creates a projective transform that will change an image to a 
    %   "birds-eye view".  Requires input from the user to set control
    %   points.  Returns the transform.

    %% Constants
    first_time = 1;

    %% Calibration Image Manipulation
    figure;                             % Create new figure.
    imshow(I);                          % Display the image, debug only.

    I_scaled = imresize(I, scale);      % Scale image.
    I_gray = rgb2gray(I_scaled);        % Convert to grayscale.

    tform = cp2tform(in, base, 'projective');
end
    tform = projective_transform_calibration(I, scale); % Find the transform.
    
end

