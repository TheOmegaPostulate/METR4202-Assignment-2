function [ map ] = depth2colormap( dImage )
%DEPTH2COLORMAP Creates a (u, v) pixel mapping from depth to color
%   
%   depth2colormap is a utility function that uses a provided kinect depth
%   image 'dImage' to calculate the pixel mapping between the depth image
%   and the corresponding color image. This function returns a matrix 
%   [n m 2], were the pixel at dImage(i, j) can be mapped to some color
%   image 'cImage' pixel using cImage(map(i, j, 1), map(i, j, 2)).
%
%
%   dImage: a [480 640] depth image of format uint16 directly taken from
%           the Kinect IMAQ Adapter, transposed and bitshifted 3 places 
%            i.e.
%               dImage = bitshift(dImage', 3)
%           This is to correct for the format that the adapter pulls the
%           data from the device in.
%
%   map:    a [480 640] (u, v) matrix providing coordinate mapping between
%           depth and color images.
%
%
%   Example:
%     %Create video input devices
%     cvi = videoinput('mwkinectimaq', 1);
%     dvi = videoinput('mwkinectimaq', 2);
% 
%     %Set manual triggering and frame count
%     triggerconfig([cvi dvi], 'manual');
%     set([cvi dvi], 'FramesPerTrigger', 1);
% 
%     %Start input devices
%     start([cvi dvi]);
% 
%     %Trigger input devices
%     trigger([cvi dvi]);
% 
%     %Get data from devices
%     c = rgb2gray(getdata(cvi));
%     d = bitshift(getdata(dvi), 3);
%
%     %Stop input devices
%     stop([cvi dvi]);
%
%     %Calculate map
%     map = depth2colormap(d');
% 
%     %Generate mapped color image
%     cMapped = uint8(zeros(size(c)));
%     for i = 1:size(map, 1)
%         for j = 1:size(map,2)
%             x = map(i,j,2);
%             y = map(i,j,1);
% 
%             if (x > 0) && (y > 0) && ...
%                 (x < size(c, 1)) && (y < size(c, 2))
%                 cMapped(i, j) = c(x, y);
%             end
%         end
%     end
% 
%     imshow(cMapped);
end

