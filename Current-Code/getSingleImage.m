% Code used to take a single image using the kinect.
vid1 = videoinput('mwkinectimaq', 1);
preview(vid1)

pause();

data = getsnapshot(vid1);
h = image(data);

filename = strcat('image.jpg');

saveas(h, filename)
  
