
clear all;
close all;
clc;

fy = 430;
fx = 520;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Access Kinect for image and depth
%Create video input devices
cvi = videoinput('mwkinectimaq', 1);
dvi = videoinput('mwkinectimaq', 2);

%Set manual triggering and frame count
triggerconfig([cvi dvi], 'manual');
set([cvi dvi], 'FramesPerTrigger', 1);

%Start input devices
start([cvi dvi]);

%Trigger input devices
trigger([cvi dvi]);

image = rgb2gray(getdata(cvi));
depth = getdata(dvi);
d = bitshift(depth, 3);

map = depth2colormap(d');

%Generate mapped color image
cMapped = uint8(zeros(size(image)));
for i = 1:size(map, 1)
    
    for j = 1:size(map,2)
        
        x = map(i,j,2);
        y = map(i,j,1);

        if (x > 0) && (y > 0) && (x < size(image, 1)) && (y < size(image, 2))
            
            cMapped(i, j) = image(x, y);
            
        end
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cup Detection
detector = vision.CascadeObjectDetector('xbwcups038.xml');

bbox = step(detector, cMapped);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Insert bounding boxes around cups

cMapped = insertObjectAnnotation(cMapped, 'rectangle', bbox, 'C'); % insert full cups boxes

box = bbox;

figure('Name', 'cMapped');
imshow(cMapped);

hold on

yLine = 1:0.01:480;
plot(320, yLine)

cups = zeros(size(box, 1), 3);


    for count = 1:size(box, 1)

        cups(count, 1) = box(count, 1) + round(0.5 * box(count, 3));
        cups(count, 2) = box(count, 2) + round(0.45 * box(count, 4));
        cups(count, 3) = depth(cups(count, 2), cups(count, 1));
        cups(count, 4) = cups(count, 3)/fy * ...
            (box(count, 2) + box(count, 4) - cups(count, 2));
        
        
        if cups(count, 4) == 0

            cups(count, 5) = 0;

        elseif cups(count, 4) > 0 && cups(count, 4) < 70

            cups(count, 5) = 1;

        elseif cups(count, 4) >= 70 && cups(count, 4) < 88

            cups(count, 5) = 2;

        elseif cups(count, 4) >= 88

            cups(count, 5) = 3;

        end
        
        plot(cups(count, 1), cups(count, 2), 'r*')

    end

    [imagePoints, boardSize] = detectCheckerboardPoints(cMapped);

    worldPoints = generateCheckerboardPoints(boardSize, 33);

    originX = round(imagePoints(boardSize(1)-1, 1));
    originY = round(imagePoints(boardSize(1)-1, 2));
    
    endX = round(imagePoints((boardSize(1)-1)*(boardSize(2)-1), 1));
    X = (double(depth(originY, originX))*abs(endX-originX))/fy;

    angle = acosd(X/(4*33));
    
    originDepth = depth(originY, originX);

    plot(originX, originY, 'g*')

    hold off

    for count = 1:size(cups, 1)

        cups(count, 6) = abs(originX - cups(count, 1)) / fx * cups(count, 3);

        cups(count, 7) = originDepth - cups(count, 3);
        
        if cups(count, 5) == 1
            
            cups(count, 7) = cups(count, 7) + 30;
            
        elseif cups(count, 5) == 2
            
            cups(count, 7) = cups(count, 7) + 39;
            
        elseif cups(count, 5) == 2
            
            cups(count, 7) = cups(count, 7) + 44;
        
        end
        
        cups(count, 8) = cups(count, 3);

    end
        
        
        
        
