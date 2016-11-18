clc;

%Compute Frame segmentation

%video = 'VIRAT_S_010001_06_000685_000722'; %c entering facility
%video = 'VIRAT_S_010005_04_000299_000323'; %c exiting facility
%video = 'VIRAT_S_000201_02_000590_000623'; %inc getting out of car
%video = 'VIRAT_S_010005_06_000475_000499';
%video = 'VIRAT_S_010111_08_000920_000954'; %in
video = 'VIRAT_S_010113_04_000681_000772';

path = ['..\test_videos\', video, '.mp4'];
vid=VideoReader(path);
mkdir('predict\', video);
clc;
disp(video);
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 25:25:n
     frames = read(vid,i);
     imwrite(frames,['predict\', video, '\', video, '_', int2str(i), '.jpg']);
     %im(i)=image(frames);
 end
 
 
 %Compute Features
 
 run('VLFEATROOT\toolbox\vl_setup.m');
%x = 1;
nframes = i/25;
%video = 'VIRAT_S_010000_07_000827_000860';
img = zeros(nframes, 6400);

for i = 25:25:25*nframes
    disp(i/25);
    %display(x);
    
    im = imread(strcat('predict\', video, '\', video, '_' , strcat(num2str(i), '.jpg')));
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
dlmwrite(['predict\', video, '.txt'], img);
%load training features and respective classes
TrainFeatures = load('..\features\feature.txt');
ClassLabel = load('..\features\featureClass.txt');
result = multisvm(TrainFeatures, ClassLabel, img);
dlmwrite(['predict\', video, '_c.txt'], result);


%predict class label
freq = [0 0 0 0 0 0];
for i = 1:1:nframes
   if result(i) == 1
       freq(1) = freq(1) + 1;
   end
   if result(i) == 2
       freq(2) = freq(2) + 1;
   end
   if result(i) == 3
       freq(3) = freq(3) + 1;
   end
   if result(i) == 4
       freq(4) = freq(4) + 1;
   end
   
   if result(i) == 5
       freq(5) = freq(5) + 1;
   end
   
   if result(i) == 6
       freq(6) = freq(6) + 1;
   end
   
end
max = freq(1);
index = 1;
for i = 2:1:6
    if freq(i) > max
        max = freq(i);
        index = i;
    end
end
%disp(index);
disp('Predicted class:');
if index == 1
    disp('Getting Out of Car');
end
if index == 2
    disp('Getting In Car');
end
if index == 3
    disp('Entering Facility');
end
if index == 4
    disp('Exiting Facility');
end
if index == 5
    disp('Carrying Object');
end
if index == 6
    disp('Opening Trunk');
end
