clc

vf1 = load('..\features\feature.txt');

vf2 = load('..\features\VIRAT_S_010001_04_000583_000646.txt');
vf1 = vertcat(vf1, vf2);
vf2 = load('..\features\VIRAT_S_010001_05_000649_000684.txt');
vf1 = vertcat(vf1, vf2);
dlmwrite('..\features\feature.txt', vf1);
