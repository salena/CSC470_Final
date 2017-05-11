%% YUV to AVI conversion
% This file converts YUV files to AVI files. YUV-->MOV-->AVI

% Dependancies yuv2mov.m, 
%  
%========================================================================
%
% Author  : Ganesh K Davanagere
% Version : 1.0
% Modified: Ganesh K
% Version: 1.
% 
% The author is working as assistant professor at department of electronics and 
% communication at Bapuji Institute of Engineering and Technology,
% Davanagere, Karnataka, India
% The author is research scholar working on video quality assessment 
% 
% Kindly report any suggestions or corrections to 2ganesh@gmail.com
%
%========================================================================
%
%This is an implementation of YUV to Uncompressed AVI conversion

%Input : YUV video 
%Output: UNCOMPRESSED AVI video
%
% Steps
%
%1. Load the YUV video
%
%2. Extract the frames of YUV and convert each to MOV using YUV2MOV
%function
%
%3. Convert MOV to Uncompressed AVI by accessing each frame of MOV
%
%========================================================================

function newFile = convert(fileName)

tic
%% Convert YUV file to MATLAB Movie file using yuv2mov
% Specify the full path of input file for YUV to AVI conversion
ipFile = fileName;
[folder, baseFileName1, extentions] = fileparts(ipFile);
%disp('Welcome to YUV to MOV Conversion');

% QCIF 176x144, CIF Format (352x288) 
mov = yuv2mov(ipFile,832,480,'420');
[m,noOfFrames] = size(mov);

%% To display the converted MOV file, uncomment this block to display the video

% %% Display the frames of MOV video
% 
% for k = 1:noOfFrames 
%     imshow(mov(k).cdata);
% %     img = readFrame(mov);
%     sprintf('Reading %d th frame',k)
% end
%% Convert MOV to AVI using movie2avi

%disp('MOV to AVI Conversion ')

% Write a sequence of frames to a Uncompressed AVI file

% Prepare the new file.
% Keep output file same as input 

AVIFilename = baseFileName1;

writerObj = VideoWriter(sprintf('%s.avi', AVIFilename),'Uncompressed AVI');
% writerObj = VideoWriter('tr125fps.avi','Uncompressed AVI');
newFile = [AVIFilename  '.avi'];
open(writerObj);

[temp,noOfFrames] = size(mov)

% Create a set of frames and write each frame to the file.

for k = 1:noOfFrames 
    [frame,map] = frame2im(mov(k));
    writeVideo(writerObj,frame);
end

close(writerObj);
%% If you do not want to play the AVI file, comment this block

% %% Play the AVI File using vision.VideoFileReader
% figure
% disp('Playing the AVI video')
% videoFReader = vision.VideoFileReader(sprintf('%s.avi', AVIFilename));
% % videoFReader = vision.VideoFileReader('test.avi');
% 
% videoPlayer = vision.VideoPlayer;
% while ~isDone(videoFReader)
%   videoFrame = step(videoFReader);
%   step(videoPlayer, videoFrame);
% end
% release(videoPlayer);
% release(videoFReader);

toc