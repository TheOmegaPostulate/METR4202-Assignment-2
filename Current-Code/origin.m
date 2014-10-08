function [imagePoints, worldPoints, boardSize, X, Y, angle] = origin(size2)
%size is the dimention of one side of a checker board square in mm

if nargin == 0;
    size2 = 32;
end

vid1 = videoinput('mwkinectimaq', 1);
vid2 = videoinput('mwkinectimaq', 2);
preview(vid1)
pause();
colour = getsnapshot(vid1);
depth  = getsnapshot(vid2);

% data = rgb2gray(col);
% d = bitshift(depth, 3);
% map = depth2colormap(d');
% 
% %Generate mapped color image
% colour = uint8(zeros(size(data)));
% for i = 1:size(map, 1)
%     
%     for j = 1:size(map,2)
%         
%         x = map(i,j,2);
%         y = map(i,j,1);
% 
%         if (x > 0) && (y > 0) && (x < size(data, 1)) && (y < size(data, 2))
%             
%             colour(i, j) = data(x, y);
%             
%         end
%       
%     end
%     
% end
% 
% figure, imshow(colour);

try
    [imagePoints, boardSize] = detectCheckerboardPoints(colour);
        
	worldPoints = generateCheckerboardPoints(boardSize, size2);
end
        
stoppreview(vid1)
closepreview;
%NOTE : Needs finetuning once depth is calibrated properly
originX = round(imagePoints(boardSize(1)-1, 1));
originY = round(imagePoints(boardSize(1)-1, 2));
endX = round(imagePoints((boardSize(1)-1)*(boardSize(2)-1), 1));
endY = round(imagePoints((boardSize(1)-1)*(boardSize(2)-1), 2));
X = (double(depth(originY, originX))*abs(endX-originX))/520.2203;
Y = (double(depth(originY, originX))*abs(endY-originY))/797.09293;
angle = acosd(X/(4*size2));
end
