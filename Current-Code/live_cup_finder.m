detector = vision.CascadeObjectDetector('xbwcups038.xml');
leftDetector = vision.CascadeObjectDetector('leftblockcup038.xml');
rightDetector = vision.CascadeObjectDetector('rightblockcup038.xml');

vid1 = videoinput('mwkinectimaq', 1, 'RGB_1280x960');
preview(vid1)

pause();
img = getsnapshot(vid1);

gsImg = rgb2gray(img); % Make a grayscale image
bbox = step(detector, gsImg);
bboxL = step(leftDetector, gsImg);
bboxR = step(rightDetector, gsImg);

fullImg = insertObjectAnnotation(img, 'rectangle', bbox, 'CUP'); % insert full cups boxes
leftImg = insertObjectAnnotation(fullImg, 'rectangle', bboxL, 'left'); % insert blocked left boxes
rightImg = insertObjectAnnotation(leftImg, 'rectangle', bboxR, 'right'); % insert blocked right boxes

imshow(rightImg);
