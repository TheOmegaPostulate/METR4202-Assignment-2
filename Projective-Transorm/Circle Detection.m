%% Circle Detection
clc

%% Constants
min_radius = 15;
max_radius = 20;

%% Input Image Manipulation
I = imread('chess_circles.jpg');    % Read in the calibration image.

figure;                             % Create new figure.
imshow(I);                          % Display the image, debug only.

I_scaled = imresize(I, scale);      % Scale image.
I_gray = rgb2gray(I_scaled);        % Convert to grayscale.

