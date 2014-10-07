function [ ] = find_cups(I, tform, scale, conversion)
    % Takes an image, a transform and a scale and plots stuff.
    %   Checks the image for the three different types of cups.
    
    clc
    
    %% Constants
    sml_cup_r = 615/2;
    med_cup_r = 800/2;
    lrg_cup_r = 907/2;    

    %% Image manipulation
    I_scaled = imresize(I, scale);      % Scale image.
    I_gray = rgb2gray(I_scaled);        % Convert to grayscale.

    I_tform = imtransform(I_gray, tform);%, 'XYScale', 0.2);  % Transform image.
    
    figure(1);
    I_edge = edge(I_tform, 'canny');
    imshow(I_edge);
 
%%     Look for circles
% Upside-down cups!

% ALL - DEBUG ONLY
     [centres, radii] = detect_circles(I_edge, 10, 100, 1); %Last arg is figure lable, remove
     h = viscircles(centres, radii);
    
% % Little Circles
%     [centres, radii] = detect_circles(I_edge, round((sml_cup_r-120)/conversion), round((sml_cup_r+46.25)/conversion), 1); %Last arg is figure lable, remove
%     h = viscircles(centres, radii);
%     centres = centres*conversion
%     radii = radii*conversion
% 
% % Medium Circles
%     [centres, radii] = detect_circles(I_edge, round((med_cup_r-46.25)/conversion-1), round((med_cup_r+26.75)/conversion+1), 2);      
%     i = viscircles(centres, radii, 'EdgeColor', 'b');
%     
% % Large Circles
%     [centres, radii] = detect_circles(I_edge, round((lrg_cup_r-26.75)/conversion), round((lrg_cup_r)/conversion), 3);
%     j = viscircles(centres, radii, 'EdgeColor', 'g');

%% Alternate Edge Detections

% %     figure(2);
% %     Ie1 = edge(I_tform,'prewitt');
% %     imshow(Ie1);
% % 
% %     figure(3);
% %     Ie2 = edge(I_tform, 'sobel');
% %     imshow(Ie2);
% %
% %     figure(5);
% %     Ie4 = edge(I_tform, 'roberts');
% %     imshow(Ie4);
%     
%     figure(6);
%     Ie5 = edge(I_tform, 'log');
%     imshow(Ie5);
%     
% 
%     figure(7);
%     Ie6 = edge(I_tform, 'zerocross');  
%     imshow(Ie6);
    
end
