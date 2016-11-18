video = 'VIRAT_S_010000_07_000827_000860';

vid=VideoReader('..\test_videos\VIRAT_S_010000_07_000827_000860.mp4');

mkdir('..\img\', video);

 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 25:25:n
 frames = read(vid,i);
 imwrite(frames,['..\img\', video, '\', video, '_', int2str(i), '.jpg']);
 %im(i)=image(frames);
 end