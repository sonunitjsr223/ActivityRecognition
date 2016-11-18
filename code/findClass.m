TrainFeatures = load('..\features\feature.txt');
ClassLabel = load('..\features\featureClass.txt');
img = load('predict\VIRAT_S_000201_03_000640_000672.txt');

result = multisvm(TrainFeatures, ClassLabel, img);
dlmwrite(['predict\', video, '_c.txt'], result);


%predict class label
freq = [0 0 0 0];
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
end
max = freq(1);
index = 1;
for i = 2:1:4
    if freq(i) > max
        max = freq(i);
        index = i;
    end
end

disp(index);
