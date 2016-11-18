Project Readme file


******************************
Required packages.
******************************
Matlab R2012a installation package.
VlFEATROOT folder which is in the CD.
copy the VLFEATROOT folder in the installation directory of matlab.
Make the required change in the paths at various locations.
******************************
Dataset
******************************
VIRAT Ground dataset availabe for research purpose available at its official site virat.org.

******************************
Project running
******************************

Frame segmentation and feature extraction using sift. run "sift.m" file in code folder. Change the value of the variable video to get frames of required video.
then after it generates the sift features for that video.

do background subtraction, for motion localization, between each consecutive frame to get if there is activity in the video else discard the frames.

Do this process for all videos and concatenate the results of all text files into one file that is named as 'feature.txt' in features folder.
similar kind of file needs to be generated for class labels of particular file. named as 'featureClass.txt'.

This is the input for next module.
apply multiclass svm over it using svm train and create a model.

******************************
Testing.
******************************
Run main.m providing required video file whose class label needs to be determined and then it will find the optimum class label using the generated model.
Testing videos are given in the foler.


