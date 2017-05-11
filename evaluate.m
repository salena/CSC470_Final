function [avgMSSIM, avgPSNR] = evaluate(filePrefix, i)

filename1 = [filePrefix '_832x480_dst_' num2str(i) '.yuv']

filename2 = convert(filename1)

hVideoSrc = vision.VideoFileReader(filename2, 'ImageColorSpace', 'Intensity');

img1 = step(hVideoSrc); % Read first frame into imgA

totalMSSIM = 0;

totalPSNR = 0;
frameCount = 0;

while ~isDone(hVideoSrc)

img2 = step(hVideoSrc); % Read 5th frame into img2
img2 = step(hVideoSrc); 
img2 = step(hVideoSrc); 
img2 = step(hVideoSrc); 

[mssim, ssim_map] = ssim(img1, img2);

%mssim                        %Gives the mssim value
%imshow(max(0, ssim_map).^4)  %Shows the SSIM index map

totalMSSIM = totalMSSIM + mssim;

thisPSNR = psnr(img2, img1);
if thisPSNR ~= Inf 
    totalPSNR = totalPSNR + thisPSNR;
    frameCount = frameCount+1;
end

img1 = img2;

end

avgMSSIM = totalMSSIM/(frameCount-1);
avgMSSIM

avgPSNR = totalPSNR/(frameCount-1);
avgPSNR

delete(filename2)
