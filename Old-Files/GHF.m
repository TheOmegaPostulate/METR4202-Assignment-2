%% Basic code for starting the Kinect and saving an image.
clear;
clc;

%% Initial Setup
vid1 = videoinput('mwkinectimaq', 1);
vid2 = videoinput('mwkinectimaq', 2);
vid2.framesPerTrigger = 1;

start(vid2);
start(vid1);

%% Get Image
data = getsnapshot(vid1);
[depth, b, c] = getdata(vid2);
stop(vid2);
stop(vid1);
h = image(data);

%% Save Image
filename = strcat('image.jpg');
       
saveas(h, filename)
