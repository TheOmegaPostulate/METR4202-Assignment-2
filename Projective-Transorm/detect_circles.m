function [centres, radii] = detect_circles(I_tform, min_rad, max_rad, n)
    % Takes in an image and a transformation and detects circles with
    % radii in the given range.
    %   Transforms the input image with the given transformation and then
    %   performs circle detection techniques.  Plots the circles on the
    %   input image.
    
    clc
    
    [centres, radii] = imfindcircles(I_tform,[min_rad max_rad], 'ObjectPolarity','bright', 'Sensitivity', 0.7, 'Method','twostage');
    
%     houghcircles(I_tform, min_rad, max_rad);
%     figure(n);
%     imshow(I_tform);
%     h = viscircles(centres,radii);
    
end

