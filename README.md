# Digit-Recognition-Matlab-NN

Data Mining ESEO Project more in-depth exploration. 

These matlab files use normalized pca and neural network learning in order to recognize user generated images of digits.

Demo : run  `guessMe.m`, this will train the neural network with data from `data_set_10_chiffres_APP.mat`. 
You can then use :
`guessImg(prepareImg('name_of_your_file.bmp', columnatZero, mu, sigma, coef),net,classes)`

Accepted image format is black and white 24bits bmp type. (I did some you can found in `images/` folder, you lazy)

*Toolbox scripts written by M. Feuilloy ESEO*
