MSSIM=zeros(11,1);
PSNR=zeros(11,1);

for i = 1:11
   [A B] = evaluate('BQMall', i)
   MSSIM(i)= A;
   PSNR(i)= B;
end

BQMallResults = cat(2, MSSIM, PSNR);

MSSIM=zeros(18,1);
PSNR=zeros(18,1);

for i = 1:18
   [A B] = evaluate('BasketballDrive', i)
   MSSIM(i)= A;
   PSNR(i)= B;
end

BasketballDriveResults = cat(2, MSSIM, PSNR);