function [mse, psnr] = mse_psnr(img1, img2, L)

% mse_psnr(img1, img2, L)
% img1 is the reference frame, img2 is the encoded frame
% L is the bit color depth of each channel (usually L = 8 bit)
% it works with RGB frames acquired through imread() or mmreader()

pixel_max = (2^L)-1; % setting the maximum value that a pixel can assume

% comment the following two lines if the frames are already in YCbCr
img1 = rgb2ycbcr(img1); % converting from RGB to YCbCr
img2 = rgb2ycbcr(img2); % converting from RGB to YCbCr

img1 = img1(:,:,1); % extracting the luminance component (Y)
img2 = img2(:,:,1); % extracting the luminance component (Y)

img1 = img1(:); % converts a matrix into a monodimensional array
img2 = img2(:); % converts a matrix into a monodimensional array

x=0;

img1=double(img1);
img2=double(img2);

x=(img1-img2).^2;

mse=mean(x); % here is the MSE
psnr=10*log10(((pixel_max)^2)/(mse)); % and here is the PSNR

return
