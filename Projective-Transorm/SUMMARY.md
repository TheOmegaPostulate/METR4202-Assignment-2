Projective Transform Code Information
=====================

This is a small file to provide information on the projective transform code included in the repository.

The main file included is Lab2_V1.m, which runs all necessary setup and calibration for the projective transform, and then calls the functions that transorm the input image and identify circles within it.

To run this code on a specific image, input the name of the Image into the code.

For the code to complete the projective transform control points will need to be set.  To do this simply click the same points in the image and the generic checkerboard, and then export the control points.  Once this is done press enter in the workspace window.

You also will need to set a scale if you wish to find circles of a given diameter.  To do this use the tool and image that pop up.  Once you have found the diamater of the circle you are measured in pixels, type this number into the workspace and press enter.

Help
-----------
Q. MATLAB can't find my image, what's gone wrong?
A. Chances are you have either made a mistake entering the image name, or have forgotten to add it to the MATLAB path.

Q. How do I add my image to the MATLAB path?
A. MathWorks has a lot of usful tutorials you can look at, including one on adding things to the path.  See: http://www.mathworks.com.au/help/matlab/ref/addpath.html.

Q. I add the control points to my image, but can't get the corresponding ones on the checkerboard, what's up with that?
A. You need to add sets of control points one by one (i.e. not all in one image, then all in the other).
