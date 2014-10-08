vid1 = videoinput('mwkinectimaq', 1);
preview(vid1)

'RUNNING IN 1.5 SECONDS'
pause(1.5);

for count = 1:10
   data = getsnapshot(vid1);
   h = image(data);
   
   if count < 10
       
       filename = strcat('calibration_00', int2str(count), '.jpg');
       
   elseif count >=10 && count < 100
       
       filename = strcat('calibration_0', int2str(count), '.jpg');
       
   else
       
       filename = strcat('calibration_', int2str(count), '.jpg');
       
   end
   
   saveas(h, filename)
   pause(0.25);
    
end

close all;
clear;
clc;
