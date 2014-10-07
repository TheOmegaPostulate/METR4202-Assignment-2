%% Projective Transform Calibration
clc

%% Constants
scale = 0.5;
first_time = 1;

%% Calibration Image Manipulation
I = imread('3.jpg');    % Read in the calibration image.

% figure;                             % Create new figure.
% imshow(I);                          % Display the image, debug only.

I_scaled = imresize(I, scale);      % Scale image.
I_gray = rgb2gray(I_scaled);        % Convert to grayscale.

% K = fspecial('gaussian');           % Gaussian kernal for blurring.
% I_blur = imfilter(I_gray, K);       % Blur image.  Note: multiple passes
% I_blur = imfilter(I_blur, K);       % with fixed kernalequivilent to 
% I_blur = imfilter(I_blur, K);       % single pass with a larger kernel.


%% Create Transform
if first_time
    cpselect(I_gray, checkerboard);
    input('Ready?');
end

tform = cp2tform(input_points, base_points, 'projective');

%% Find cups
find_cups(I, tform, 0.5);
