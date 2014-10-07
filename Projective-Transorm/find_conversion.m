function [ conversion ] = find_conversion(I, diam_act)
    % Finds the conversion factor for the input image.
    %   Probably not the best way.
    figure;
    imshow(I);
    d = imdistline;   
    diam_im = input('Enter cup radii: ');
    conversion = diam_act/diam_im;
end
