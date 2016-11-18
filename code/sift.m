function sift(video)
clc;
%-------------------------------------------------------------------
%frame segmentation
 %-------------------------------------------------------------------
%video = 'VIRAT_S_010111_05_000762_000799';
path = ['..\test_videos\', video, '.mp4'];

vid=VideoReader(path);
mkdir('..\img\', video);
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 25:25:n
     frames = read(vid,i);
     imwrite(frames,['..\img\', video, '\', video, '_', int2str(i), '.jpg']);
     %im(i)=image(frames);
 end
 %-------------------------------------------------------------------
%sift module
 %-------------------------------------------------------------------
run('VLFEATROOT\toolbox\vl_setup.m');
%x = 1;
nframes = i/25;
%video = 'VIRAT_S_010000_07_000827_000860';
img = zeros(nframes, 6400);

for i = 25:25:25*nframes
    disp(i/25);
    %display(x);
    
    im = imread(strcat('..\img\', video, '\', video, '_' , strcat(num2str(i), '.jpg')));
    im = rgb2gray(im);
    im = imresize(im, [256, 256]);
    [f1, descr] = vl_dsift(im2single(im));
    descr = im2single(descr);
    [C, Idx] = vl_kmeans(descr, 50);
    C = reshape(transpose(C), [1, 6400]);
    img(i/25,:) = C;
    %if i == 1
     %   img = C;
    %else
     %   img = vertcat(img, C);
    %end
 %   x = x + 1;
end
dlmwrite(['..\features\', video, '.txt'], img);