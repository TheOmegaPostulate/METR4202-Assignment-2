%% Updated code for starting the Kinect and saving an image.
clear all;
close all;
clc;

%% Initial Setup
vid1 = videoinput('mwkinectimaq', 1, 'RGB_640x480');

vid2 = videoinput('mwkinectimaq', 2, 'Depth_640x480');
vid2.framesPerTrigger = 1;

start(vid1); start(vid2);

%% Get Image
data = getsnapshot(vid1);
[depth, b, c] = getdata(vid2);

data = flip(data, 2);
depth = flip(depth, 2);

stop(vid1); stop(vid2);

vid1 = videoinput('mwkinectimaq', 1, 'RGB_1280x960');
start(vid1);

detector = vision.CascadeObjectDetector('xbwcups038.xml');

img = flip(getsnapshot(vid1), 2); % Flip the image
gsImg = rgb2gray(img); % Make a grayscale image
bbox = step(detector, gsImg);
bbox = round(bbox .* 0.5);

stop(vid1);

vid1 = videoinput('mwkinectimaq', 1, 'RGB_640x480');
start(vid1);

img2 = flip(getsnapshot(vid1), 2);

stop(vid1);

finalImg = insertObjectAnnotation(img2, 'rectangle', bbox, 'CUP');

%% Display the Image
R = figure;
imshow(finalImg);
hold on

coords = zeros(size(bbox, 1), 2);

for count = 1:size(bbox, 1)
    
    coords(count, 1) = bbox(count, 1) + round(0.5 * bbox(count, 3));
    coords(count, 2) = bbox(count, 2) + round(0.5 * bbox(count, 4)) - 5;
    plot(coords(count, 1), coords(count, 2), 'r*')
   
end

hold off

cups = getDepthGHF(coords, depth);

B = figure;

% blend = image(imfuse(depth, data, 'blend'));
blend = imfuse(depth, data, 'blend');
imshow(blend);
hold on
for count = 1:size(cups, 1)

    plot(coords(count, 1), coords(count, 2), 'g*')
    plot(cups(count, 1), cups(count, 2), 'r*')

end
